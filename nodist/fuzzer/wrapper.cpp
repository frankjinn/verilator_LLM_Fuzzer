#include <cstdlib>
#include <cstdio>
#include <unistd.h>
#include <sys/wait.h>
#include <cassert>

// __AFL_FUZZ_INIT();

// #define MAX_ITERATIONS 10000

// int main(int argc, char** argv, char** envp) {
//     // Initial cleanup should be outside the persistence loop
//     int r = system("rm -rf obj_dir");
//     assert(r == 0);

//     #ifdef __AFL_HAVE_MANUAL_CONTROL
//     __AFL_INIT();
//     #endif

//     // Get the fuzzing buffer before entering the persistence loop
//     unsigned char *buf = __AFL_FUZZ_TESTCASE_BUF;

//     // Main persistence loop
//     while (__AFL_LOOP(MAX_ITERATIONS)) {
//         // Create a new process for each iteration
//         pid_t pid = vfork();
        
//         if (pid == -1) {
//             _exit(1);
//         }

//         if (pid == 0) {
//             // Child process
//             execve("/verilator/bin/verilator", argv, envp);
//             _exit(42);
//         }

//         // Parent process
//         int status;
//         if (waitpid(pid, &status, 0) == -1) {
//             _exit(1);
//         }

//         // Clean up obj_dir after each iteration
//         r = system("rm -rf obj_dir");
//         assert(r == 0);

//         // Reset any global state here if needed
//     }

//     return 0;
// }

int main(int argc, char** argv, char** envp) {
    auto r = system("rm -rf obj_dir");
    assert(r == 0);
    return execve("../../bin/verilator_bin", argv, envp);
}

// int main(int argc, char** argv, char** envp) {
//     // Initial cleanup outside the persistence loop
//     auto r = system("rm -rf obj_dir");
//     assert(r == 0);

//     #ifdef __AFL_HAVE_MANUAL_CONTROL
//     __AFL_INIT();
//     #endif

//     while (__AFL_LOOP(10000)) {
//         r = execve("../../bin/verilator_bin", argv, envp);
//         if (r == -1) {
//             perror("execve failed");
//             _exit(1);
//         }

//         // Clean up between iterations
//         r = system("rm -rf obj_dir");
//         assert(r == 0);
//     }

//     return 0;
// }