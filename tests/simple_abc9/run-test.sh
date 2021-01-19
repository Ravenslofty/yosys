#!/bin/bash

OPTIND=1
seed=""    # default to no seed specified
while getopts "S:" opt
do
    case "$opt" in
	S) arg="${OPTARG#"${OPTARG%%[![:space:]]*}"}" # remove leading space
	   seed="SEED=$arg" ;;
    esac
done
shift "$((OPTIND-1))"

# check for Icarus Verilog
if ! command -v iverilog > /dev/null ; then
  echo "$0: Error: Icarus Verilog 'iverilog' not found."
  exit 1
fi

cp ../simple/*.v .
cp ../simple/*.sv .
DOLLAR='?'
exec ${MAKE:-make} -f ../tools/autotest.mk $seed *.v *.sv EXTRA_FLAGS="-n 300 -p '\
    read_verilog -icells -lib +/abc9_model.v; \
    read_verilog -specify ../muxf7.v; \
    hierarchy; \
    synth -run coarse; \
    opt -full; \
    techmap; \
    abc9 -lut 4 -box ../abc9.box; \
    clean; \
    check -assert * abc9_test037 %d; \
    select -assert-none t:${DOLLAR}_NOT_ t:${DOLLAR}_AND_ %%; \
    setattr -mod -unset blackbox -unset whitebox'"

# NOTE: Skip 'check -assert' on abc9_test037 because it intentionally has a combinatorial loop
