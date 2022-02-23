#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR

./prepare-submodules.sh

# Call each subdirectory script
./SGX-SDK/SGX-SDK_loc-changes.sh
./OE/OE_loc-changes.sh
./EDP/EDP_loc-changes.sh
./Gramine/Gramine_loc-changes.sh
./Enarx/Enarx_loc-changes.sh
./GoTEE/GoTEE_loc-changes.sh
./SGX-LKL/SGX-LKL_loc-changes.sh
./OpenSGX/OpenSGX_loc-changes.sh