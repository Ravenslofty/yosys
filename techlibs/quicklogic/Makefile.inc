
OBJS += techlibs/quicklogic/synth_quicklogic.o

GENFILES += techlibs/quicklogic/brams_init_9.vh
GENFILES += techlibs/quicklogic/brams_init_18.vh

$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/cells_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/pp3_brams.txt))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/pp3_brams_map.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/cells_sim.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/FIFO_16K_BLK.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/RAM_16K_BLK.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/MULT_16BIT_X2.v))
$(eval $(call add_share_file,share/quicklogic,techlibs/quicklogic/MULT_32BIT.v))

EXTRA_OBJS += techlibs/quicklogic/brams_init.mk 
.SECONDARY: techlibs/quicklogic/brams_init.mk 

techlibs/quicklogic/brams_init.mk: techlibs/quicklogic/brams_init.py
	$(Q) mkdir -p techlibs/quicklogic
	$(P) $(PYTHON_EXECUTABLE) $<
	$(Q) touch $@


techlibs/quicklogic/brams_init_9.vh: techlibs/quicklogic/brams_init.mk
techlibs/quicklogic/brams_init_18.vh: techlibs/quicklogic/brams_init.mk

$(eval $(call add_gen_share_file,share/quicklogic,techlibs/quicklogic/brams_init_9.vh))
$(eval $(call add_gen_share_file,share/quicklogic,techlibs/quicklogic/brams_init_18.vh))

