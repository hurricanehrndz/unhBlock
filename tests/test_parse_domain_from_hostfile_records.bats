#!/usr/bin/env bats

load _test_base

@test "run 'parse_domain_from_hostfile_records' with loopback" {
    local expected="$(printf 'abcd.com\nabcd.com')"
    printf "127.0.0.1 abcd.com\n::1 abcd.com" \
        > "$test_file"

    run parse_domain_from_hostfile_records "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}


@test "run 'parse_domain_from_hostfile_records' with gateway" {
    local expected="abcd.com"
    printf "0.0.0.0 abcd.com" \
        > "$test_file"

    run parse_domain_from_hostfile_records "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}
