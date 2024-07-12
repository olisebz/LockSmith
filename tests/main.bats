#!/usr/bin/env bats

# Set up the path to the main script
MAIN_SCRIPT="../src/main.sh"

# Test to ensure main.sh script exists
@test "main.sh should exist" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    [ -f main.sh ]
}

# Test main script for simple password generation
@test "main script simple password generation" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    run bash -c "echo -e '1\n' | $MAIN_SCRIPT"
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -ge 1 ]

    # Check the output lines for the expected strings
    run_output="${output}"
    echo "${run_output}" | grep "The total length of the password is:"
    echo "${run_output}" | grep "Your generated password is:"
}

# Test main script for complex password generation
@test "main script complex password generation" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    run bash -c "echo -e '2\n1\n1\n1\n1\n' | $MAIN_SCRIPT"
    [ "$status" -eq 0 ]
    [ "${#lines[@]}" -ge 1 ]

    # Check the output lines for the expected strings
    run_output="${output}"
    echo "${run_output}" | grep "The total length of the password is:"
    echo "${run_output}" | grep "Your generated password is:"
}

