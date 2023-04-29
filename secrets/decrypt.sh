#!/bin/sh
gpg --quiet --batch --yes --decrypt --passphrase="$SECRET_PASSPHRASE" \
 secrets.tar.gpg | tar x -C ../
