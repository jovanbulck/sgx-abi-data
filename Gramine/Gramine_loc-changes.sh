#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR
SCRIPT_ABSOLUTE_DIR=$(pwd)

echo -e "\n *** Gramine/Gramine_loc-changes.sh ***\n"

# Print commands before executing
set -x
cd graphene
pwd
echo -e "\n *** Graphene repository ***\n"
echo "Check out last commit."
git checkout fb71e4376a1fa797697832ca5cbd7731dc7f8793
echo "Print log of changes to entry stub."
git --no-pager log --pretty=oneline Pal/src/host/Linux-SGX/enclave_entry.S
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space 1a1e199c79242cf1630ba6af5f57e34120790a0c 33b92837a810898c8a17d99a2cadb3338b6cdcd2 Pal/src/host/Linux-SGX/enclave_entry.S

echo -e "\n *** Gramine repository ***\n"
cd $SCRIPT_ABSOLUTE_DIR
cd gramine
echo "Check out last commit."
git checkout c4c88f9bc1db53460774cd8adb07267236cef039
echo "Print log of changes to entry stub."
git --no-pager log --pretty=oneline Pal/src/host/Linux-SGX/enclave_entry.S
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space 6194de94f9967a26c334bfd8b45f2a5d30282ab7 c4c88f9bc1db53460774cd8adb07267236cef039 Pal/src/host/Linux-SGX/enclave_entry.S


echo -e "\n *** cloc"
git checkout c4c88f9bc1db53460774cd8adb07267236cef039
git --no-pager log -n 1 Pal/src/host/Linux-SGX/enclave_entry.S
cloc Pal/src/host/Linux-SGX/enclave_entry.S