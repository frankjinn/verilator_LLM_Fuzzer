#!/bin/bash
######################################################################
# DESCRIPTION: Fuzzer one-line setup & run
######################################################################

# Run all steps needed to configure and start fuzzer
# Note that this assumes the system is a Debian-like Linux distribution

set -e

# CPU performance changes, can't do this on a server.
# sudo ./setup_root.sh

./setup_user.sh
# ./run
