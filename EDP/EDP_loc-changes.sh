#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR
SCRIPT_ABSOLUTE_DIR=$(pwd)

echo -e "\n *** EDP/EDP_loc-changes.sh ***\n"

# Print commands before executing
cd rust
pwd
set -x
echo "Check out last commit."
git checkout f3b1582bb926a7005ba77bfaa44b1ed59a587509
echo "Print log of changes to entry stub."
git --no-pager log --pretty=oneline src/libstd/sys/sgx/abi/entry.S
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space f3b1582bb926a7005ba77bfaa44b1ed59a587509 4a3505682e97c8e667338056ae216e4b84b22dd7 src/libstd/sys/sgx/abi/entry.S

echo -e "\n *** cloc"
git checkout 2c31b45ae878b821975c4ebd94cc1e49f6073fd0
git --no-pager log -n 1 library/std/src/sys/sgx/abi/entry.S
cloc library/std/src/sys/sgx/abi/entry.S