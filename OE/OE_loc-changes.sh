#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR
SCRIPT_ABSOLUTE_DIR=$(pwd)

echo -e "\n *** OE/OE_loc-changes.sh ***\n"

# Print commands before executing
cd openenclave
pwd
set -x
echo "Check out last commit."
git checkout 5d402bc1b1caa9a9ed1f42da9690ff8c04d0b583
echo "Print log of changes to entry stub."
git --no-pager log --pretty=oneline --follow enclave/core/sgx/enter.S
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space -M01 244efe28bc04d0ecf5d9cffac55d03c79a01ee98 HEAD -- enclave/core/sgx/enter.S enclave/main.S

echo "Print log of changes to exit stub."
git --no-pager log --pretty=oneline --follow enclave/core/sgx/exit.S
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space -M01 244efe28bc04d0ecf5d9cffac55d03c79a01ee98 HEAD -- enclave/core/sgx/exit.S enclave/exit.S

echo -e "\n *** cloc"
git checkout 5d402bc1b1caa9a9ed1f42da9690ff8c04d0b583
git --no-pager log -n 1 enclave/core/sgx/enter.S
git --no-pager log -n 1 enclave/core/sgx/exit.S
cloc enclave/core/sgx/enter.S
cloc enclave/core/sgx/exit.S