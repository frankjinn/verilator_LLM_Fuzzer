import argparse
import os
import re
import subprocess
import shutil

def clear_coverage_reports():
    reports_dir = "/verilator/coverage_reports"
    if os.path.exists(reports_dir):
        # Remove all files in the directory
        shutil.rmtree(reports_dir)
    # Create fresh directory
    os.makedirs(reports_dir)

def main(test_path, src_path):
    if not os.path.isdir(test_path):
        print(f"{test_path} is not a valid directory")
        return
    if not os.path.isdir(src_path):
        print(f"{src_path} is not a valid directory")
        return
    
    files = os.listdir(test_path)
    clear_coverage_reports()
    
    print("Number of tests: ", len(files))
    test_count = 0
    coverage_checkpoints = [0, 1, 2, 3, 5, 7, 10, 15, 20, 30, 40, 50, 60, 70, 80, 90]
    for test in files:
        print(f"Running test: {test_count}/{len(files)}")
        #First Verilate
        verilator_cmd  = f"""$VERILATOR_ROOT/bin/verilator --cc --binary -Wno-MULTIDRIVEN --Wno-UNOPTFLAT --Wno-NOLATCH --Wno-WIDTHTRUNC --Wno-CMPCONST --Wno-WIDTHEXPAND --Wno-UNSIGNED \
                            {test_path}/{test}"""
        p = subprocess.Popen([verilator_cmd], shell=True, cwd=src_path)
        p.wait()

        #Second create json for the run
        gcovr_cmd = f"gcovr --json -o /verilator/coverage_reports/{test}.json -e '(.*/)?(V3Coverage\.cpp|V3CoverageJoin\.cpp|V3EmitCMake\.cpp|V3EmitXml\.cpp|V3ExecGraph\.cpp|V3GraphTest\.cpp|V3HierBlock\.cpp|V3Trace\.cpp|V3TraceDecl\.cpp|.*\.h)$' --root /verilator/src"
        p = subprocess.Popen([gcovr_cmd], shell=True, cwd=src_path)
        p.wait()

        #For every 5 tests ran, or for every manually selected checkpoint, compile reports and give html report
        # if test_count % 5 == 0 and test_count != 0:
        if test_count in coverage_checkpoints:
            gcovr_merge = f"gcovr --html -a '/verilator/coverage_reports/*.json' -o /verilator/coverage_reports/mergeReport_{test_count}_html.html"
            p = subprocess.Popen([gcovr_merge], shell=True, cwd=src_path)
            p.wait()
        test_count += 1
    
    #Third merge jsons and form html
    gcovr_merge = f"gcovr --html --html-details -a '/verilator/coverage_reports/*.json' -o /verilator/coverage_reports/mergeReport_{test_count}.html"
    p = subprocess.Popen([gcovr_merge], shell=True, cwd=src_path)
    p.wait()

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
                    prog='coverageScript',
                    description='Runs Transfuzz generated circuits and compiles code coverage across all circuits')
    parser.add_argument('test_path', help="Folder of the test files") # positional argument
    parser.add_argument('verilator_src_path', help="Folder of the Verilator source files")

    args = parser.parse_args()
    print(args.test_path, args.verilator_src_path)

    main(args.test_path, args.verilator_src_path)