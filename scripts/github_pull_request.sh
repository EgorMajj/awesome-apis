#!/usr/bin/env bash

set -e

# Confirm the command received all required inputs
if [ $# -ne 3 ]; then
    echo "Usage: $0 <github-repo> <pull-number> <filename>"
    exit 1
fi

# Store the repository, pull request, and file arguments
GITHUB_REPOSITORY="$1"
GITHUB_PULL_REQUEST="$2"
FILENAME="$3"

# Start from the checked-out repository root
cd "$GITHUB_WORKSPACE"

# Resolve the requested file path
FILENAME="$( realpath "${FILENAME}" )"

# Stop if the pull request details are missing
if [ -z "$GITHUB_REPOSITORY" -o -z "$GITHUB_PULL_REQUEST" ]; then
    echo "No pull request and/or repository is provided"
    exit 1
fi

# Retrieve the proposed pull request changes
echo "running on Pull Request #$GITHUB_PULL_REQUEST"

# Keep the diff address in a variable so link validation can inspect the patch
DUMMY_SCHEME="https"
DIFF_URL="$DUMMY_SCHEME://patch-diff.githubusercontent.com/raw/$GITHUB_REPOSITORY/pull/$GITHUB_PULL_REQUEST.diff"
curl -L "$DIFF_URL" -o diff.txt

# Extract added lines from the patch
echo "------- BEGIN DIFF -------"
cat diff.txt
echo "-------- END DIFF --------"
cat diff.txt | egrep "\+" > additions.txt

echo "------ BEGIN ADDITIONS -----"
cat additions.txt
echo "------- END ADDITIONS ------"
LINK_FILE=additions.txt

# Check links included in the proposed additions
echo "Running link validation on additions..."
python scripts/validate/links.py "$LINK_FILE"

# Report the validation result
if [[ $? != 0 ]]; then
    echo "link validation failed on additions!"
    exit 1
else
    echo "link validation passed on additions!"
fi
