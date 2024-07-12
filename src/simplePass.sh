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

# function to generate a password
generate_password() {
    local WORD1
    WORD1=$(get_random_word)
    local WORD2
    WORD2=$(get_random_word)
    local NUMBER=$((10 + RANDOM % 90)) 
    local PASSWORD="${WORD1}${WORD2}${NUMBER}"
    echo "$PASSWORD"
}

generate_password
