#! /bin/bash

SCRIPT_RELATIVE_DIR=$(dirname "${BASH_SOURCE[0]}") 
cd $SCRIPT_RELATIVE_DIR
cd enarx

echo -e "\n *** Enarx/Enarx_loc-changes.sh ***\n"

# Print commands before executing
set -x
pwd
echo -e "\n *** internal/shim-sgx/src/main.rs ***\n"
echo "Check out last commit."
git checkout 99352a16ff0e0f070d8492c5deb8b173050e17bc
echo "Print log of changes to entry stub."
git --no-pager log --follow --pretty=oneline internal/shim-sgx/src/main.rs
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space 6082513f5a5211d5609d159fa109b5819c549510 99352a1 internal/shim-sgx/src/main.rs


echo -e "\n *** internal/shim-sgx/src/enclave.rs ***\n"
echo "enclave.rs was deleted in 6082513f5a5211d5609d159fa109b5819c549510"
echo "Move to commit preceding that deletion commit."
git checkout 783f5c943e1450e75a37f468c5e44191ad060876
echo "Print log of changes to entry stub."
git --no-pager log --follow --pretty=oneline internal/shim-sgx/src/enclave.rs
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space 02d0dd48f1f65074b79aa344e235c7cb42515a9f 85628a597832312e4643e73ec87975e42bf92508 internal/shim-sgx/src/enclave.rs

echo -e "\n *** internal/shim-sgx/src/start.S ***\n"
echo "start.rs was deleted in 02d0dd48f1f65074b79aa344e235c7cb42515a9f"
echo "Move to commit preceding that deletion commit."
git checkout 01a286103944d11d4b97f54f22fbe9e65c028013
echo "Print log of changes to entry stub."
git log --follow --pretty=oneline 02d0dd48f1f65074b79aa344e235c7cb42515a9f internal/shim-sgx/src/start.S 
echo "Print changes to this stub since first commit to it."
git diff --stat --ignore-all-space f49c7fca2e6ab7861b1c99bebeacfdc945321428 01a286103944d11d4b97f54f22fbe9e65c028013 -- internal/shim-sgx/src/start.S

echo -e "\n *** shims/shim-sgx/src/start.S ***\n"
echo "f49c7fca2e6ab7861b1c99bebeacfdc945321428 moved start.rs from shims/shim-sgx/src/start.S"
echo "Do a diff for the old path of start.rs."
echo "Go to the commit before the move."
git checkout d48acf9170285cb6aa48fcf516b81b5e76758c12
echo "Print log of changes to entry stub."
git log --follow --pretty=oneline shims/shim-sgx/src/start.S
echo "Do a git diff from last commit before shims/..../start.S was moved and first commit."
git diff --stat --ignore-all-space d48acf9 62249d240d4eeab3a91428be7ab0fe9edf7b69fe shims/shim-sgx/src/start.S 

echo -e "\n *** enarx-keep-sgx-shim/src/start.S ***\n"
echo "Go to the commit before the move."
git checkout c114ef7edaef0d64149b23bd851435cb3181715d
echo "Print log of changes to entry stub."
git log --follow --pretty=oneline enarx-keep-sgx-shim/src/start.S
echo "Do a git diff from reimplementation of SGX keep and move."
git diff --stat --ignore-all-space c114ef7edaef0d64149b23bd851435cb3181715d 42dce3b2d6a640080b3bac8bf622dea4584c4651 enarx-keep-sgx-shim/src/start.S


echo -e "\n *** cloc"
git checkout 99352a16ff0e0f070d8492c5deb8b173050e17bc
git log -n 1 internal/shim-sgx/src/main.rs
cloc internal/shim-sgx/src/main.rs