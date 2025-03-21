###############################################################################
#                             Valkyrie test runner                            #
#                                                                             #
#                          Por Benjamín Peña @ 2024-2                         #
#                                                                             #
#                           Licensed under GPL v3.0                           #
###############################################################################

#!/bin/bash

PURPLE='\033[0;35m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NeutralColor='\033[0m'

CONFIG_FILE="valkyrie.config"

# Load configuration file
load_config() {
    if [ ! -f "$CONFIG_FILE" ]; then
        echo -e "${RED}Error: Configuration file '$CONFIG_FILE' not found!${NeutralColor}"
        exit 1
    fi
    source "$CONFIG_FILE"
}

run_single_test() {
    local test_name=$1
    local show_diff=$2

    local input_file="$TESTS_FOLDER/$test_name/input.txt"
    local expected_output="$TESTS_FOLDER/$test_name/output.txt"

    # Reviso que existan los archivos
    if [ ! -f "$input_file" ] || [ ! -f "$expected_output" ] || [ ! -f "$TEST_OUTPUT_FILE" ]; then
        echo -e "${YELLOW}Skipping test $test_name: Missing input or output file (see ${CONFIG_FILE}).${NeutralColor}"
        return
    fi

    # Ejecución del código
    start_time=$(date +%s%N)
    $EXEC "$input_file" "$TEST_OUTPUT_FILE" > /dev/null 2>&1
    end_time=$(date +%s%N)

    # Calcula el runtime (en ms)
    runtime=$(( (end_time - start_time) / 1000000 ))

    # Comparación de outputs
    diff_count=$(diff "$TEST_OUTPUT_FILE" "$expected_output" | grep "^>" | wc -l)

    # Resultado del test
    if [ "$diff_count" -eq 0 ] && [ "$runtime" -le "$MAX_RUNTIME" ]; then
        result="${GREEN}PASSED${NeutralColor}"
    else
        fail_reason=""
        if [ "$runtime" -gt "$MAX_RUNTIME" ]; then
            fail_reason="${fail_reason}Runtime exceeded (${runtime}ms) "
        fi
        if [ "$diff_count" -gt 0 ]; then
            if [ "$diff_count" -gt 1 ]; then
                fail_reason="${fail_reason}Output difference (${diff_count} lines) "
            else
                fail_reason="${fail_reason}Output difference (${diff_count} line) "
            fi
        fi
        
        result="${RED}FAILED: $fail_reason${NeutralColor}"
    fi
    echo -e "Test $test_name: $result (Runtime: ${runtime}ms)"

    # Mostrar diff de outputs en caso de que se incluya la flag
    if [ "$show_diff" == "--showdiff" ] && [ "$diff_count" -gt 0 ]; then
        echo -e "${YELLOW}Diff between expected and actual output:${NeutralColor}"
        diff "$TEST_OUTPUT_FILE" "$expected_output" | sed 's/^/> /'
    fi
}

run_all_tests() {
    for test_case in $(ls "$TESTS_FOLDER"); do
        run_single_test "$test_case" "$1"
    done
}

# Main
main() {
    load_config
    echo -e "${PURPLE}Valkyrie test runner${NeutralColor}"
    echo "================"

    if [ "$1" == "--test" ] && [ ! -z "$2" ]; then
        run_single_test "$2" "$3"
    else
        run_all_tests "$1"
    fi

    echo "================"
    echo "All tests completed."
}

# Execute main
main "$@"
