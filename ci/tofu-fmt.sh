#!/bin/sh

tmpfile=$(mktemp fmtXXXXXX)
#trap 'rm -f "$tmpfile"' EXIT

if ! tofu fmt -no-color -check "$@" > "$tmpfile" 2>&1; then
  message=$(sed -z 's/\n/%0A/g' "$tmpfile")
  echo "::error title=tofu fmt failed::$message"
  tofu fmt -diff "$@"
  exit 1
fi
