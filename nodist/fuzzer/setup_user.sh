#!/bin/bash
######################################################################
# DESCRIPTION: Fuzzer setup to be run as a normal user
######################################################################

# This is the portion of the setup for fuzzing that does not require root access.

set -e

# Build instrumented version of verilator
pushd ../..
autoconf
AFL_HARDEN=1 CC=afl-clang-fast CXX=afl-clang-fast++ ./configure $(cd ..; pwd)
make clean
make -j $(ncpus)
popd

# Create a listing of likely snippets for the fuzzer to use.
# Not essential, but makes things likely to be found faster.
./generate_dictionary

# Compile wrapper program
AFL_HARDEN=1 CXX=afl-clang-fast++ make wrapper
