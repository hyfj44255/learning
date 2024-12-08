#!/bin/bash
echo "This is an error" >&2 # redirect to stderr
echo "This is normal output"

echo "just learn tee command" | tee -a output.txt

mktemp -t tmpfile.XXXXXXXXXXXXXXXXXXXX
mktemp -td tmpfile.XXXXXXXXXXXXXXXXXXXX