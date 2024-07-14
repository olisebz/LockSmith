#!/usr/bin/env bats

HORSE_STAPLE_PASS_SCRIPT="../src/horseStaplePass.sh"

# horseStaplePass.sh exists ?
@test "horseStaplePass.sh should exist" {
    cd "$(dirname "$BATS_TEST_FILENAME")"
    cd ../src

    [ -f horseStaplePass.sh ]
}
