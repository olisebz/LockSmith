# LockSmith

## Password Generators

This repository contains password generator scripts:

1. `simplePass.sh`: Generates a password using two random words from a provided list and appending a two-digit number at the end.
2. `complexPass.sh`: Generates a complex password based on specified criteria for uppercase letters, lowercase letters, numbers, and symbols.
3. `horseStaplePass.sh`: Generates a password composed of a specified number of random words separated by hyphens.
4. `main.sh`: Main script to choose and generate passwords using the above scripts.

## Prerequisites

Ensure you have the following installed on your system:

- Bash shell
- Coreutils (for `sort` command)

## Files

- `simplePass.sh`: The script that generates a password using two random words and a two-digit number.
- `complexPass.sh`: The script that generates a complex password based on specified criteria.
- `horseStaplePass.sh`: The script that generates a password composed of a specified number of random words separated by hyphens.
- `main.sh`: The main script to choose and generate passwords using the above scripts.
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
3. Follow the prompts to specify the number of uppercase letters, lowercase letters, numbers, and symbols.

### horseStaplePass.sh

1. Ensure `horseStaplePass.sh` and `words.txt` are in the same directory.
2. Make the script executable:
   ```bash
   chmod +x horseStaplePass.sh
   ```
3. Run the script with the number of words you want in the password:
   ```bash
   ./horseStaplePass.sh <number_of_words>
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
3. Follow the prompts to specify the type of password (simple, complex, or horse staple) and the criteria if applicable.

## Contributors

- olisebz
- ymeichtry

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

### Usage guide

1. Go to the tests folder:
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
