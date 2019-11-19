
OBJS += techlibs/intel/synth_intel.o techlibs/intel/synth_intel_alm.o

$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/m9k_bb.v))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/altpll_bb.v))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/brams_m9k.txt))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/brams_map_m9k.v))

# Add the cell models and mappings for the VQM backend
families := max10 a10gx cyclonev cyclone10 cycloneiv cycloneive
$(foreach family,$(families), $(eval $(call add_share_file,share/intel/$(family),techlibs/intel/$(family)/cells_sim.v)))
$(foreach family,$(families), $(eval $(call add_share_file,share/intel/$(family),techlibs/intel/$(family)/cells_map.v)))
#$(eval $(call add_share_file,share/intel/cycloneive,techlibs/intel/cycloneive/arith_map.v))

# Techmap
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/alm_map.v))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/alm_sim.v))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/dff_map.v))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/dff_sim.v))

# RAM
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/bram_m10k.txt))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/bram_m10k_map.v))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/lutram_mlab.txt))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/lutram_mlab_map.v))

# ABC9 timing
$(eval $(call add_share_file,share/intel/cyclonev,techlibs/intel/cyclonev/abc9_lut.lut))

# Miscellaneous
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/megafunction_bb.v))
$(eval $(call add_share_file,share/intel/common,techlibs/intel/common/quartus_rename.v))
$(eval $(call add_share_file,share/intel/cyclonev,techlibs/intel/cyclonev/quartus_rename.v))
