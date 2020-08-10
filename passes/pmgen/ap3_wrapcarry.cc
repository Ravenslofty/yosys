/*
 *  yosys -- Yosys Open SYnthesis Suite
 *
 *  Copyright (C) 2012  Clifford Wolf <clifford@clifford.at>
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

#include "kernel/yosys.h"
#include "kernel/sigtools.h"

USING_YOSYS_NAMESPACE
PRIVATE_NAMESPACE_BEGIN

#include "passes/pmgen/ap3_wrapcarry_pm.h"

void create_ap3_wrapcarry(ap3_wrapcarry_pm &pm)
{
	auto &st = pm.st_ap3_wrapcarry;

#if 0
	log("\n");
	log("carry: %s\n", log_id(st.carry, "--"));
	log("lut:   %s\n", log_id(st.lut, "--"));
#endif

	log("  replacing LUT4 + QL_CARRY with $__AP3_CARRY_WRAPPER cell.\n");

	Cell *cell = pm.module->addCell(NEW_ID, ID($__AP3_CARRY_WRAPPER));
	pm.module->swap_names(cell, st.carry);

	cell->setPort(ID::A, st.carry->getPort(ID(I0)));
	cell->setPort(ID::B, st.carry->getPort(ID(I1)));
	auto CI = st.carry->getPort(ID::CI);
	cell->setPort(ID::CI, CI);
	cell->setPort(ID::CO, st.carry->getPort(ID::CO));

	auto I2 = st.lut->getPort(ID(I2));
	if (pm.sigmap(CI) == pm.sigmap(I2)) {
		cell->setParam(ID(I2_IS_CI), State::S1);
		I2 = State::Sx;
	}
	else
		cell->setParam(ID(I2_IS_CI), State::S0);
	cell->setPort(ID(I2), I2);
	cell->setPort(ID(I3), st.lut->getPort(ID(I3)));
	cell->setPort(ID::O, st.lut->getPort(ID::O));
	cell->setParam(ID::LUT, st.lut->getParam(ID(INIT)));

	for (const auto &a : st.carry->attributes)
		cell->attributes[stringf("\\QL_CARRY.%s", a.first.c_str())] = a.second;
	for (const auto &a : st.lut->attributes)
		cell->attributes[stringf("\\LUT4.%s", a.first.c_str())] = a.second;
	cell->attributes[ID(LUT4.name)] = Const(st.lut->name.str());
	if (st.carry->get_bool_attribute(ID::keep) || st.lut->get_bool_attribute(ID::keep))
		cell->attributes[ID::keep] = true;

	pm.autoremove(st.carry);
	pm.autoremove(st.lut);
}

struct AP3WrapCarryPass : public Pass {
	AP3WrapCarryPass() : Pass("ap3_wrapcarry", "AP3: wrap carries") { }
	void help() YS_OVERRIDE
	{
		//   |---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|---v---|
		log("\n");
		log("    ap3_wrapcarry [selection]\n");
		log("\n");
		log("Wrap manually instantiated QL_CARRY cells, along with their associated LUT4s,\n");
		log("into an internal $__AP3_CARRY_WRAPPER cell for preservation across technology\n");
		log("mapping.\n");
		log("\n");
		log("Attributes on both cells will have their names prefixed with 'QL_CARRY.' or\n");
		log("'LUT4.' and attached to the wrapping cell.\n");
		log("A (* keep *) attribute on either cell will be logically OR-ed together.\n");
		log("\n");
		log("    -unwrap\n");
		log("        unwrap $__AP3_CARRY_WRAPPER cells back into QL_CARRYs and LUT4s,\n");
		log("        including restoring their attributes.\n");
		log("\n");
	}
	void execute(std::vector<std::string> args, RTLIL::Design *design) YS_OVERRIDE
	{
		bool unwrap = false;

		log_header(design, "Executing ap3_wrapcarry pass (wrap carries).\n");

		size_t argidx;
		for (argidx = 1; argidx < args.size(); argidx++)
		{
			if (args[argidx] == "-unwrap") {
				unwrap = true;
				continue;
			}
			break;
		}
		extra_args(args, argidx, design);

		for (auto module : design->selected_modules()) {
			if (!unwrap) {
				ap3_wrapcarry_pm(module, module->selected_cells()).run_ap3_wrapcarry(create_ap3_wrapcarry);
			} else {
				for (auto cell : module->selected_cells()) {
					if (cell->type != ID($__AP3_CARRY_WRAPPER))
						continue;

					auto carry = module->addCell(NEW_ID, ID(QL_CARRY));
					carry->setPort(ID(I0), cell->getPort(ID::A));
					carry->setPort(ID(I1), cell->getPort(ID::B));
					carry->setPort(ID::CI, cell->getPort(ID::CI));
					carry->setPort(ID::CO, cell->getPort(ID::CO));
					module->swap_names(carry, cell);
					auto lut_name = cell->attributes.at(ID(LUT4.name), Const(NEW_ID.str())).decode_string();
					auto lut = module->addCell(lut_name, ID($lut));
					lut->setParam(ID::WIDTH, 4);
					lut->setParam(ID::LUT, cell->getParam(ID::LUT));
					auto I2 = cell->getPort(cell->getParam(ID(I2_IS_CI)).as_bool() ? ID::CI : ID(I2));
					lut->setPort(ID::A, {cell->getPort(ID(I3)), I2, cell->getPort(ID::B), cell->getPort(ID::A)});
					lut->setPort(ID::Y, cell->getPort(ID::O));

					Const src;
					for (const auto &a : cell->attributes)
						if (a.first.begins_with("\\QL_CARRY.\\"))
							carry->attributes[a.first.c_str() + strlen("\\QL_CARRY.")] = a.second;
						else if (a.first.begins_with("\\LUT4.\\"))
							lut->attributes[a.first.c_str() + strlen("\\LUT4.")] = a.second;
						else if (a.first == ID::src)
							src = a.second;
						else if (a.first.in(ID(LUT4.name), ID::keep, ID::module_not_derived))
							continue;
						else
							log_abort();

					if (!src.empty()) {
						carry->attributes.insert(std::make_pair(ID::src, src));
						lut->attributes.insert(std::make_pair(ID::src, src));
					}

					module->remove(cell);
				}
			}
		}
	}
} AP3WrapCarryPass;

PRIVATE_NAMESPACE_END
