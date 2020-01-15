#!/bin/bash
# Download and extract HCA matrix data from .mtx url, and the perform clustering using cellbrowser wrapper cbScanpy
# e.g. `cluster_hca.sh https://data.humancellatlas.org/project-assets/project-matrices/4a95101c-9ffc-4f30-a809-f04518a23803.homo_sapiens.mtx.zip`
set -euo pipefail

# Resolve the location of this script
CLUSTER_HCA_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cwd="${CLUSTER_HCA_HOME}/cell_data"
mkdir -p ${cwd}
cd ${cwd}

matrix_url="$1"
archive="$(basename ${matrix_url})"
tmp_data_directory="/tmp/data"
matrix_dir="matrix"

if [[ -f ${archive} ]]; then
    echo "Using existing ${archive}"
else
    echo "fetching ${archive}"
	wget "${matrix_url}"
fi

unzip -d ${tmp_data_directory} -o ${archive}
rm -rf "${matrix_dir}"
mv "${tmp_data_directory}/$(ls ${tmp_data_directory})" "${matrix_dir}"

cbScanpy -e ${matrix_dir} -o scanpyOut -n ${matrix_dir}
