#!/bin/sh
set -e
set -o pipefail

source ./scripts/export-secrets.sh

# Setup
BUILD_DIR=secrets
cd $BUILD_DIR

if test -z "$SECRET_PASSPHRASE"
then
      echo "SECRET_PASSPHRASE is empty"
      exit 1
else
      echo "SECRET_PASSPHRASE is NOT empty"
fi

gpg --quiet --batch --yes --decrypt --passphrase="$SECRET_PASSPHRASE" secrets.tar.gpg | tar x -C ../
