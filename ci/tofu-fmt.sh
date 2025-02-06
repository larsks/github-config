#!/bin/sh

if ! tofu fmt -check -diff "$@"; then
  tofu fmt "$@"
  exit 1
fi
