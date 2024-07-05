#!/bin/bash

# this is the main script
# 
# 

# function to generate a random password
generate_password () {
    local LENGTH=$1
    local PASSWORD=$(date +%s%N | sha256sum | head -c$LENGTH)
    echo $PASSWORD
}

# symbol sets
LOWER="abcdefghijklmnopqrstuvwxyz"
UPPER="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
NUMBERS="123456789"
SYMBOLS="!@#$%^&*()_+-=[]{}|;:,.<>?" # which symbols to use ???

echo "Ihr generiertes Passwort lautet:"
echo $password
