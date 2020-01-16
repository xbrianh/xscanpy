#!/bin/bash
# Download and extract HCA matrix data from .mtx url, and the perform cellbrowser clustering with `cbScanpy`
set -euo pipefail
matrix_url="$1"
wget "${matrix_url}" -O archive.zip
mkdir -p matrix
unzip -d matrix -j archive.zip
cbScanpy -e matrix -o scanpyOut -n matrix
# Fix malformed output version. There's probably a better way to handle this
sed -i -e "s/<Version('1.4.5.post2')>/'1.4.5.post2'/" scanpyOut/desc.conf
tar cf scanpyOut.tar scanpyOut
