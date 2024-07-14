#!/bin/bash

# Check if words.txt exists
if [[ ! -f words.txt ]]; then
    echo "words.txt not found!"
    exit 1
fi

# Function to get a random word
get_random_word() {
    local WORD
    WORD=$(sort -R words.txt | head -n 1)
    echo "$WORD"
}

# Function to generate a horse-staple password
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

# check pwned
check_password_pwned () {
    local PASSWORD="$1"
    local SHA1
    SHA1=$(echo -n "$PASSWORD" | shasum -a 1 | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]')
    local PREFIX=${SHA1:0:5}
    local SUFFIX=${SHA1:5}

    local RESPONSE
    RESPONSE=$(curl -s "https://api.pwnedpasswords.com/range/$PREFIX")

    local MATCH
    MATCH=$(echo "$RESPONSE" | grep -i "$SUFFIX")
    if [[ -n $MATCH ]]; then
        local COUNT
        COUNT=$(echo "$MATCH" | cut -d ':' -f 2 | tr -d '[:space:]')
        echo "Oh no — pwned!"
        echo "This password has been seen $COUNT times before and should never be used."
    else
        echo "The generated password is safe."
    fi
}