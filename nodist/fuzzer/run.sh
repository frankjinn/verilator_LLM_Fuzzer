#!/bin/bash
######################################################################
# DESCRIPTION: Fuzzer run script
######################################################################

# Actually do the fuzzing.  Note that this will not terminate in any reasonable
# amount of time.  However, it will give updates on its progress.
AFL_I_DONT_CARE_ABOUT_MISSING_CRASHES=1 AFL_SKIP_CPUFREQ=1 afl-fuzz -i in1 -o out1 -x dictionary ./wrapper --cc @@
