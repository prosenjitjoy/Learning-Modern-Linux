#!/bin/bash

# Define that we want to stop the script execution if an error happens
set -o errexit

# Define that we treat unset variables as an error to avoid silent failure
set -o nounset

# Define that when one part of pipe fails, the whole pipe should be considered failed
set -o pipefail

firstargument="${1:-somedefaultvalue}"
echo "$firstargument"
