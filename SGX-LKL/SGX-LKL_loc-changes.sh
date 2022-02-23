#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR
cd sgx-lkl-musl

echo -e "\n *** SGX-LKL/SGX-LKL_loc-changes.sh ***\n"

# Print commands before executing
set -x
pwd
echo "Check out last commit."
git checkout 22c91c211aaf4048a4f034084bb7fa202bd6071c
echo "Print log of changes to entry stub."
git log --follow --pretty=oneline crt/sgxcrt.c
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space 2eec9abe09ec1c1e8b338cf6013a36b191e01bce 22c91c211aaf4048a4f034084bb7fa202bd6071c crt/sgxcrt.c


echo -e "\n *** cloc"
git checkout 22c91c211aaf4048a4f034084bb7fa202bd6071c
git --no-pager log -n 1 crt/sgxcrt.c
cloc crt/sgxcrt.c