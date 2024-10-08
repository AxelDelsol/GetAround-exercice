#!/bin/bash

set -eu

# Script file to automate what a reviewer will do:
# - go to a level
# - write ruby main.rb
# - compare {{level}}/data/output.json and expected_output.json

for i in {1..5}
do
    echo -n "Checking level ${i}: "
    cd level${i}
    ruby main.rb
    diff --color <(jq -S . data/output.json) <(jq -S . data/expected_output.json)
    echo "OK"
    cd ..
done