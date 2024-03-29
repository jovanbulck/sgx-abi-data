# Rust EDP

[EDP](https://github.com/rust-lang/rust/tree/74fbbefea8d13683cca5eee62e4740706cb3144a/library/std/src/sys/sgx) has the assembly stubs in `library/std/src/sys/sgx/abi/entry.S`. However it was earlier at `src/libstd/sys/sgx/abi/entry.S`.

**Update.** In the paper we started the analysis from the release of the
`x86_64-fortanix-unknown-sgx` target in the
[rust-lang/rust](https://github.com/rust-lang/rust) repository. However, we
since became aware of the existence of even older public development
versions of the EDP entry code, from
[21.04.2016](https://github.com/fortanix/rust-sgx/commit/ae7bfbcc6d103103777c581ef7ef10ee9fc282b4)
onwards in the [fortanix/rust-sgx/](https://github.com/fortanix/rust-sgx)
repository. These are now also provided for reference below.

## Stub line changes: Development versions (21.04.2016 -- 05.11.2016)

```bash
$ cd rust-sgx

# `libenclave/src/entry.S` is removed in commit 11f01b5487aa6ddcd9829b1cfbe44be1a29517dc
# so checkout the commit before that one
$ git checkout 11f01b5487aa6ddcd9829b1cfbe44be1a29517dc^

# now track changes, following the renamed file (used to be `libenclave-tools/src/entry.S`)
$ git log --follow --pretty=oneline libenclave/src/entry.S 
92700eb8d5fbb7a5ecfb0aa94b00effe5aeddad1 (HEAD) Make sure a thread stack is initialized before re-panicking
289a5ada3497201a304f8fb2906254dbe93cc03c Add threading support
533e0e5b562051398b653c3d347ec4843aa3cabd (tag: enclave-interface_v0.1.0) Reorganize build process and update to latest nightly.
17c63e5d7114070be3e81529acbb548105ae8c9c Fix huge bug in entry.S; BT sets CF not ZF
ae7bfbcc6d103103777c581ef7ef10ee9fc282b4 (tag: libenclave_v0.1.0) libenclave + tools initial release

# also print entry.S lines changed since first commit for reference
$ git diff --stat --ignore-all-space ae7bfbcc6d103103777c581ef7ef10ee9fc282b4 92700eb8d5fbb7a5ecfb0aa94b00effe5aeddad1 -- libenclave/src/entry.S libenclave-tools/src/entry.S
 {libenclave-tools => libenclave}/src/entry.S | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 53 insertions(+), 26 deletions(-)

# finally note that some additional (dangling, not connected to any branch)
# commits with entry.S changes can be found as follows:
$ git log --all --graph --decorate --oneline -- '*/entry.S'
* 11f01b5 (tag: sgxs_v0.6.0-rc1, tag: sgxs-tools_v0.6.0-rc1, tag: sgxs-loaders_v0.1.0-rc1, tag: sgx-isa_v0.2.0-rc1, tag: fortanix-sgx-tools_v0.1.0-rc1, tag: fortanix-sgx-abi_v0.1.0-rc1, tag: enclave-runner_v0.1.0-rc1, tag: aesm-client_v0.1.0-rc1) Fortanix Rust development platform for Intel SGX, release candidate 1
| * 666c1c0 Revert "Define and add tooling for Enhanced SGXS format"
| * e92ebd4 General cleanup, improve assembly comments, remove AEX debug handler
| * 349f04f Clear XMM registers and other extended state on enclave exit
| * 2cd14e0 Define and add tooling for Enhanced SGXS format
| * 25ac50e Make entering SGX enclaves a co-routine style operation
| * 4807dfc Initial Fortanix source code transfer
* 92700eb Make sure a thread stack is initialized before re-panicking
* 289a5ad Add threading support
* 533e0e5 (tag: enclave-interface_v0.1.0) Reorganize build process and update to latest nightly.
* 17c63e5 Fix huge bug in entry.S; BT sets CF not ZF
* ae7bfbc (tag: libenclave_v0.1.0) libenclave + tools initial release
```

## Stub line changes (from 07.12.2018 onwards)

```bash
$ cd rust
$ git checkout 2c31b45ae878b821975c4ebd94cc1e49f6073fd0

$ git log --follow --pretty=oneline library/std/src/sys/sgx/abi/entry.S
2c31b45ae878b821975c4ebd94cc1e49f6073fd0 (HEAD) mv std libs to library/
f3b1582bb926a7005ba77bfaa44b1ed59a587509 Update libunwind build process for x86_64-fortanix-unknown-sgx target
33b304c5e0a620350e0eba0ceda2aab23f3b4e6f Using xsave restore to restore complete FPU state
daedb7920f48941bd8ffa1b1463b417b1641c823 Prevent attacker from manipulating FPU tag word used in SGX enclave
ea48f2e4da5c6b120c337466e55b307a26c189b2 Enable LVI hardening for x86_64-fortanix-unknown-sgx
57a62f5335c1e8178802d00dfac94212726ee240 Add comment to SGX entry code
71b9ed4a36748be01826063951310a2da2717a9b Avoid jumping to Rust code with user %rsp (reentry_panic)
236ab6e6d631f073a8c3c7439af6b2ec58ce1f25 sanitize MXCSR/FPU control registers
aeedc9dea9e0460488e0b6ce7fe3aaf50395774c Corrected ac_mitigation patch. That patch used the untrusted stack to clear rflags during enclave (re-)entry
f02ffb8b4ca760117875f3b5326e9cff6598dde3 Rewrite %rax register before syscall because it is overwritten by the syscall itself
6354d48dc5839878742e7fbf21a120c5c51a946f Processed review comments
3ee0f48429e6571a87320f2f2e56a48e6717cff1 Create a separate entry point for the ELF file, instead of using the SGX entry point
5aafa98562a3bd472ae7934f0d192b9cfcb36254 forgot pushfq/popqfq: fixed
34f5d5923f3dff832fbc62a61a062643d78e4c03 cleaning up code
d257c20a1dc97631f6c1cf4a22f32ed80f23e4f1 removed unnecessary push
fc500368485bd2ebafea6a37da30f49c8be75aac fixed ac vulnerability
d0a1c2d3e0ac91849882693720cb81b5da533439 SGX target: change re-entry abort logic
0d2ab0b77dd82d192f987ab4e1645577eccd3562 SGX target: simplify usercall internals
a75ae00c63ad2859351e9682026462048f1cf83e SGX target: improve panic & exit handling
4a957b320dce39a044a05d3ad33ce4b20134c263 Adding Build automation for x86_64-fortanix-unknown-sgx
2a663555ddf36f6b041445894a8c175cd1bc718c Remove licenses
885cf2a2afd6da270287cfc3bfa651ac737d0378 Adding unwinding support for x86_64_fortanix_unknown_sgx target.
4a3505682e97c8e667338056ae216e4b84b22dd7 Add x86_64-fortanix-unknown-sgx target to libstd and dependencies

# but the last commit was a move. Print again without following:
$ git log  --pretty=oneline library/std/src/sys/sgx/abi/entry.S
2c31b45ae878b821975c4ebd94cc1e49f6073fd0 (HEAD) mv std libs to library/

# check out commit prior to the move
$ git checkout f3b1582bb926a7005ba77bfaa44b1ed59a587509

# and check the log again
$ git log  --pretty=oneline src/libstd/sys/sgx/abi/entry.S
f3b1582bb926a7005ba77bfaa44b1ed59a587509 (HEAD) Update libunwind build process for x86_64-fortanix-unknown-sgx target
33b304c5e0a620350e0eba0ceda2aab23f3b4e6f Using xsave restore to restore complete FPU state
daedb7920f48941bd8ffa1b1463b417b1641c823 Prevent attacker from manipulating FPU tag word used in SGX enclave
ea48f2e4da5c6b120c337466e55b307a26c189b2 Enable LVI hardening for x86_64-fortanix-unknown-sgx
57a62f5335c1e8178802d00dfac94212726ee240 Add comment to SGX entry code
71b9ed4a36748be01826063951310a2da2717a9b Avoid jumping to Rust code with user %rsp (reentry_panic)
236ab6e6d631f073a8c3c7439af6b2ec58ce1f25 sanitize MXCSR/FPU control registers
aeedc9dea9e0460488e0b6ce7fe3aaf50395774c Corrected ac_mitigation patch. That patch used the untrusted stack to clear rflags during enclave (re-)entry
f02ffb8b4ca760117875f3b5326e9cff6598dde3 Rewrite %rax register before syscall because it is overwritten by the syscall itself
6354d48dc5839878742e7fbf21a120c5c51a946f Processed review comments
3ee0f48429e6571a87320f2f2e56a48e6717cff1 Create a separate entry point for the ELF file, instead of using the SGX entry point
5aafa98562a3bd472ae7934f0d192b9cfcb36254 forgot pushfq/popqfq: fixed
34f5d5923f3dff832fbc62a61a062643d78e4c03 cleaning up code
d257c20a1dc97631f6c1cf4a22f32ed80f23e4f1 removed unnecessary push
fc500368485bd2ebafea6a37da30f49c8be75aac fixed ac vulnerability
d0a1c2d3e0ac91849882693720cb81b5da533439 SGX target: change re-entry abort logic
0d2ab0b77dd82d192f987ab4e1645577eccd3562 SGX target: simplify usercall internals
a75ae00c63ad2859351e9682026462048f1cf83e SGX target: improve panic & exit handling
4a957b320dce39a044a05d3ad33ce4b20134c263 Adding Build automation for x86_64-fortanix-unknown-sgx
2a663555ddf36f6b041445894a8c175cd1bc718c Remove licenses
885cf2a2afd6da270287cfc3bfa651ac737d0378 Adding unwinding support for x86_64_fortanix_unknown_sgx target.
4a3505682e97c8e667338056ae216e4b84b22dd7 Add x86_64-fortanix-unknown-sgx target to libstd and dependencies

# Now we can just check the diff between f3b1 and the start
$ git diff --stat --ignore-all-space f3b1582bb926a7005ba77bfaa44b1ed59a587509 4a3505682e97c8e667338056ae216e4b84b22dd7 src/libstd/sys/sgx/abi/entry.S
 src/libstd/sys/sgx/abi/entry.S | 187 +++++++++++++++++++++++++++++++++------------------------------------------------------
 1 file changed, 71 insertions(+), 116 deletions(-)

```

## Lines of code in assembly file

```bash

$ git log -n 1 library/std/src/sys/sgx/abi/entry.S
commit 2c31b45ae878b821975c4ebd94cc1e49f6073fd0
Author: mark <markm@cs.wisc.edu>
Date:   Thu Jun 11 21:31:49 2020 -0500

    mv std libs to library/

$ git checkout 2c31b45ae878b821975c4ebd94cc1e49f6073fd0

$ cloc library/std/src/sys/sgx/abi/entry.S
       1 text file.
       1 unique file.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.01 s (130.1 files/s, 48412.3 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Assembly                         1             25             99            248
-------------------------------------------------------------------------------

```
