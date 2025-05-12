#include <cstdio>
#include <iostream>
#include <memory>
#include <stdexcept>
#include <string>
#include <array>
#include <cstdlib>
#include <cassert>

std::string exec(const char* cmd) {
    std::array<char, 128> buffer;
    std::string result;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(cmd, "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), static_cast<int>(buffer.size()), pipe.get()) != nullptr) {
        result += buffer.data();
    }
    return result;
}

int main(int argc, char** argv, char** /*envp*/) {
    auto r = system("rm -rf obj_dir");
    assert(r == 0);

    // Build command string from argv
    std::string cmd = "/verilator/bin/verilator --lint-only";  // Only check syntax
    for (int i = 1; i < argc; i++) {
        cmd += " ";
        cmd += argv[i];
    }

    try {
        // Run verilator and capture output
        std::string output = exec(cmd.c_str());
        
        // Check for syntax error indicators in output
        if (output.find("Error:") != std::string::npos || 
            output.find("Syntax error") != std::string::npos) {
            return 1;  // Tell AFL this input is invalid
        }
        
        return 0;  // Syntactically valid input
    }
    catch (const std::runtime_error& e) {
        return 2;  // Actual crash or system error
    }
}