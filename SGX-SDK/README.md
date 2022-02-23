# Intel SGX-SDK

[SGX-SDK](https://github.com/intel/linux-sgx) has the assembly stub in `sdk/trts/linux/trts_pic.S`.

## Stub line changes

```bash
$ git checkout 2ee53db4e8fd25437a817612d3bcb94b66a28373
$ git log --follow --pretty=oneline sdk/trts/linux/trts_pic.S
26c458905b72e66db7ac1feae04b43461ce1b76f Update copyright. (#708)
4589daddd58bec7367a6a9de3fe301e6de17671a Linux 2.9 Open Source Gold Release
9ddec08fb98c1636ed3b1a77bbc4fa3520344ede (tag: sgx_2.8) Linux 2.8 Open Source Gold Release.
d166ff0c808e2f78d37eebf1ab614d944437eea3 (tag: sgx_2.7.1) Linux 2.7.1 Open Source Gold Release
b13ab0eae778ca0f6976e2800e8d19bfaf735d18 Linux 2.7 Open Source Gold Release
d10cabebb5512878e84f5d21cdf27c39c428ffe2 Linux 2.5 Open Source Gold Release
28817533cc3868892b26d0c02378d79def4a681a (tag: sgx_2.4) Linux 2.4 Open Source Gold Release
aa51bdf6141087f92ad70fd5cb1ac5982c27b04a Fix typo
75dd558bdaff030688d483e1a2bd51d38c55ab49 (tag: sgx_2.1.3) Linux 2.1.3 Open Source Gold Release
edb18459b8977dec8e1a5f123d897f3272099c89 Fix red zone issue in continue_execution(). And create a header file for shared constants between assembly code and C code.
1ccf25b64abd1c2eff05ead9d14b410b3c9ae7be (tag: sgx_2.1) Linux 2.1 Open Source Gold release
159f60223e9428819a8cffb64afc3806f303d859 (tag: sgx_2.0) Linux 2.0 Open Source Gold release
f2cf6d18aa73fdaa916f95b1f3c5ac605a90ff06 Revert "Check for crash in sgx_ocall and exit enclave if enclave is crashed"
a20449f5f85acd4e482c35dd6f8f27f36a3caa60 tRTS check the enclave crash state when doing an OCALL. If the enclave is crashed, tRTS unwind the stack to ECALL, and exit the enclave with SGX_ERROR_ENCLAVE_CRASHED.
0fb9f47e784261369c52c1b49d1484f34409ecaf Linux 1.9 Open Source Gold release
1115c195cd60d5ab2b80c12d07e21663e5aa8030 Linux 1.8 Open Source Gold release
6662022bf8505768b4106de99d07fb96ac653539 (tag: sgx_1.7) Linux 1.7 Open Source Gold release Signed-off-by: Li, Xun <xun.li@email.com>
85947caa128f9f5c731cb25c3cdc4a4d5f95d6e7 (tag: sgx_1.6) Upgrade to Linux 1.6 gold release
9441de4c38700bbc573bb0d363c34387022b7b1c Initial release of Intel SGX for Linux.

$ git diff --stat --ignore-all-space 9441de4c38700bbc573bb0d363c34387022b7b1c 2ee53db4e8fd25437a817612d3bcb94b66a28373 sdk/trts/linux/trts_pic.S 
 sdk/trts/linux/trts_pic.S | 243 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 193 insertions(+), 50 deletions(-)
```


## Lines of code in assembly file

```bash

$ git checkout 2ee53db4e8fd25437a817612d3bcb94b66a28373
$ git log -n 1                                                          Thu 27 Jan 2022 07:01:56 PM CET
commit 2ee53db4e8fd25437a817612d3bcb94b66a28373 (HEAD -> master, origin/master, origin/HEAD)
Author: Sylvain Bellemare <sbellem@gmail.com>
Date:   Wed Jan 5 03:36:25 2022 -0500

    Replace /bin/cp with cp for nix-build (#730)
    
    * Replace /bin/cp with cp for nix-build
    
    When using nix-build, /bin/cp cannot be found as there's nothing under
    /bin except for sh.
    
    Signed-off-by: Sylvain Bellemare <sbellem@gmail.com>
    
    * Call getconf(1) relative to `PATH`
    
    Signed-off-by: Vincent Haupert <mail@vincent-haupert.de>
    
    Co-authored-by: Vincent Haupert <mail@vincent-haupert.de>

$ cloc sdk/trts/linux/trts_pic.S
       1 text file.
       1 unique file.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.01 s (157.9 files/s, 100552.2 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Assembly                         1             67            269            301
-------------------------------------------------------------------------------
```
