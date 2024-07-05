#!/bin/bash

# Funktion zum Generieren eines zufälligen Passworts
generate_password () {
    local NUM_UPPER=$1
    local NUM_LOWER=$2
    local NUM_NUMBERS=$3
    local NUM_SYMBOLS=$4
    local LENGTH=$((NUM_UPPER + NUM_LOWER + NUM_NUMBERS + NUM_SYMBOLS))

    local LOWER="abcdefghijklmnopqrstuvwxyz"
    local UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local NUMBERS="1234567890"
    local SYMBOLS="!@#$%^&*()_+-=[]{}|;:,.<>?"

    local PASSWORD=""
    local ALL="$LOWER$UPPER$NUMBERS$SYMBOLS"

    # Add specified number of characters from each set
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

    # Shuffle the password to avoid predictable patterns using awk
    PASSWORD=$(echo "$PASSWORD" | fold -w1 | awk 'BEGIN {srand()} {print rand(), $0}' | sort -n | cut -d ' ' -f2 | tr -d '\n')

    echo $PASSWORD
}

# Funktion zur Überprüfung des Passworts mit HIBP API
check_password_pwned () {
    local PASSWORD=$1
    local SHA1=$(echo -n $PASSWORD | sha1sum | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]')
    local PREFIX=${SHA1:0:5}
    local SUFFIX=${SHA1:5}

    local RESPONSE=$(curl -s "https://api.pwnedpasswords.com/range/$PREFIX")

    if echo "$RESPONSE" | grep -q "$SUFFIX"; then
        echo "Das Passwort wurde bereits kompromittiert."
    else
        echo "Das Passwort ist sicher."
    fi
}

# Hauptskript
read -p "Bitte geben Sie die Anzahl der großen Buchstaben ein: " NUM_UPPER
read -p "Bitte geben Sie die Anzahl der kleinen Buchstaben ein: " NUM_LOWER
read -p "Bitte geben Sie die Anzahl der Zahlen ein: " NUM_NUMBERS
read -p "Bitte geben Sie die Anzahl der Symbole ein: " NUM_SYMBOLS

LENGTH=$((NUM_UPPER + NUM_LOWER + NUM_NUMBERS + NUM_SYMBOLS))
echo "Die Gesamtlänge des Passworts beträgt: $LENGTH"

PASSWORD=$(generate_password $NUM_UPPER $NUM_LOWER $NUM_NUMBERS $NUM_SYMBOLS)

echo "Ihr generiertes Passwort lautet: $PASSWORD"
check_password_pwned $PASSWORD
