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