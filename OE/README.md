# OpenEnclave

[OpenEnclave](https://github.com/openenclave/openenclave) has the assembly stubs in `enclave/core/sgx/enter.S` and `enclave/core/sgx/exit.S`.

## Stub line changes

```bash
$ git checkout 5d402bc1b1caa9a9ed1f42da9690ff8c04d0b583
$ git log --follow enclave/core/sgx/enter.S
$ git log --follow enclave/core/sgx/exit.S


$ git diff --stat --ignore-all-space -M01 244efe28bc04d0ecf5d9cffac55d03c79a01ee98 HEAD -- enclave/core/sgx/enter.S enclave/main.S
 enclave/{main.S => core/sgx/enter.S} | 426 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 395 insertions(+), 31 deletions(-)

$ git diff --stat --ignore-all-space -M01 244efe28bc04d0ecf5d9cffac55d03c79a01ee98 HEAD -- enclave/core/sgx/exit.S enclave/exit.S
 enclave/{ => core/sgx}/exit.S | 163 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 1 file changed, 111 insertions(+), 52 deletions(-)
```


## Lines of code in assembly file

```bash

$ git checkout 5d402bc1b1caa9a9ed1f42da9690ff8c04d0b583
$ git log -n 1
commit 5d402bc1b1caa9a9ed1f42da9690ff8c04d0b583 (HEAD -> master, origin/staging, origin/master, origin/HEAD)
Merge: 16e38b2f3 af0451584
Author: oe-bors[bot] <oeciteam@microsoft.com>
Date:   Thu Jan 27 03:21:48 2022 +0000

$ cloc enclave/core/sgx/enter.S
       1 text file.
       1 unique file.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.01 s (166.2 files/s, 75120.9 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Assembly                         1             94            159            199
-------------------------------------------------------------------------------

$ cloc enclave/core/sgx/exit.S
       1 text file.
       1 unique file.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.01 s (178.8 files/s, 33613.1 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Assembly                         1             31             79             78
-------------------------------------------------------------------------------


```