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
    PASSWORD_LINE=$(echo "$output" | grep "Your generated horse-staple password is:" | cut -d: -f2 | tr -d ' ')
    [ "$(echo "$PASSWORD_LINE" | grep -o '-' | wc -l)" -eq 3 ]

    # Check that each part is a word from the words.txt file
    for word in $(echo "$PASSWORD_LINE" | grep -Eo '[^-]+'); do
        grep -qx "$word" words.txt
        [ $? -eq 0 ]
    done

    # Check the output for pwned password message
    echo "$output" | grep -qE "The generated password is safe|Oh no — pwned!"
}

# Test gen with 6 words
@test "horse staple password generation with 6 words" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    run bash -c "$HORSE_STAPLE_PASS_SCRIPT 6"
    [ "$status" -eq 0 ]
    PASSWORD_LINE=$(echo "$output" | grep "Your generated horse-staple password is:" | cut -d: -f2 | tr -d ' ')
    [ "$(echo "$PASSWORD_LINE" | grep -o '-' | wc -l)" -eq 5 ]

    # Check -
    for word in $(echo "$PASSWORD_LINE" | grep -Eo '[^-]+'); do
        grep -qx "$word" words.txt
        [ $? -eq 0 ]
    done

    # Check the output for pwned password message
    echo "$output" | grep -qE "The generated password is safe|Oh no — pwned!"
}
