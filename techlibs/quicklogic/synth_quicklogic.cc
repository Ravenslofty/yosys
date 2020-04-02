#include "kernel/register.h"
#include "kernel/celltypes.h"
#include "kernel/rtlil.h"
#include "kernel/log.h"

USING_YOSYS_NAMESPACE
PRIVATE_NAMESPACE_BEGIN

struct SynthQuickLogicPass : public ScriptPass
{
    SynthQuickLogicPass() : ScriptPass("synth_quicklogic", "Synthesis for QuickLogic FPGAs") { }

    void help() YS_OVERRIDE
    {
        log("\n");
        log("   synth_quicklogic [options]\n");
        log("This command runs synthesis for QuickLogic FPGAs\n");
        log("\n");
        log("    -top <module>\n");
        log("         use the specified module as top module\n");
        log("\n");
        log("    -edif <file>\n");
        log("        write the design to the specified edif file. writing of an output file\n");
        log("        is omitted if this parameter is not specified.\n");
        log("\n");
        log("    -blif <file>\n");
        log("        write the design to the specified BLIF file. writing of an output file\n");
        log("        is omitted if this parameter is not specified.\n");
        log("\n");
        log("    -flatten\n");
        log("        flatten design before synthesis\n");
        log("\n");
        help_script();
        log("\n");
    }

    std::string top_opt = "-auto-top";
    std::string edif_file = "";
    std::string blif_file = "";
    std::string currmodule = "";
    bool flatten = false;

    void clear_flags() YS_OVERRIDE
    {
        top_opt = "-auto-top";
        flatten = false;
        edif_file.clear();
        blif_file.clear();
    }

    void execute(std::vector<std::string> args, RTLIL::Design *design) YS_OVERRIDE
    {
        std::string run_from, run_to;
        clear_flags();

        size_t argidx;
        for (argidx = 1; argidx < args.size(); argidx++)
        {
            if (args[argidx] == "-top" && argidx+1 < args.size()) {
                top_opt = "-top " + args[++argidx];
                continue;
            }
            if (args[argidx] == "-edif" && argidx+1 < args.size()) {
                edif_file = args[++argidx];
                continue;
            }
            if (args[argidx] == "-blif" && argidx+1 < args.size()) {
                blif_file = args[++argidx];
                continue;
            }
            if (args[argidx] == "-flatten") {
                flatten = true;
                continue;
            }
            break;
        }
        extra_args(args, argidx, design);

        if (!design->full_selection())
            log_cmd_error("This command only operates on fully selected designs!\n");

        log_header(design, "Executing SYNTH_QUICKLOGIC pass.\n");
        log_push();

        run_script(design, run_from, run_to);

        log_pop();
    }

    void script() YS_OVERRIDE
    {
        if (check_label("begin")) {
            run("read_verilog -lib +/quicklogic/cells_sim.v");
            run(stringf("hierarchy -check %s", top_opt.c_str()));
        }

        if (check_label("prepare")) {
            run("proc");
            if (flatten || help_mode)
                run("flatten", "(with '-flatten')");
            run("tribuf -logic");
            run("opt_expr");
            run("opt_clean");
            run("check");
            run("opt");
            run("peepopt");
            run("opt_clean");
            run("techmap");
            run("abc -lut 1:4");
            run("opt_clean");
            run("techmap -map +/quicklogic/cells_map.v");
            run("clean");
            run("check");
            run("opt_clean -purge");
            if (help_mode) {
                run("select -module top");
            } else {
                this->currmodule = this->active_design->top_module()->name.str();
                if (this->currmodule.size() > 0)
                    run(stringf("select -module %s", this->currmodule.c_str()));
            }
            run("select -set clock_inputs */t:dff* %x:+[CLK,CLR,PRE] */t:dff* %d");
            run("select -set invclock_inputs */t:dff* %x:+[CLK,CLR,PRE] */t:dff* %d %n");
            run("iopadmap -bits -inpad ckpad Q:P @clock_inputs");
            run("iopadmap -bits -outpad outpad A:P -inpad inpad Q:P @invclock_inputs");
            run("iopadmap -bits -tinoutpad bipad EN:Q:A:P");
            if (help_mode) {
                run("select -clear");
            } else if (this->currmodule.size() > 0)
                run("select -clear");
            run("splitnets -ports -format ()");
            run("hilomap -hicell logic_1 a -locell logic_0 a -singleton");
            run("techmap -map +/quicklogic/cells_map.v");
            run("setundef -zero -params -undriven -expose");
            run("opt_clean");
            run("clean -purge");
            run("opt");
        }

        if (check_label("edif")) {
            if (!edif_file.empty() || help_mode) {
                    run(stringf("write_edif -nogndvcc -attrprop -pvector par -top %s %s", this->currmodule.c_str(), edif_file.c_str()));
            }
        }

        if (check_label("blif")) {
            if (!blif_file.empty() || help_mode)
                run(stringf("write_blif %s %s", top_opt.c_str(), blif_file.c_str()));
        }
    }
} SynthQuickLogicPass;

PRIVATE_NAMESPACE_END
