#!/usr/bin/env bash

# shellcheck source=../unhBlock
source "$PROJECT_ROOT/unhBlock"

setup() {
    test_file="$(mktemp)"
}


teardown() {
    rm -f "$test_file"
}
