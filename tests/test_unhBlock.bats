#!/usr/bin/env bats

load _test_base


@test "run 'unhBlock' with SteveBlack's list" {
    run sudo $PROJECT_ROOT/unhBlock "$BLACKLIST"
    [[ "$status" -eq 0 ]]
}


@test "run 'unhBlock' to get stats" {
    run sudo $PROJECT_ROOT/unhBlock -s
    [[ "$status" -eq 0 ]]
    #[[ "$lines[2]" =~ "domains are being blocked" ]]
    [[ "$output" == *"domains are being blocked"* ]]
    rm -f /etc/unbound/unbound.conf.d/unhBlock.conf
}


@test "run 'unhBlock' with custom destination" {
    run sudo $PROJECT_ROOT/unhBlock \
        -d /etc/unbound/blocks.conf \
        "$BLACKLIST"
    [[ "$status" -eq 0 ]]

    run stat /etc/unbound/blocks.conf
    [[ "$status" -eq 0 ]]
}


@test "run 'unhBlock' with custom destination and get stats" {
    run sudo $PROJECT_ROOT/unhBlock \
        -s \
        -d /etc/unbound/blocks.conf \
    [[ "$status" -eq 0 ]]
    #[[ "$lines[2]" =~ "domains are being blocked" ]]
    [[ "$output" == *"domains are being blocked"* ]]
}
