#include <cstdlib>
#include <cstdio>
#include <unistd.h>
#include <sys/wait.h>
#include <cassert>

int main(int argc, char** argv, char** envp) {
    int r = system("rm -rf obj_dir");
    assert(r == 0); // Ensure the command executed successfully

    pid_t pid = fork();
    if (pid == -1) {
        perror("fork failed");
        abort(); // Crash on fork failure
    } else if (pid == 0) {
        // Child process
        execve("/verilator/bin/verilator", argv, envp);
        // If execve fails, exit with 42
        perror("execve failed");
        _exit(42);
    } else {
        // Parent process
        int status;
        if (waitpid(pid, &status, 0) == -1) {
            perror("waitpid failed");
            abort(); // Crash on wait failure
        }

        if (WIFEXITED(status) && WEXITSTATUS(status) == 0) {
            // Child exited with code 0 → treat as success (non-crash)
            return 0;
        } else {
            // Any error in child → treat as crash
            fprintf(stderr, "[!] Child failed with status %d\n", status);
            abort();
        }
    }
}