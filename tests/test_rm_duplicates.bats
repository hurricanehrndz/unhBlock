#!/usr/bin/env bats

load _test_base

@test "run 'rm_duplicates'" {
    local expected="$(printf 'abcd.com')"
    printf "abcd.com\nabcd.com" \
        > "$test_file"

    run rm_duplicates "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}


@test "run 'rm_duplicates' with similar domains" {
    local expected="$(printf 'abcd.com\nabcde.com')"
    printf "abcd.com\nabcd.com\nabcde.com" \
        > "$test_file"

    run rm_duplicates "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}
