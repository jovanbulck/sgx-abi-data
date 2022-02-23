# OpenSGX

[OpenSGX](https://github.com/sslab-gatech/opensgx) keeps the assembly subst in the file `libsgx/sgx-entry.S`.

## Stub line changes

```bash
$ git log -n 1  libsgx/sgx-entry.S
commit 8031939167e8e15e2c63fbe1fecf072fdc7e7c5a
Author: Ming-Wei Shih <john.mwshih@gmail.com>
Date:   Tue Jan 19 21:23:31 2016 -0500

    simple buffer overflow attack

$ git checkout 8872fc82b2da6158f7bdac6483c5689dc1062ca8

$ git log --follow --pretty=oneline libsgx/sgx-entry.S
8031939167e8e15e2c63fbe1fecf072fdc7e7c5a simple buffer overflow attack
08cbf4ae0408a35fcc1f5a73ea1676fd00c8df46 clean up
005eca7527bfa4577c3a327a1ed64e3cd526d894 Simple argument vector test

$ git diff --stat --ignore-all-space 8872fc82b2da6158f7bdac6483c5689dc1062ca8 005eca7527bfa4577c3a327a1ed64e3cd526d894 libsgx/sgx-entry.S 
 libsgx/sgx-entry.S | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
```

## Lines of code in assembly file

```bash
$ git log -n 1 libsgx/sgx-entry.S
commit 8031939167e8e15e2c63fbe1fecf072fdc7e7c5a
Author: Ming-Wei Shih <john.mwshih@gmail.com>
Date:   Tue Jan 19 21:23:31 2016 -0500

    simple buffer overflow attack
$ cloc libsgx/sgx-entry.S
       1 text file.
       1 unique file.                              
       0 files ignored.
github.com/AlDanial/cloc v 1.82  T=0.01 s (78.5 files/s, 14600.6 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Assembly                         1             13            124             49
-------------------------------------------------------------------------------
```