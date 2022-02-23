# Gramine

[Gramine](https://github.com/gramineproject/gramine) has the assembly stubs in Pal/src/host/Linux-SGX/enclave_entry.S. However it was also known as [Graphene]() before which needs to be taken into account for the analysis.

## Stub line changes

For this analysis, we look at the old Graphene repository first, and then take another diff from the last commit in the Graphene repository to the newest commit in the Gramine directory. Since the file names/paths are the same this is not an issue.

Commit `f65c496067f6472c74aed54adea57d522d83b06c` is the first commit that also exists in gramine (there as `c2544f3b63e3442f47fa01c388a89da095a570b1`).  `33b92837a810898c8a17d99a2cadb3338b6cdcd2` exists as `6194de94f9967a26c334bfd8b45f2a5d30282ab7` in gramine.

### Graphene

```bash
$ git checkout fb71e4376a1fa797697832ca5cbd7731dc7f8793
$ git log --pretty=oneline Pal/src/host/Linux-SGX/enclave_entry.S

33b92837a810898c8a17d99a2cadb3338b6cdcd2 [Pal/SGX] Inline `__restore_xregs` in ocall EEXIT code
5a80ab150ea9b3947a9fd0217ce05fcf3fe436e4 [LibOS] Rename `async_helper` thread to `async_worker`
2172d870573e6e5fa95ee96ebcfae20047bd6619 [Pal/Linux-SGX] Add OCALL profiling modes
347cdab9620e7d854bdbfb399b5cc7008e5b0044 [Pal/Linux-SGX] Fix stack unwinding on enclave exit
287762501bdec29aeadafcfcad5d9e578ed1e138 Add infinite loop behind each call to exit syscall
3d31f2d18d1a395d76d2ee0a9fea313bedd3c842 Introduce one, central manifest, zero-config children and constant MRENCLAVE
a5a35aa2c568e21e094bc89bee456f4171cf5b30 [Pal/Linux-SGX] Add value checking of external events
d9c7f38ee66b81b924f3ace2e8108da7333df812 [Pal/Linux-SGX] Fix stack walking on enclave exit
2db542f9614a9b711522c2b080b7703d5bcb1453 [Pal/Linux-SGX] Add CFI information to sgx_entry
7e584d582159fe95be0b4a783a87519c5f40405b [Pal/Linux-SGX] Save XSAVE area of normal app context on sync signals
19f0e486a68465a7a3113e2a8e62ce868017306c [Pal] Prefix globals with g_ (part 2)
1293bc151df0fdcc2657d2c9a3577eeaa37378a2 [Pal/Linux-SGX] Clear SSA.GPRSGX.EXITINFO after it was used once
91b3c4498a7a278a0e05900f9ae7b0a8fbde9232 [Pal] Prefix globals with g_
0dd84ddf943d256e5494f07cb41b1d0ece847c1a (origin/yamahata/pal-sgx-ustack) [Pal/{Linux,Linux-SGX}] Fix signal handling on untrusted stack
727c2ab049e1c06ae4d9895fe000ab481dada6b9 Fix typos
13a3b06b593aa83917b614fc34fdb03a73c91c25 [Pal/Linux-SGX] Unify SGX_OCALL_PREPARED and SGX_STACK
0219349264ee383532c9dc53eb811b72d01e9df3 [Pal/Linux-SGX] Use dedicated signal stack with correct XSAVE area
98acf101d90fcdd1cbd2bb2604835b290b8acdef [Pal] Correctly save/restore XSAVE area on signal handling
e4c510a20680047d32c81911941bc96a031de340 [Pal/Linux-SGX] Allow returning to different stack in _restore_sgx_context()
b194aa17fb2a9ca3947cf8b98141322ad791c6ef [LibOS,Pal] Correctly emulate CLONE_CHILD_CLEARTID
111516090b9f6a63904128a24891ca050666df61 [Pal/Linux-SGX] Correctly propagate arguments to _DkHandleExternalEvent()
c8a2a2ee873d84e72ca0fb5c724f258e65b6d866 [Pal/Linux-SGX] Clear the Alignment Check (AC) flag in RFLAGS upon enclave entry
560da76252529b123afca17998b96179ac5f9ad4 [Pal/Linux-SGX] enclave_entry.S: Reset FXSAVE extended state on EENTER
1315b54b5dcb8c815251a03104531aaa12c2a163 [Pal/Linux-SGX] enclave_entry.S: Fix offset of MXCSR "reset" XSAVE area
5dd8b603269fb24209e3d7348a89e6fc56489358 [Pal/Linux-SGX] Rework SGX types to be identical to the SGX SDK ones
30e0b8bfba55c6977b9403778bde307561995c3f [PAL/Linux-SGX] Reuse TLS/TCS pages for newly created threads after previous threads exit
8a45977484ec7738ededb94cde45e211584f2f17 [Pal/Linux-SGX] Return -ERRNO instead of -PAL_ERROR_XXX in OCALLs
70050a5fa379b12b67b34fb63aeab4e4e65dc745 [Pal/Linux-SGX] Remove duplicated reg clearing on sgx_ocall
7276bb9d78f2fd731a3bd0be6ccd2e13f731969e [Pal/Linux-SGX] Correctly clear registers in enclave_entry.S
b7dd1602705f96835ce45fa512043f2daa18a0e4 [Pal/Linux-SGX]: Clean-up of {enclave/sgx}_entry.S
f65c496067f6472c74aed54adea57d522d83b06c [Pal/Linux-SGX] Do not invoke exception handler during OCALL asm
456f03aad8d8cabf54030cf1d49e1e880969a32a Fix a few typos in code comments, debug info, and README
57b17cb86950a35f0ff01a1e27243dd7c38edc55 [LibOS, Pal/Linux-SGX] Clean Trap Flag on PUSHF (for GDB)
16d829cae4bc3edec7b7cbdc8cba5eb1c2a41bc2 [Pal/Linux-SGX] Fix stack alignment for _DkExceptionHandler() and OCALLs
ef343cdf9db24cd6689cf16ecefd40275aababcb [Pal/Linux-SGX] Instruct GDB to bridge enclave-untrusted stacks
a08446f107c6d87605db9d119db5150671b70919 [Pal/Linux-SGX] Add missing CFI directives to .S files for debugging
5992881c468dfd7ef6a3cfcbe26d9d227cd1af07 [Pal/Linux-SGX] Clear RFLAGS before calling _DkExceptionHandler
3f72eb69dec6f576ca25d044432c26de7e0dfac4 [Pal/Linux-SGX] Rename .Lhandle_resume to .Lprepare_resume
fcc1c3ee58fac7b687223486eb5ec04875a056f7 [Pal/Linux-SGX] Improve comments below enclave_entry
5b3b69332a1cc68f36656dcab24d6e6af0617290 [Pal/Linux-SGX] Disallow nested signals at host-OS level
2de42097fe425c8a3f8153143f2df7f6ebdbe06a [Pal/Linux-SGX] Clear RFLAGS.DF on enclave entry
b0390865f5ee379a9909eababaa57dfcfe3d4beb [Pal/Linux-SGX] Clear "extented state" (FPU regs & co) before EEXIT
19fb0d2d89d5031ad5308f57e2404a16c16d5fda [Pal/Linux-SGX] Use common code path to clear regs and then EEXIT
3ab875dd520fb3f84665c53be64d36e7f1c5e3a1 [Pal/Linux-SGX] Drop unused label in enclave_entry.S
bf87ac02f299e4f92b8e8a16313fb838ee180683 [Pal/Linux-SGX] Honor red zone when handling async exits
6585c790aa11d1ab0cf0471a6d84a3ab6958d093 [Pal/Linux-SGX] Document handle_ecall
7789360b93eafd064b4f4126841f8fd075a8c0c3 [Pal/Linux-SGX] EEXIT doesn't need AEP
83347d58ad10cd1834ea2230be0bd28e46b25acc [Pal/Linux-SGX] Remove unused symbols in enclave_entry.S
60f14d699b2412f69287692b7513def4bbc3c192 [Pal/Linux-SGX] Fix typo in enclave_entry.S
5d0c147bafc09f62a4ebb66a7c8176c755d0a1e5 [Pal/Linux-SGX] Don't try to call an exception handler before thread init
55a6ecb69fd90a28cde9b59b31e620e5afafc229 [Pal/Linux-SGX] Make state checks in enclave_entry more rigid
9df4d9671af42a89300d7ce095f794459a0210e0 [Pal/Linux-SGX] Don't call EEXIT if handle_ecall returns
745ab4a47818a987d6e8ec0447ffeca99aa97af1 [Pal/Linux-SGX] Generate asm offsets and use them
2edacac6841a773c9e6a4d04fdafd2cae7fcdaf9 [Pal/Linux-SGX] Drop unused SGX_HAS_FSGSBASE flag
6d91f7fb298534c9028df0859b300131ff97a8ef [Pal/Linux-SGX] enclave_entry.S: close window where %rsp is invalid
cca24572c0dbb8777ae9724f357ab7f1b62a2437 [Pal/Linux-SGX] Fix typo: externel -> external
c5969bb5044909a5f4ee83848500aa9f340a2d73 [Pal/Linux-SGX] Add operation suffix in enclave_entry.S
547f1ed0427e2245f8ddafc8a49cff46c1e95601 fix a typo
51292da629b454505d26e1d0998b1cdc848065c9 fix a typo
b564623f6866a30149d4b41e1ae5b62a33c1e9e4 fix a typo
d9976ed5a5ffabf31e70ad6f62ac48bd55f24226 minor fixes
73871c88cfeb1901c5fc8894a1effc07301bb121 Describing the security issues in Pal/src/host/Linux-SGX/enclave_entry.S
76967f39d3e197a037779f9adfccf7c6243bf0d4 Bugfixes: - Fixing AES-CMAC algorithm - Using SHA512 to hash file stubs (much faster than SHA256 and AES-CMAC) - Hardening enclave interface (still work-in-progress); delt with issue #28 - Handling socket/pipe polling better - Allowing setting the lowest heap address in enclaves ('sgx.heap_min' in manifest) - Fixing the pipe between processes (for SGX) - Fixing race condition in futex handling in LibOS - Inheriting epoll handles in forked chilren - Assigning signal code (now only hard-coding FPE_INTDIV, BUS_ADRERR, SEGV_ACCERR, SEGV_MAPERR) - Fixing race condition in vma allocation (likely to fix bug() in bookkeep/shim_vma.c) - Clearer debug message in LibOS - Fixing calling convention in LibOS and glibc - Fixing futex behavior (FUTEX_WAIT takes relative time, FUTEX_WAIT_BITSET takes absolute time) - More system call implemented - More application working (NGINX)
1a1e199c79242cf1630ba6af5f57e34120790a0c (tag: v0.4) release v0.4beta

$ git diff --stat --ignore-all-space 1a1e199c79242cf1630ba6af5f57e34120790a0c 33b92837a810898c8a17d99a2cadb3338b6cdcd2 Pal/src/host/Linux-SGX/enclave_entry.S
 Pal/src/host/Linux-SGX/enclave_entry.S | 1113 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 826 insertions(+), 287 deletions(-)
```


### enarx-keep-sgx-shim/src/start.S

```bash
$ git checkout c4c88f9bc1db53460774cd8adb07267236cef039
$ git log --pretty=oneline Pal/src/host/Linux-SGX/enclave_entry.S
1202953d09af98fadb8b49b25b7b03c91458519a [Pal] Remove `pal_sec` and refactor topology structures
41525bdb321d4d2b4f9922dbf7bd50cdc2c4b582 [Pal/Linux-SGX] `enclave_entry.S`: Capitalize regs' names in comments
4b5c79951e96a00eeffa9babb2bc15b59809519d [Pal/Linux-SGX] Improve readability of enclave_entry.S
16c91f594a0feb2c2417929e045331576fada322 [Pal] Refactor simple types, part 1 (bools, enums, strings)
baee61e25f03af14a90be289987277de3b916cf6 [Pal/Linux-SGX] Detect signal stack overflow in "enclave_entry.S"
f7e2a7793e2031d5feec0f1faf5f30ba9320bf5e Rename Graphene to Gramine
6194de94f9967a26c334bfd8b45f2a5d30282ab7 [Pal/SGX] Inline `__restore_xregs` in ocall EEXIT code
b6aa6db1d39fbf994a757c48275936d7615b0a65 [LibOS] Rename `async_helper` thread to `async_worker`
76d883924e5f04a79862cb36f8296bfb7acde371 [Pal/Linux-SGX] Add OCALL profiling modes
041556764e2872d9b504b2bc741ee907290dd203 [Pal/Linux-SGX] Fix stack unwinding on enclave exit
355d64b2dd1d9eae0c1e1a1fcb73239b4e749b4a Add infinite loop behind each call to exit syscall
32cdfdea243cbc7c47a4dccb89d8a9e1c0bc0821 Introduce one, central manifest, zero-config children and constant MRENCLAVE
18e1fe259c444e53affc26940c58840176d570e5 [Pal/Linux-SGX] Add value checking of external events
479f7b1fde952ff513bf6f991d15d5f13ee65a3b [Pal/Linux-SGX] Fix stack walking on enclave exit
273629f2eecd472de1117e91381642f7bf6e4637 [Pal/Linux-SGX] Add CFI information to sgx_entry
469c5c0d38cc0f77e909d3aaa705c1e44618d4c8 [Pal/Linux-SGX] Save XSAVE area of normal app context on sync signals
d6c562795ec836b0cf350e6fd99b15e223aa1ae2 [Pal] Prefix globals with g_ (part 2)
d6941e86754cd13fcd49a7e64a52fcd6ecb2871f [Pal/Linux-SGX] Clear SSA.GPRSGX.EXITINFO after it was used once
f73c2a50872a9eebfc12e9a91b1c4c52f9b0b0f6 [Pal] Prefix globals with g_
4e978d0ddf643088382e1973e97e5e27d8e66834 [Pal/{Linux,Linux-SGX}] Fix signal handling on untrusted stack
59fa4302635ccf015cc012d064c4596dd9530e20 Fix typos
225e49903dc9baf0c601fd26e4b13db31821eeef [Pal/Linux-SGX] Unify SGX_OCALL_PREPARED and SGX_STACK
50c4142f8b61e8ff7ad1333b01ad3f5b0c40b827 [Pal/Linux-SGX] Use dedicated signal stack with correct XSAVE area
12e436bf070ba80c6ad212158458d91a128230d0 [Pal] Correctly save/restore XSAVE area on signal handling
7482d2dff234e76a5a62facc62dfa3e066ff5d21 [Pal/Linux-SGX] Allow returning to different stack in _restore_sgx_context()
3d926cd113cdce3b2b1f4a33ef318a1c93f6aabb [LibOS,Pal] Correctly emulate CLONE_CHILD_CLEARTID
696a55679982ffff9e19ead939373fe964547a1c [Pal/Linux-SGX] Correctly propagate arguments to _DkHandleExternalEvent()
91618160bca52801460ae2f8d04afcdf50604fa7 [Pal/Linux-SGX] Clear the Alignment Check (AC) flag in RFLAGS upon enclave entry
a8bf33c09beb9a63d87385cbbfc8db25cba93c57 [Pal/Linux-SGX] enclave_entry.S: Reset FXSAVE extended state on EENTER
7ac37d17c8b38a6e2484601c1b681f93d3aa089a [Pal/Linux-SGX] enclave_entry.S: Fix offset of MXCSR "reset" XSAVE area
64ec0511644d91288bb63eb6fe2201de037e1a7a [Pal/Linux-SGX] Rework SGX types to be identical to the SGX SDK ones
727661785918539c3bccff6cbe92ba72ac4b5450 [PAL/Linux-SGX] Reuse TLS/TCS pages for newly created threads after previous threads exit
389ef18897251588a6bf4d1c89b679eb4808c8dc [Pal/Linux-SGX] Return -ERRNO instead of -PAL_ERROR_XXX in OCALLs
9c44becd4442f07b99ca3abbde3b7d084a745365 [Pal/Linux-SGX] Remove duplicated reg clearing on sgx_ocall
0a28905d7e078cd711894d9744eff4be41053d6b [Pal/Linux-SGX] Correctly clear registers in enclave_entry.S
83840d6c47150920230f6d727fc3eeb13f2b7c5f [Pal/Linux-SGX]: Clean-up of {enclave/sgx}_entry.S
c2544f3b63e3442f47fa01c388a89da095a570b1 [Pal/Linux-SGX] Do not invoke exception handler during OCALL asm
358d63e2b71208cdfb0a9704157113e597801ca1 First commit

# c2544f3b63e3442f47fa01c388a89da095a570b1 is the first commit that also exists in graphene (there as f65c496067f6472c74aed54adea57d522d83b06c)
# 6194de94f9967a26c334bfd8b45f2a5d30282ab7 is 33b92837a810898c8a17d99a2cadb3338b6cdcd2 in graphene

$ git diff --stat --ignore-all-space 6194de94f9967a26c334bfd8b45f2a5d30282ab7 c4c88f9bc1db53460774cd8adb07267236cef039 Pal/src/host/Linux-SGX/enclave_entry.S
 Pal/src/host/Linux-SGX/enclave_entry.S | 727 +++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------------------
 1 file changed, 398 insertions(+), 329 deletions(-)


```

## Lines of code in assembly file

We use the file size of the latest commit which is in Gramine.

```bash
$ git log -n 1
commit c4c88f9bc1db53460774cd8adb07267236cef039 (HEAD -> master, origin/master, origin/HEAD)
Author: Jitender Kumar <jitender.kumar@intel.com>
Date:   Wed Jan 26 23:21:12 2022 -0800

    [LibOS] Verify buffer argument of the fstat syscall
    
    Signed-off-by: Jitender Kumar <jitender.kumar@intel.com>

$ cloc Pal/src/host/Linux-SGX/enclave_entry.S
       1 text file.
       1 unique file.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.01 s (128.4 files/s, 124053.1 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Assembly                         1            147            392            427
-------------------------------------------------------------------------------

```
