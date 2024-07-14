#!/usr/bin/env bats

HORSE_STAPLE_PASS_SCRIPT="../src/horseStaplePass.sh"

# horseStaplePass.sh exists ?
@test "horseStaplePass.sh should exist" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    [ -f horseStaplePass.sh ]
}

# Test gen with 4 words
@test "horse staple password generation with 4 words" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    run bash -c "$HORSE_STAPLE_PASS_SCRIPT 4"
    [ "$status" -eq 0 ]
    [ "$(echo "$output" | grep -o '-' | wc -l)" -eq 3 ]

    # Check -
    for word in $(echo "$output" | tr '-' ' '); do
        grep -qx "$word" words.txt
        [ $? -eq 0 ]
    done
}

# Test gen with 6 words
@test "horse staple password generation with 6 words" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    run bash -c "$HORSE_STAPLE_PASS_SCRIPT 6"
    [ "$status" -eq 0 ]
    [ "$(echo "$output" | grep -o '-' | wc -l)" -eq 5 ]

    # Check -
    for word in $(echo "$output" | tr '-' ' '); do
        grep -qx "$word" words.txt
        [ $? -eq 0 ]
    done
}