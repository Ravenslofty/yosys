
OBJS += techlibs/quicklogic/synth_quicklogic.o
#OBJS += techlibs/quicklogic/quicklogic_fixcarry.o

$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/ap3_ffs_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/pp3_ffs_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/ap3_lut_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/pp3_lut_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/ap3_latches_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/pp3_latches_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/ap3_cells_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/ap3_arith_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/pp3_cells_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/cells_sim.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/pp3_cells_sim.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/ap3_cells_sim.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/FIFO_16K_BLK.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/RAM_16K_BLK.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/MULT_16BIT_X2.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/MULT_32BIT.v))
