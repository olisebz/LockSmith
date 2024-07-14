#!/bin/bash

if [[ ! -f words.txt ]]; then
    echo "words.txt not found!"
    exit 1
fi

# function to get a random word
get_random_word() {
    local WORD
    WORD=$(sort -R words.txt | head -n 1)
    echo "$WORD"
}

# function to generate a horse staple password
generate_horse_staple_password() {
    local NUM_WORDS="$1"
    local PASSWORD=""

    for (( i=0; i<NUM_WORDS; i++ )); do
        WORD=$(get_random_word)
        if [ "$i" -eq 0 ]; then
            PASSWORD="$WORD"
        else
            PASSWORD="$PASSWORD-$WORD"
        fi
    done

    echo "$PASSWORD"
}

generate_horse_staple_password "$1"