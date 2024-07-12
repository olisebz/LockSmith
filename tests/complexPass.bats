#!/usr/bin/env bats

# Set up the path to the complexPass script
COMPLEX_PASS_SCRIPT="../src/complexPass.sh"

# Test to ensure complexPass.sh script exists
@test "complexPass.sh should exist" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    [ -f complexPass.sh ]
}

# Test complex password generation
@test "complex password generation" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    run bash -c "$COMPLEX_PASS_SCRIPT <<< $'0\n0\n1\n0'"
    [ "$status" -eq 0 ]
    [ ${#output} -eq 1 ]

    run bash -c "$COMPLEX_PASS_SCRIPT <<< $'1\n1\n1\n1'"
    [ "$status" -eq 0 ]
    [ ${#output} -eq 4 ]
    [[ "$output" =~ [A-Z] ]]
    [[ "$output" =~ [a-z] ]]
    [[ "$output" =~ [0-9] ]]

    run bash -c "$COMPLEX_PASS_SCRIPT <<< $'2\n2\n2\n2'"
    [ "$status" -eq 0 ]
    [ ${#output} -eq 8 ]
    [[ "$output" =~ [A-Z] ]]
    [[ "$output" =~ [a-z] ]]
    [[ "$output" =~ [0-9] ]]
}
