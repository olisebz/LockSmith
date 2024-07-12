#!/bin/bash

HASH_FILE="hashes.txt"

if [[ ! -f "$HASH_FILE" ]]; then
    touch "$HASH_FILE"
fi

# function to check if the password has been pwned
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

# function to generate a password
generate_password () {
    local PASSWORD
    while true; do
        if [ "$1" == "simple" ]; then
            PASSWORD=$(./simplePass.sh)
        elif [ "$1" == "complex" ]; then
            PASSWORD=$(./complexPass.sh)
        else
            echo "Invalid choice"
            exit 1
        fi

        local HASH
        HASH=$(echo -n "$PASSWORD" | shasum -a 256 | awk '{ print $1 }')
        if grep -q "$HASH" "$HASH_FILE"; then
            return 1
        else
            echo "$HASH" >> "$HASH_FILE"
            break
        fi
    done
    echo "$PASSWORD"
    return 0
}

# Main script
while true; do
    echo "Please choose the type of your password:"
    echo "1) simple password"
    echo "2) complex password"
    read -r -p "Choose (1 or 2): " CHOICE 

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

while true; do
    if PASSWORD=$(generate_password "$TYPE"); then
        break
    else
        echo "Generated password already used. Please generate a new one..."
    fi
done

LENGTH=${#PASSWORD}

echo "The total length of the password is: $LENGTH"
echo "Your generated password is: $PASSWORD"
check_password_pwned "$PASSWORD"
