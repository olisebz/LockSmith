#!/bin/bash

# Funktion zur Überprüfung des Passworts mit HIBP API
check_password_pwned () {
    local PASSWORD=$1
    local SHA1=$(echo -n $PASSWORD | sha1sum | awk '{ print $1 }' | tr '[:lower:]' '[:upper:]')
    local PREFIX=${SHA1:0:5}
    local SUFFIX=${SHA1:5}

    local RESPONSE=$(curl -s "https://api.pwnedpasswords.com/range/$PREFIX")

    local MATCH=$(echo "$RESPONSE" | grep -i "$SUFFIX")
    if [[ -n $MATCH ]]; then
        local COUNT=$(echo $MATCH | cut -d ':' -f 2 | tr -d '[:space:]')
        echo "Oh no — pwned!"
        echo "This password has been seen $COUNT times before and should never be used."
    else
        echo "The generated password is safe."
    fi
}

# Funktion zum Generieren eines Passworts
generate_password () {
    local PASSWORD
    if [ "$1" == "simple" ]; then
        PASSWORD=$(./simplePass.sh)
    elif [ "$1" == "complex" ]; then
        PASSWORD=$(./complexPass.sh)
    else
        echo "Invalid choice"
        exit 1
    fi
    echo $PASSWORD
}

# Hauptskript
while true; do
    echo "Please choose the type of your password:"
    echo "1) simple password"
    echo "2) complex password"
    read -p "Choose (1 or 2): " CHOICE

    if [ "$CHOICE" == "1" ]; then
        TYPE="simple"
        break
    elif [ "$CHOICE" == "2" ]; then
        TYPE="complex"
        break
    else
        echo "Invalid choice. Please try again."
    fi
done

PASSWORD=$(generate_password $TYPE)
LENGTH=${#PASSWORD}

echo "The total length of the password is: $LENGTH"
echo "Your generated password is: $PASSWORD"
check_password_pwned $PASSWORD
