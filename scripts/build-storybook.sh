#!/bin/bash
set -e
set -o pipefail

# Setup
BUILD_DIR=packages/ui_components_lib/example
cd $BUILD_DIR

mkdir -p assets
GIT_LOG_FILE=assets/git_log.txt

echo $'Branch: ' > $GIT_LOG_FILE
git branch | sed -n '/\* /s///p' >> $GIT_LOG_FILE

echo $'\n=============== "uikit" keyword changelog: ===============\n' >> $GIT_LOG_FILE
git log -n 10 --grep uikit --decorate=auto >> $GIT_LOG_FILE


echo $'\n=============== Full changelog: ===============\n' >> $GIT_LOG_FILE
git log -n 20 --decorate=auto >> $GIT_LOG_FILE


flutter build web $@
