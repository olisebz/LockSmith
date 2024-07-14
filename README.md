# LockSmith

## Password Generators

This repository contains various password generator scripts:

1. `simplePass.sh`: Generates a password using two random words from a provided list and appending a two-digit number at the end.
2. `complexPass.sh`: Generates a password based on user-specified criteria for uppercase letters, lowercase letters, numbers, and symbols.
3. `horseStaplePass.sh`: Generates a password consisting of a specified number of words from a provided list, separated by hyphens.

## Prerequisites

Ensure you have the following installed on your system:

- Bash shell
- Coreutils (for `sort` command)
- `curl` (for checking if the password has been pwned)

## Files

- `simplePass.sh`: The script that generates a password using two random words and a two-digit number.
- `complexPass.sh`: The script that generates a password based on specified criteria.
- `horseStaplePass.sh`: The script that generates a password consisting of a specified number of words separated by hyphens.
- `main.sh`: The script that allows the user to choose between generating a simple or complex password.
- `words.txt`: A text file containing a list of words, each on a new line (used by `simplePass.sh` and `horseStaplePass.sh`).

## Usage

### simplePass.sh

1. Ensure `simplePass.sh` and `words.txt` are in the same directory.
2. Make the script executable:
   ```bash
   chmod +x simplePass.sh
   ```
3. Run the script:
   ```bash
   ./simplePass.sh
   ```

### complexPass.sh

1. Make the script executable:
   ```bash
   chmod +x complexPass.sh
   ```
2. Run the script:
   ```bash
   ./complexPass.sh
   ```
3. Follow the prompts to specify the criteria for your password (number of uppercase letters, lowercase letters, numbers, and symbols).

### horseStaplePass.sh

1. Ensure `horseStaplePass.sh` and `words.txt` are in the same directory.
2. Make the script executable:
   ```bash
   chmod +x horseStaplePass.sh
   ```
3. Run the script with the number of words as an argument:
   ```bash
   ./horseStaplePass.sh <number_of_words>
   ```
4. Example:
   ```bash
   ./horseStaplePass.sh 4
   ```

### main.sh

1. Make the script executable:
   ```bash
   chmod +x main.sh
   ```
2. Run the script:
   ```bash
   ./main.sh
   ```
3. Follow the prompts to choose between generating a simple or complex password.

## Bash Testing (BATS)

### Installation

1. Clone BATS:
   ```bash
   git clone https://github.com/bats-core/bats-core.git
   ```
2. Go into the new folder:
   ```bash
   cd bats-core
   ```
3. Install the dependencies:
   ```bash
   ./install.sh /usr/local
   ```

### Running Tests

1. Go to the `tests` folder:
   ```bash
   cd tests
   ```

2. Test `main.sh`:
   ```bash
   bats main.bats
   ```

3. Test `complexPass.sh`:
   ```bash
   bats complexPass.bats
   ```

4. Test `simplePass.sh`:
   ```bash
   bats simplePass.bats
   ```

5. Test `horseStaplePass.sh`:
   ```bash
   bats horseStaplePass.bats
   ```

## Contributors

- olisebz
- ymeichtry
```