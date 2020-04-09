#!/usr/bin/env bats

load _test_base

@test "run 'rm_whitelist_from_blacklist'" {
    local expected="$(printf 'abcd.com')"
    whitelist="$(mktemp)"
    printf "abcde.com" \
        > "$whitelist"
    printf "abcd.com\nabcde.com" \
        > "$test_file"

    run rm_whitelist_from_blocklist "$whitelist" "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]

    rm "$whitelist"
}
