# SGX-LKL

[SGX-LKL](https://github.com/lsds/sgx-lkl-musl) moved to adopt OpenEnclave nowadays but before they did that, they had their own assembly stub in `crt/sgxcrt.c`.

## Stub line changes

LKL removed the `sgxcrt.c` assembly stub when moving to OE. Last commit to master branch is `22c91c211aaf4048a4f034084bb7fa202bd6071c`.

```bash
# Go to a last commit that contains the file
$ git checkout 22c91c211aaf4048a4f034084bb7fa202bd6071c

$ git log --follow --pretty=oneline crt/sgxcrt.c
4cd5ccb2dc34cd251a0177f0ec1d4e16dfb5d467 Validate call IDs on ecalls.
9600a9f0b36f85c2b2c3a9f4a3aba57d593bfd46 Clean up of code ahead of OE port.
4ac8834ee1c9372de910a8d95ab26bb4a7e72fd9 (origin/thread-local-storage) Make sure the start of the thread control block (TCB) contains a self pointer as required by GCC for direct TLS accesses; Fix simulation mode TLS.
2eec9abe09ec1c1e8b338cf6013a36b191e01bce Initial commit of sgx-lkl-musl, part of SGX-LKL.

$ git diff --stat --ignore-all-space 2eec9abe09ec1c1e8b338cf6013a36b191e01bce 22c91c211aaf4048a4f034084bb7fa202bd6071c crt/sgxcrt.c
 crt/sgxcrt.c | 47 +++++++++++++++++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 12 deletions(-)

```

## Lines of code in assembly file

```bash
$ git status
HEAD detached at c690dad8
nothing to commit, working tree clean

$ git log -n 1 crt/sgxcrt.c
commit 4cd5ccb2dc34cd251a0177f0ec1d4e16dfb5d467
Author: Christian Priebe <cp3213@ic.ac.uk>
Date:   Wed Nov 13 12:41:14 2019 +0000

    Validate call IDs on ecalls.
    
    In particular, ensure that signal handling code can only be invoked after an
    asynchronous exit (indicated by CSSA > 0). Otherwise it is possible to trick
    SGX-LKL into restoring register values from an uninitialised SSA.
    
    This commit adds checks to ensure that the ecall ID is valid, i.e. is one of
    
    0: THREAD_CREATE,
    1: RESUME,
    2: HANDLE_SIGNAL
    
    If CSSA is 0, the ID must be either 0 (THREAD_CREATE) or 1 (RESUME), otherwise
    it must bust be either 1 (RESUME) or 2 (HANDLE_SIGNAL).
    
    Note: This code will be replaced with the planned migration to the Open Enclave
    SDK.
    
    Thanks to Jo Van Bulck, KU Leuven and David Oswald, University of Birmingham
    for reporting this issue.

$ cloc crt/sgxcrt.c
       1 text file.
       1 unique file.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.00 s (256.7 files/s, 42864.5 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
C                                1             18             46            103
-------------------------------------------------------------------------------
```
