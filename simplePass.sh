#!/bin/bash

# Check if words.txt exists
if [[ ! -f words.txt ]]; then
    echo "words.txt not found!"
    exit 1
fi

# Function to get a random word from words.txt
get_random_word() {
    local WORD=$(sort -R words.txt | head -n 1)
    echo $WORD
}

# Generate the password
generate_password() {
    local WORD1=$(get_random_word)
    local WORD2=$(get_random_word)
    local NUMBER=$((10 + RANDOM % 90))  # Generate a random two-digit number
    local PASSWORD="${WORD1}${WORD2}${NUMBER}"
    echo $PASSWORD
}

# Print the generated password
PASSWORD=$(generate_password)
echo "Generated Password: $PASSWORD"
