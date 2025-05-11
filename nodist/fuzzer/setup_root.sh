#!/bin/bash
######################################################################
# DESCRIPTION: Fuzzer setup to be run as root
######################################################################

# This is the portion of the fuzzer setup that must be run as root.
# Note that this assumes a Debian-like distribution.

set -e

# Get dependencies
apt-get install afl mdm
apt-get build-dep verilator

# Run a couple pieces of setup which should speed up the fuzzer
echo core >/proc/sys/kernel/core_pattern

cd /sys/devices/system/cpu
echo performance | tee cpu*/cpufreq/scaling_governor
