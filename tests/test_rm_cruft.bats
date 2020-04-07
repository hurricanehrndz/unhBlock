#!/usr/bin/env bats

load _test_base


@test "run 'rm_cruft' with comments" {
    local expected="abcd.com"
    printf "# test\nabcd.com # bogus site" \
        > "$test_file"

    run rm_cruft "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}


@test "run 'rm_cruft' with emptylines" {
    local expected="abcd.com"
    printf "\n\nabcd.com\n\n" \
        > "$test_file"

    run rm_cruft "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}


@test "run 'rm_cruft' with leadingspaces" {
    local expected="abcd.com"
    printf "    abcd.com" \
        > "$test_file"

    run rm_cruft "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}


@test "run 'rm_cruft' with trailing spaces" {
    local expected="abcd.com"
    printf "    abcd.com" \
        > "$test_file"

    run rm_cruft "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}


@test "run 'rm_cruft' with bad lineedings" {
    local expected="abcd.com"
    printf "\r\nabcd.com\r\n" \
        > "$test_file"

    run rm_cruft "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}


@test "run 'rm_cruft' with different cases" {
    local expected="$(printf 'abcd.com\nabcd.com')"
    printf "abcd.com\nABCD.COM" \
        > "$test_file"

    run rm_cruft "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}
