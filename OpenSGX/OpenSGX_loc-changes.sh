#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR
cd opensgx

echo -e "\n *** OpenSGX/OpenSGX_loc-changes.sh ***\n"

# Print commands before executing
set -x
pwd
echo "Check out last commit."
git checkout 8872fc82b2da6158f7bdac6483c5689dc1062ca8
echo "Print log of changes to entry stub."
git log --follow --pretty=oneline libsgx/sgx-entry.S
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space 8872fc82b2da6158f7bdac6483c5689dc1062ca8 005eca7527bfa4577c3a327a1ed64e3cd526d894 libsgx/sgx-entry.S


echo -e "\n *** cloc"
git checkout 8872fc82b2da6158f7bdac6483c5689dc1062ca8
git log -n 1 libsgx/sgx-entry.S
cloc libsgx/sgx-entry.S