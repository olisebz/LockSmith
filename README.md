# LockSmith

# Password Generators

This repository contains two password generator scripts:

1. `simplePass.sh`: Generates a password using two random words from a provided list and appending a two-digit number at the end.
2. `main.sh`: Generates a password based on user-specified criteria for uppercase letters, lowercase letters, numbers, and symbols.

## Prerequisites

Ensure you have the following installed on your system:

- Bash shell
- Coreutils (for `sort` command)

## Files

- `simplePass.sh`: The script that generates a password using two random words and a two-digit number.
- `main.sh`: The script that generates a password based on specified criteria.
- `words.txt`: A text file containing a list of words, each on a new line (used by `simplePass.sh`).

## Usage

### simplePass.sh

1. Ensure `simplePass.sh` and `words.txt` are in the same directory.
2. Make the script executable:
   ```bash
   chmod +x simplePass.sh
