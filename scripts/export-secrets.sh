#!/bin/sh
set -e
set -o pipefail

PASSPHRASE_FILE="secrets/.secrets"
if test -f "$PASSPHRASE_FILE"; then
    echo "Found passphrase file"
    source $PASSPHRASE_FILE
fi
