#!/bin/bash
# Download and extract HCA matrix data from .mtx url, and the perform clustering using cellbrowser wrapper cbScanpy
# e.g. `cluster_hca.sh https://data.humancellatlas.org/project-assets/project-matrices/4a95101c-9ffc-4f30-a809-f04518a23803.homo_sapiens.mtx.zip`
# A single-cell reference map of transcriptional states for human blood and tissue T cell activation:
set -euo pipefail

# Resolve the location of this script
CLUSTER_HCA_HOME="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cwd="${CLUSTER_HCA_HOME}/cell_data/scanpyOut"
cd ${cwd}
cbBuild -o ~/public_html/cb -p 8888
