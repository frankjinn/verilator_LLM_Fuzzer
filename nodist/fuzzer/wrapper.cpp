#include <cstdlib>
#include <cstdio>
#include <unistd.h>
#include <sys/wait.h>
#include <cassert>

int main(int argc, char** argv, char** envp) {
    // Use direct unlink calls instead of system() for faster directory removal
    unlink("obj_dir");

    pid_t pid = vfork(); // Use vfork() instead of fork() for better performance
    if (pid == -1) {
        perror("vfork failed");
        _exit(1); // Use _exit() instead of abort() for faster termination
    } 
    
    if (pid == 0) {
        // Child process
        execve("/verilator/bin/verilator", argv, envp);
        _exit(42); // Remove perror to reduce syscalls
    }

    // Parent process
    int status;
    if (waitpid(pid, &status, 0) == -1) {
        _exit(1); // Faster termination
    }

    // Simplified status check
    if (WIFEXITED(status)) {
        _exit(WEXITSTATUS(status) ? 1 : 0);
    }
    
    _exit(1);
}