#!/bin/bash

# Funktion zum Generieren eines zufälligen Passworts
generate_password () {
    local LENGTH=$1
    local LOWER="abcdefghijklmnopqrstuvwxyz"
    local UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local NUMBERS="1234567890"
    local SYMBOLS="!@#$%^&*()_+-=[]{}|;:,.<>?"

    local ALL="$LOWER$UPPER$NUMBERS$SYMBOLS"
    local PASSWORD=""

    for i in $(seq 1 $LENGTH); do
        local CHAR=${ALL:RANDOM%${#ALL}:1}
        PASSWORD="$PASSWORD$CHAR"
    done

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
LENGTH=12
PASSWORD=$(generate_password $LENGTH)

echo "Ihr generiertes Passwort lautet: $PASSWORD"
check_password_pwned $PASSWORD
