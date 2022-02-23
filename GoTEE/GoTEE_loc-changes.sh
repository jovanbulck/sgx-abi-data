#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR
cd gotee

echo -e "\n *** GoTEE/GoTEE_loc-changes.sh ***\n"

# Print commands before executing
set -x
pwd
echo "Check out last commit."
git checkout 014b35f5e5e9d11da880580cc654e2093ac8ad7a
echo "Print log of changes to entry stub."
git log --follow --pretty=oneline src/runtime/asmsgx_amd64.s
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space 014b35f5e5e9d11da880580cc654e2093ac8ad7a 79cb904e959d8a6518ddf7d49efc59d9d9bebe92 src/runtime/asmsgx_amd64.s


echo -e "\n *** cloc"
git checkout 014b35f5e5e9d11da880580cc654e2093ac8ad7a
git log -n 1 src/runtime/asmsgx_amd64.s
cloc src/runtime/asmsgx_amd64.s