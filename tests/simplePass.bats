#!/usr/bin/env bats

# Set up the path to the simplePass script
SIMPLE_PASS_SCRIPT="../src/simplePass.sh"

# Test to ensure words.txt file exists
@test "words.txt should exist" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    [ -f words.txt ]
}

# Test simple password generation
@test "simple password generation" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    run $SIMPLE_PASS_SCRIPT

    [ "$status" -eq 0 ]

    [ -n "$output" ]
}
