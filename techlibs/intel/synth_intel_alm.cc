/*
 *  yosys -- Yosys Open SYnthesis Suite
 *
 *  Copyright (C) 2012  Clifford Wolf <clifford@clifford.at>
 *  Copyright (C) 2019  Dan Ravensloft <dan.ravensloft@gmail.com>
 *
 *  Permission to use, copy, modify, and/or distribute this software for any
 *  purpose with or without fee is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
 *  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
 *  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 *  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
 *  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
 *  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 *
 */

#include "kernel/celltypes.h"
#include "kernel/log.h"
#include "kernel/register.h"
#include "kernel/rtlil.h"

USING_YOSYS_NAMESPACE
PRIVATE_NAMESPACE_BEGIN

struct SynthIntelALMPass : public ScriptPass {
	SynthIntelALMPass() : ScriptPass("synth_intel_alm", "synthesis for ALM-based Intel (Altera) FPGAs.") {}

	void help() YS_OVERRIDE
	{
		//   |---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|
		log("\n");
		log("    synth_intel_alm [options]\n");
		log("\n");
		log("This command runs synthesis for ALM-based Intel FPGAs.\n");
		log("\n");
		log("    -top <module>\n");
		log("        use the specified module as top module (default='top')\n");
		log("\n");
		log("    -vqm <file>\n");
		log("        write the design to the specified Verilog Quartus Mapping File. Writing of an\n");
		log("        output file is omitted if this parameter is not specified.\n");
		log("        Note that this backend has not been tested and is likely incompatible\n");
		log("        with recent versions of Quartus.\n");
		log("\n");
		log("    -run <from_label>:<to_label>\n");
		log("        only run the commands between the labels (see below). an empty\n");
		log("        from label is synonymous to 'begin', and empty to label is\n");
		log("        synonymous to the end of the command list.\n");
		log("\n");
		log("    -nolutram\n");
		log("        do not use LUT RAM cells in output netlist\n");
		log("\n");
		log("    -nobram\n");
		log("        do not use block RAM cells in output netlist\n");
		log("\n");
		log("    -noflatten\n");
		log("        do not flatten design before synthesis\n");
		log("\n");
		log("The following commands are executed by this synthesis command:\n");
		help_script();
		log("\n");
	}

	string top_opt, family_opt, vout_file;
	bool flatten, nolutram, nobram;

	void clear_flags() YS_OVERRIDE
	{
		top_opt = "-auto-top";
		family_opt = "cyclonev";
		vout_file = "";
		flatten = true;
		nolutram = false;
		nobram = false;
	}

	void execute(std::vector<std::string> args, RTLIL::Design *design) YS_OVERRIDE
	{
		string run_from, run_to;
		clear_flags();

		size_t argidx;
		for (argidx = 1; argidx < args.size(); argidx++) {
			if (args[argidx] == "-family" && argidx + 1 < args.size()) {
				family_opt = args[++argidx];
				continue;
			}
			if (args[argidx] == "-top" && argidx + 1 < args.size()) {
				top_opt = "-top " + args[++argidx];
				continue;
			}
			if (args[argidx] == "-vqm" && argidx + 1 < args.size()) {
				vout_file = args[++argidx];
				continue;
			}
			if (args[argidx] == "-run" && argidx + 1 < args.size()) {
				size_t pos = args[argidx + 1].find(':');
				if (pos == std::string::npos)
					break;
				run_from = args[++argidx].substr(0, pos);
				run_to = args[argidx].substr(pos + 1);
				continue;
			}
			if (args[argidx] == "-nolutram") {
				nolutram = true;
				continue;
			}
			if (args[argidx] == "-nobram") {
				nobram = true;
				continue;
			}
			if (args[argidx] == "-noflatten") {
				flatten = false;
				continue;
			}
			break;
		}
		extra_args(args, argidx, design);

		if (!design->full_selection())
			log_cmd_error("This command only operates on fully selected designs!\n");
		if (family_opt != "cyclonev")
			log_cmd_error("Invalid or no family specified: '%s'\n", family_opt.c_str());

		log_header(design, "Executing SYNTH_INTEL_ALM pass.\n");
		log_push();

		run_script(design, run_from, run_to);

		log_pop();
	}

	void script() YS_OVERRIDE
	{
		if (check_label("begin")) {
			run(stringf("read_verilog -sv -lib +/intel/%s/cells_sim.v", family_opt.c_str()));
			run("read_verilog -lib +/intel/common/alm_sim.v");
			run("read_verilog -lib +/intel/common/dff_sim.v");

			// Misc and common cells
			run("read_verilog -lib +/intel/common/altpll_bb.v");
			run("read_verilog -lib +/intel/common/megafunction_bb.v");
			run(stringf("hierarchy -check %s", help_mode ? "-top <top>" : top_opt.c_str()));
		}

		if (flatten && check_label("flatten", "(unless -noflatten)")) {
			run("proc");
			run("flatten");
			run("tribuf -logic");
			run("deminout");
		}

		if (check_label("coarse")) {
			run("synth -run coarse");
		}

		if (!nolutram && check_label("map_lutram", "(skip if -nolutram)")) {
			run("memory_bram -rules +/intel/common/lutram_mlab.txt", "(for Cyclone V)");
			run("techmap -map +/intel/common/lutram_mlab_map.v", "(for Cyclone V)");
		}

		if (!nobram && check_label("map_bram", "(skip if -nobram)")) {
			run("memory_bram -rules +/intel/common/bram_m10k.txt", "(for Cyclone V)");
			run("techmap -map +/intel/common/bram_m10k_map.v", "(for Cyclone V)");
		}

		if (check_label("map_ffram")) {
			run("memory_map");
			run("opt -full");
		}

		if (check_label("map_ffs")) {
			run("dffsr2dff");
			run("dff2dffs");
			run("dff2dffe -direct-match $_DFF_* -direct-match $__DFFS_*");
			run("techmap");
			run("techmap -map +/intel/common/dff_map.v");
			run("techmap");
			run("dffinit -ff MISTRAL_FF Q INIT");
			run("opt -full -undriven -mux_undef");
			run("clean -purge");
		}

		if (check_label("map_luts")) {
			run(stringf("abc9 -lut +/intel/%s/abc9_lut.lut -nomfs", family_opt.c_str()));
			run("techmap -map +/intel/common/alm_map.v");
			run("clean");
		}

		if (check_label("check")) {
			run("hierarchy -check");
			run("stat");
			run("check");
		}

		if (check_label("vqm")) {
			if (!vout_file.empty() || help_mode) {
				run(stringf("techmap -map +/intel/%s/quartus_rename.v", family_opt.c_str()));
				run("techmap -map +/intel/common/quartus_rename.v");
				run(stringf("write_verilog -attr2comment -defparam -nohex -decimal %s",
					    help_mode ? "<file-name>" : vout_file.c_str()));
			}
		}
	}
} SynthIntelALMPass;

PRIVATE_NAMESPACE_END
