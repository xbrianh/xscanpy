#!/bin/bash
# This script attempts to run scanpy an HCA matrix via the CellBrowser
# e.g. `./xcluster.sh https://data.humancellatlas.org/project-assets/project-matrices/4a95101c-9ffc-4f30-a809-f04518a23803.homo_sapiens.mtx.zip`
set -euo pipefail

matrix_url=$1
ARCHIVE=$(basename ${matrix_url})
echo ${ARCHIVE}

EXTRACT_DIR="data"
MATRIX_DIR="matrix"

if [[ -f ${ARCHIVE} ]]; then
    echo "using existing ${ARCHIVE}"
else
	wget ${matrix_url}
fi

unzip -o -d ${EXTRACT_DIR} ${ARCHIVE}
rm -rf ${MATRIX_DIR} && mv "${EXTRACT_DIR}/$(ls ${EXTRACT_DIR})" "${MATRIX_DIR}" && 
rm -rf ${EXTRACT_DIR}
cbScanpy -e ${MATRIX_DIR} -o scanpyOut -n ${MATRIX_DIR}
