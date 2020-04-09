#!/usr/bin/env bash

export STEVENBLACK_LIST="https://raw.githubusercontent.com/hectorm/hmirror/master/data/stevenblack/list.txt"
export BLACKLIST="$HOME/blacklist"

# shellcheck source=../unhBlock
source "$PROJECT_ROOT/unhBlock"

setup() {
    test_file="$(mktemp)"
}


teardown() {
    rm -f "$test_file"
}


populate_blacklist() {
    echo "$STEVENBLACK_LIST" > "$BLACKLIST"
}


populate_blacklist
