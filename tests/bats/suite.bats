#!/usr/bin/env bats
# Optional Bats wrapper around tests/run.sh

@test "unit suite" {
  run bash tests/run.sh
  [ "$status" -eq 0 ]
}
