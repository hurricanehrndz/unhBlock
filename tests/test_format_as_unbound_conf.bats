#!/usr/bin/env bats

load _test_base

@test "run 'format_as_unbound_conf'" {
    local expected="$(printf 'server:\nlocal-zone: "%s" redirect\nlocal-data: "%s A 0.0.0.0"'  'abcd.com' 'abcd.com')"
    printf "abcd.com" \
        > "$test_file"

    run format_as_unbound_conf "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}

@test "run 'format_as_unbound_conf' with custom blackhole" {
    local expected="$(printf 'server:\nlocal-zone: "%s" redirect\nlocal-data: "%s A 192.168.100.10"'  'abcd.com' 'abcd.com')"
    BLACKHOLE="192.168.100.10"
    printf "abcd.com" \
        > "$test_file"

    run format_as_unbound_conf "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}

@test "run 'format_as_unbound_conf' with CNAME record" {
    local expected="$(printf 'server:\nlocal-zone: "%s" redirect\nlocal-data: "%s CNAME blackhole.com"'  'abcd.com' 'abcd.com')"
    BLACKHOLE="blackhole.com"
    BLACKHOLE_RECORD_TYPE="CNAME"
    printf "abcd.com" \
        > "$test_file"

    run format_as_unbound_conf "$test_file"
    [ "$status" -eq 0 ]

    content=$(cat "$test_file")
    [ "$content" == "$expected" ]
}
