#!/bin/bash

set -e

echo ">>>"

PACKAGE_NAME=$(echo "$GITHUB_REF_NAME" | sed 's/@.*//')

echo $PACKAGE_NAME
echo $GITHUB_REF
echo $GITHUB_REF_NAME

echo "<<<<"
