#!/bin/bash

# Function to display menu
display_menu() {
    echo "Please choose the type of password you want to generate:"
    echo "1) Simple Password"
    echo "2) Complex Password"
    echo "Enter your choice (1 or 2):"
}

# Read user input
read_choice() {
    local choice
    read -r choice
    case $choice in
        1)
            ./simplePass.sh
            ;;
        2)
            ./complexPass.sh
            ;;
        *)
            echo "Invalid choice. Please enter 1 or 2."
            display_menu
            read_choice
            ;;
    esac
}

# Main function
main() {
    display_menu
    read_choice
}

main
