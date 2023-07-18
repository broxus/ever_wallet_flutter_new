#!/bin/bash

set -e

melos decrypt-secrets
melos run check-format --no-select
melos run codegen --no-select
melos run analyze --no-select
melos run test --no-select
