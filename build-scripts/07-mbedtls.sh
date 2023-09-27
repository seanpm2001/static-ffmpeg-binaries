#!/bin/bash

# Copyright 2021 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -e
set -x

tag=$(repo-src/get-version.sh mbedtls)
git clone --depth 1 https://github.com/ARMmbed/mbedtls.git -b "$tag"

cd mbedtls

# This flag is needed when building on Windows.
if [[ "$RUNNER_OS" == "Windows" ]]; then
  export WINDOWS_BUILD=1
  export CC=gcc
fi

# NOTE: The library is built statically unless SHARED environment
# variable is set.
make no_test
$SUDO make install
