#!/bin/bash

set -e

echo ">>>"

variable_name=$(git describe --tags --match="api*" --abbrev=0)

# Now 'variable_name' contains the result of the 'git describe' command
echo "The result is: $variable_name"

git describe --tags --match="api*"  --abbrev=0

echo "<<<<"
