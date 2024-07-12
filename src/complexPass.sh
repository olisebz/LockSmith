#!/bin/bash

# function to generate a password
generate_password () {
    local NUM_UPPER="$1"
    local NUM_LOWER="$2"
    local NUM_NUMBERS="$3"
    local NUM_SYMBOLS="$4"

    local LOWER="abcdefghijklmnopqrstuvwxyz"
    local UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local NUMBERS="1234567890"
    local SYMBOLS='!@#$%^&*()_+-=[]{}|;:,.<>?'

    local PASSWORD=""

    for (( i=0; i<NUM_UPPER; i++ )); do
        PASSWORD+="${UPPER:RANDOM%${#UPPER}:1}"
    done

    for (( i=0; i<NUM_LOWER; i++ )); do
        PASSWORD+="${LOWER:RANDOM%${#LOWER}:1}"
    done

    for (( i=0; i<NUM_NUMBERS; i++ )); do
        PASSWORD+="${NUMBERS:RANDOM%${#NUMBERS}:1}"
    done

    for (( i=0; i<NUM_SYMBOLS; i++ )); do
        PASSWORD+="${SYMBOLS:RANDOM%${#SYMBOLS}:1}"
    done

    PASSWORD=$(echo "$PASSWORD" | fold -w1 | awk 'BEGIN {srand()} {print rand(), $0}' | sort -n | cut -d ' ' -f2 | tr -d '\n')

    echo "$PASSWORD"
}

read -r -p "Please enter the number of capital letters: " NUM_UPPER
read -r -p "Please enter the number of small letters: " NUM_LOWER
read -r -p "Please enter the number of numbers: " NUM_NUMBERS
read -r -p "Please enter the number of symbols: " NUM_SYMBOLS

PASSWORD=$(generate_password "$NUM_UPPER" "$NUM_LOWER" "$NUM_NUMBERS" "$NUM_SYMBOLS")

echo "$PASSWORD"
