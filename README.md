# A Case for Unified ABI Shielding in Intel SGX Runtimes

This repository provides the analysis data for our opinion
[paper](https://jovanbulck.github.io/files/systex22-abi.pdf)
"A Case for Unified ABI Shielding in Intel SGX Runtimes"
to appear at the 5th Workshop on System Software for Trusted Execution
(SysTEX'22).

> Jo Van Bulck, Fritz Alder, and Frank Piessens. "A Case for Unified ABI
Shielding in Intel SGX Runtimes," in Proceedings of the 5th Workshop on
System Software for Trusted Execution (SysTEX'22). 

# Paper abstract

With hardware support for trusted execution, most notably Intel SGX, becoming
widely available, recent years have seen the emergence of numerous shielding
runtimes to transparently protect enclave applications in hostile environments.
While, at the application level, a wide range of languages and development
paradigms are supported by diverse runtimes, shielding responsibilities at the
lowest level of the application binary interface (ABI) remain strikingly
similar. Particularly, the ABI dictates that certain CPU registers need to be
cleansed and initialized via a small, hand-written assembly stub upon every
enclave context switch.

This paper and call for action analyzes the ABI sanitization layers of 8
open-source SGX shielding runtimes from industry and academia, categorizes
historic vulnerabilities therein, and identifies cross-cutting tendencies and
insights. We conclude that there is no technical reason for maintaining
separate, often notoriously complex and vulnerable ABI code bases. Moving
forward, we outline challenges and opportunities for a single, unified ABI
sanitization layer that complies with best practices from software engineering
and can be scrutinized and integrated across SGX runtimes.

# ABI vulnerability landscape data

We reproduce the ABI vulnerability landscape overview from the paper (Table 1)
below.  The top rows compare ABI sanitization layers in terms of total lines of
code (as measured on January 20, 2022; using
[`cloc`](https://github.com/AlDanial/cloc)) and lines changed since original
release (as reported by git; following renamed/moved files).  The third row
distinguishes (aspired) production runtimes from research prototypes.

|              | **SGX-SDK**                                                                                                       | **OE**                                                                                                                   | **EDP**                                                                                                                    | **Gramine**                                                                                                                           | **Enarx**                                                                                                         | **GoTEE**                                                                                                          | **SGX-LKL**                                                                                            | **OpenSGX**                                                                                                    |
|:------------:|:-----------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------:|:-----------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------------------:|:------------------------------------------------------------------------------------------------------:|:--------------------------------------------------------------------------------------------------------------:|
| LoC ABI stub | [301](https://github.com/intel/linux-sgx/blob/2ee53db4e8fd25437a817612d3bcb94b66a28373/sdk/trts/linux/trts_pic.S) | [277](https://github.com/openenclave/openenclave/blob/7249aa685d8faad177bd2096f07a70d26e9ab1c0/enclave/core/sgx/enter.S) | [248](https://github.com/rust-lang/rust/blob/74fbbefea8d13683cca5eee62e4740706cb3144a/library/std/src/sys/sgx/abi/entry.S) | [427](https://github.com/gramineproject/gramine/blob/65822f9bdf2dc8a9cde1c81cfc17b9166bb65ebb/Pal/src/host/Linux-SGX/enclave_entry.S) | [169](https://github.com/enarx/enarx/blob/99352a16ff0e0f070d8492c5deb8b173050e17bc/internal/shim-sgx/src/main.rs) | [239](https://github.com/epfl-dcsl/gotee/blob/014b35f5e5e9d11da880580cc654e2093ac8ad7a/src/runtime/asmsgx_amd64.s) | [103](https://github.com/lsds/sgx-lkl-musl/blob/22c91c211aaf4048a4f034084bb7fa202bd6071c/crt/sgxcrt.c) | [49](https://github.com/sslab-gatech/opensgx/blob/8872fc82b2da6158f7bdac6483c5689dc1062ca8/libsgx/sgx-entry.S) |
| LoC changed  | 243                                                                                                               | 589                                                                                                                      | 187                                                                                                                        | 1,840                                                                                                                                 | 844                                                                                                               | 65                                                                                                                 | 47                                                                                                     | 0                                                                                                              |
| Production?  | :heavy_check_mark:                                                                                                | :heavy_check_mark:                                                                                                       | :heavy_check_mark:                                                                                                         | :heavy_check_mark:                                                                                                                    | :heavy_check_mark:                                                                                                | :x:                                                                                                                | :x:                                                                                                    | :x:                                                                                                            |

**LoC ABI stub.** The first row provides static permalinks to the assembly file
that implements ABI shielding for the provided runtime, and which was measured
for the provided LoC count. Note that in the case of OpenEnclave (OE), however,
shielding responsibilities are split over two separate files, and the provided
LoC count is the sum of
[`enter.S`](https://github.com/openenclave/openenclave/blob/7249aa685d8faad177bd2096f07a70d26e9ab1c0/enclave/core/sgx/enter.S)
and
[`exit.S`](https://github.com/openenclave/openenclave/blob/7249aa685d8faad177bd2096f07a70d26e9ab1c0/enclave/core/sgx/exit.S).

**LoC changed.** We provide detailed READMEs with instructions, output logs,
and git submodules pointing to the analyzed versions of each runtime in the
respective subdirectories.

To checkout the git submodules and reproduce the LoC counts, proceed as
follows:

```bash
$ ./calculate_line_changes.sh
```

# ABI patch timelines data

We reproduce the ABI patch timeline overview from the paper (Table 2) below,
with permalinks provided to the respective commits.  The top row provides
initial commit dates as a reference. The next rows list the dates of the
initial patch (and the last revision, if any) for the ABI sanitization
responsibilities in the left column, where :newspaper: and :star: indicate
vulnerabilities disclosed by the referenced academic study and this work,
respectively.

|                                                                               | **SGX-SDK**                                                                                                  | **OE**                                                                                                               | **EDP**                                                                                                     | **Gramine**                                                                                                          | **Enarx**                                                                                                |
|-------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------:|---------------------------------------------------------------------------------------------------------------------:|------------------------------------------------------------------------------------------------------------:|---------------------------------------------------------------------------------------------------------------------:|---------------------------------------------------------------------------------------------------------:|
| Initial commit                                                                | [°24.06.2016](https://github.com/intel/linux-sgx/commit/9441de4c38700bbc573bb0d363c34387022b7b1c)            | [°29.08.2017](https://github.com/openenclave/openenclave/commit/244efe28bc04d0ecf5d9cffac55d03c79a01ee98)            | [°07.12.2018](https://github.com/rust-lang/rust/commit/4a3505682e97c8e667338056ae216e4b84b22dd7)            | [°20.06.2016](https://github.com/gramineproject/graphene/commit/1a1e199c79242cf1630ba6af5f57e34120790a0c)            | [°20.02.2020](https://github.com/enarx/enarx/commit/ef6a9a8fe746452299aca2365b82c753a5e701ed)            |
| [RFLAGS.DF](https://jovanbulck.github.io/files/ccs19-tale.pdf)                | [:newspaper: 17.10.2019](https://github.com/intel/linux-sgx/commit/b13ab0eae778ca0f6976e2800e8d19bfaf735d18) | [:newspaper: 09.10.2019](https://github.com/openenclave/openenclave/commit/efe75044d215d43c2587ffd79a52074bf838368b) | [07.12.2018](https://github.com/rust-lang/rust/commit/4a3505682e97c8e667338056ae216e4b84b22dd7)             | [01.05.2019](https://github.com/gramineproject/graphene/commit/2de42097fe425c8a3f8153143f2df7f6ebdbe06a)             | [20.03.2020](https://github.com/enarx/enarx/commit/1292402fee54edfa822ad06f8dc1549d8a4331c9)             |
| [RFLAGS.AC](https://jovanbulck.github.io/files/ccs19-tale.pdf)                | [:newspaper: 12.11.2019](https://github.com/intel/linux-sgx/commit/d166ff0c808e2f78d37eebf1ab614d944437eea3) | [:newspaper: 09.10.2019](https://github.com/openenclave/openenclave/commit/efe75044d215d43c2587ffd79a52074bf838368b) | [:newspaper: 21.10.2019](https://github.com/rust-lang/rust/commit/fc500368485bd2ebafea6a37da30f49c8be75aac) | [:newspaper: 19.11.2019](https://github.com/gramineproject/graphene/commit/c8a2a2ee873d84e72ca0fb5c724f258e65b6d866) | [:star: 17.02.2022](https://github.com/enarx/enarx/commit/b1dc3d67149a493bd1b86b577f39cb3910b5466b)      |
|                                                                               |                                                                                                              |                                                                                                                      | [10.02.2020](https://github.com/rust-lang/rust/commit/aeedc9dea9e0460488e0b6ce7fe3aaf50395774c)             |                                                                                                                      |
| [FPU extended state](https://jovanbulck.github.io/files/acsac20-fpu.pdf)      | [:newspaper: 16.01.2020](https://github.com/intel/linux-sgx/commit/9ddec08fb98c1636ed3b1a77bbc4fa3520344ede) | [09.10.2019](https://github.com/openenclave/openenclave/commit/efe75044d215d43c2587ffd79a52074bf838368b)             | [:newspaper: 10.02.2020](https://github.com/rust-lang/rust/commit/236ab6e6d631f073a8c3c7439af6b2ec58ce1f25) | [17.10.2019](https://github.com/gramineproject/graphene/commit/560da76252529b123afca17998b96179ac5f9ad4)             | [29.05.2020](https://github.com/enarx/enarx/commit/34a5b730bb3b9438e408321ccd30d93efa14297d)             |
|                                                                               |                                                                                                              | [:newspaper: 14.07.2020](https://github.com/openenclave/openenclave/commit/ad57b943be8f4caaa43174ed25f2a11a477786f3) | [:newspaper: 19.06.2020](https://github.com/rust-lang/rust/commit/33b304c5e0a620350e0eba0ceda2aab23f3b4e6f) |                                                                                                                      |                                                                                                          |
| [Exception stack](https://n.ethz.ch/~sshivaji/publications/smashex_ccs21.pdf) | [:newspaper: 13.07.2021](https://github.com/intel/linux-sgx/commit/edfe42a517b3e4b1d81204c3cdef6da6cb35fefc) | [:newspaper: 13.07.2021](https://github.com/openenclave/openenclave/commit/16efbd6a97fcf69a5e170141c302afc0ed493e0f) | N/A                                                                                                         | [01.04.2019](https://github.com/gramineproject/graphene/commit/6d91f7fb298534c9028df0859b300131ff97a8ef)             | [:newspaper: 22.10.2021](https://github.com/enarx/enarx/commit/799b202555a21b3efbf7cdd81dfc22d9304c47ab) |
|                                                                               |                                                                                                              |                                                                                                                      |                                                                                                             | [31.01.2020](https://github.com/gramineproject/gramine/commit/225e49903dc9baf0c601fd26e4b13db31821eeef)              |                                                                                                          |

_DF = direction flag sanitization; AC = alignment-check flag sanitization; FPU = extended-state sanitization; EXC = exception handler stack pointer initialization._
