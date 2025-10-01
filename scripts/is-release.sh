#!/usr/bin/env bash
# Script to detect release commits for GH Actions checks.
# Note: Remember to include the "origin/" prefix for remote branches!
#  Otherwise, checks will be done against local branches of matching names.
# Usage: is-release.sh <base_branch> <head_branch> [pattern]

set -e  # Exit on any error

# Check args.
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 <base_branch> <head_branch> [pattern]"
    echo ""
    echo "Arguments:"
    echo "  base_branch    Base branch to compare against"
    echo "  head_branch    Head branch to check"
    echo "  pattern        Pattern to search for (default: 'release .*')"
    echo ""
    echo "Output: 'true' if release commits found, 'false' otherwise"
    echo ""
    echo "Example (local branch): ./is-release.sh origin/main user/feature"
    echo "Example (remote branch): ./is-release.sh origin/main origin/user/feature"
    exit 1
fi

BASE_BRANCH="$1"
HEAD_BRANCH="$2"
PATTERN="${3:-^release .*}"

# Check if we're in a git repository.
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "Error: Not in a git repository" >&2
    exit 2
fi

# Get commit messages from the range.
COMMITS=$(git log --oneline $BASE_BRANCH..$HEAD_BRANCH --pretty=format:"%s" 2>/dev/null) || {
    echo "Error: Failed to get commit messages. Check if branches exist." >&2
    exit 2
}

# If no commits, return false.
if [ -z "$COMMITS" ]; then
    echo "false"
    exit 0
fi

# Check for release pattern.
if echo "$COMMITS" | grep -qi "$PATTERN"; then
    echo "true"
else
    echo "false"
fi