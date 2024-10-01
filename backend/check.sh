#!/bin/bash

set -e

# Script file to automate what a reviewer will do:
# - go to a level
# - write ruby main.rb
# - compare {{level}}/data/output.json and expected_output.json

echo -n "Checking level 1: "
cd level1
ruby main.rb
# More robust tool can be used like jd but it is not installed by default.
diff --color data/output.json data/expected_output.json
echo "OK"