#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR
SCRIPT_ABSOLUTE_DIR=$(pwd)

echo -e "\n *** SGX-SDK/SGX-SDK_loc-changes.sh ***\n"

# Print commands before executing
cd linux-sgx
pwd
set -x
echo "Check out last commit."
git checkout 2ee53db4e8fd25437a817612d3bcb94b66a28373
echo "Print log of changes to stub."
git --no-pager log --pretty=oneline --follow sdk/trts/linux/trts_pic.S
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space 9441de4c38700bbc573bb0d363c34387022b7b1c 2ee53db4e8fd25437a817612d3bcb94b66a28373 sdk/trts/linux/trts_pic.S 

echo -e "\n *** cloc"
git checkout 2ee53db4e8fd25437a817612d3bcb94b66a28373
git --no-pager log -n 1 sdk/trts/linux/trts_pic.S
cloc sdk/trts/linux/trts_pic.S