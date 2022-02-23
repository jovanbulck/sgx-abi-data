# Enarx

[Enarx](https://github.com/enarx/enarx) has had the assembly stubs in multiple files throughout its development. 

## Stub line changes

For this analysis, we ignore all assembly stubs that were developed before the commit [42dce3b2d6a640080b3bac8bf622dea4584c4651](https://github.com/enarx/enarx/commit/42dce3b2d6a640080b3bac8bf622dea4584c4651) `Reimplement an SGX keep`. This commit adds new assembly stubs that are then extended with security features over the next commits. Before, the assembly was purely functional and did not have many security features. The reason for this is that this is a clear reimplementation in comparison to the older versions which were in our opinion still experimental. The mentioned commit then introduces a working assembly stub that was then expanded with security features over time.

After the above mentioned commit, the history of assembly in Enarx is as follows:
| Filename | First commit | Last commit |
| :-- | :-- | :-- |
|`internal/shim-sgx/src/main.rs` | 6082513f5a5211d5609d159fa109b5819c549510 | 99352a1(main) |
|`internal/shim-sgx/src/enclave.rs` | 02d0dd48f1f65074b79aa344e235c7cb42515a9f | 6082513f5a5211d5609d159fa109b5819c549510 |
|`internal/shim-sgx/src/start.S`| f49c7fca2e6ab7861b1c99bebeacfdc945321428 | 02d0dd48f1f65074b79aa344e235c7cb42515a9f |
|`shims/shim-sgx/src/start.S` |62249d240d4eeab3a91428be7ab0fe9edf7b69fe | f49c7fca2e6ab7861b1c99bebeacfdc945321428|
| `enarx-keep-sgx-shim/src/start.S` | 42dce3b2d6a640080b3bac8bf622dea4584c4651 | 2edf9ebfa7430b0bafac44d69e59a2e7ded4e867 |

### Overall line changes

| Name | Lines |
| :-- | :--- |
| enarx-keep-sgx-shim/src/start.S | 265 |
| shims/shim-sgx/src/start.S | 4 |
| internal/shim-sgx/src/start.S | 22 |
| internal/shim-sgx/src/enclave.rs | 427 |
| internal/shim-sgx/src/main.rs | 126 |
| Sum | 844 |

### internal/shim-sgx/src/main.rs

```bash
$ git status
HEAD detached at 99352a1
nothing to commit, working tree clean

$ git log --follow --pretty=oneline internal/shim-sgx/src/main.rs
6ea4aefabb590ea37da32b4648ffee7d3d3e09ae fix: asm is stable now
b9eb5aa562e90c652972e6cc0798ed5f8f431671 Rework the existing heap implementation
92bcc68daa01cfe82e94364cdc295263fd4853fa fix: cargo fix --edition-idioms
81963e575cafce21beea70793234de98eeddce8d feat(shim-sgx): add gdb support
4e04ebda705bd70196204eee017d26409b7d38b4 Update const-default and xsave
2dfd34c9b65bd499df4a89b888b3d8f8680a5676 fix: activate new asm features
799b202555a21b3efbf7cdd81dfc22d9304c47ab Don't enter the enclave with disabled exceptions
b1f75ab732ee20fea0b752217c40824c58c0aa9a Remove some magic numbers
943deb90deb2031e42b07243eec47a893491605b Combine related feature declarations
f3df3d1893075442b048031f8d11e7020ac7b275 Use the `EEXIT` constant from the `sgx` crate
540a03ccd61c3dd7f5711abb54b8def7ccaf36ab feat(shim-sgx): convert shim-sgx to library
9da5180aec550baefdcbecc98b7647963acd3a0a Bump `sgx`, `sallyport` and `noted` deps
c038bab1f286bf1b35d689e8efa52a5582a82f2a Take a StateSaveArea ref in the Handler
32bb81883325f65bc210de9e8182b75fd3257a5f Move `Parameters` generation to the shim
a6a5f5891f17c4facb10b3f860ffc5efceb2f2b3 Use sallyport::REQUIRES for determining compat
66fffa7036fc4c0e5f2c3e8c8f186f586bf7623e Rewrite the SGX backend as an elf loader
6082513f5a5211d5609d159fa109b5819c549510 Move all SGX startup assembly into main.rs
783f5c943e1450e75a37f468c5e44191ad060876 Split up the SGX shim's handler
d72c13bb03ac564621fa169f186060da5464702b Use CPUID instruction for CPUID AEXs
7d233ec9182aeabb27c81a0da04a6f0d76611ce5 Rework sallyport exit handling
1baed7ddbe96c4cf276ea88d45f0c17ae96119d4 feat: merge crates untrusted and syscall into sallyport
02d0dd48f1f65074b79aa344e235c7cb42515a9f feat(shim-sgx): remove build.rs
ef7ccba6d179bc1fea533c32023d1bbbf7c4dc89 Remove python `cc` linker stub
1a9e0806dfe0b3f3ec0c60002d8c3d9b13291d07 Replace jump() and exit() with inline asm
f49c7fca2e6ab7861b1c99bebeacfdc945321428 move sallyport and rcrt1 into enarx-keep
62249d240d4eeab3a91428be7ab0fe9edf7b69fe Merge shim crates into enarx-keep

# Get main.rs changes from assembly move to date.
git diff --stat --ignore-all-space 6082513f5a5211d5609d159fa109b5819c549510 99352a1 internal/shim-sgx/src/main.rs
 internal/shim-sgx/src/main.rs | 126 +++++++++++++++++++++++++++++++++++++++++-----------------------------------------------
 1 file changed, 59 insertions(+), 67 deletions(-)
```

### internal/shim-sgx/src/enclave.rs

```bash
# enclave.rs was deleted in 6082513f5a5211d5609d159fa109b5819c549510
# Move to commit preceding that deletion commit:
$ git checkout 783f5c943e1450e75a37f468c5e44191ad060876
Previous HEAD position was 6082513 Move all SGX startup assembly into main.rs
HEAD is now at 783f5c9 Split up the SGX shim's handler

$ git log --follow --pretty=oneline internal/shim-sgx/src/enclave.rs
85628a597832312e4643e73ec87975e42bf92508 fix: use rcrt1 master
7d233ec9182aeabb27c81a0da04a6f0d76611ce5 Rework sallyport exit handling
54126984220dea33b8f67aa8450221602b36b505 Improve readability of the SGX mainloop
62670daa87e6a9ff8b0f9142f3f47dea3dc105d1 Systematize CPU state clearing
b72a417e0e35a26ba84074d0e7a38ce8fb730f0c Split off symbol relocation into a separate fn
70f074e0c879ba07e6a17843d0a323244544b43a fix(shim-sgx): proper asm
d5349554d98338ceec5e5bee9546f56ed1ff8122 fix(shim-sgx): allow named_asm_labels
1baed7ddbe96c4cf276ea88d45f0c17ae96119d4 feat: merge crates untrusted and syscall into sallyport
7b33855ae573c60dea3857d6113b837290c0ea57 fix(shim): naked functions need ABI specifier
02d0dd48f1f65074b79aa344e235c7cb42515a9f feat(shim-sgx): remove build.rs

# Do a diff of enclave.rs between 02d0dd48f1f65074b79aa344e235c7cb42515a9f (first commit) and 85628a597832312e4643e73ec87975e42bf92508 (last actual change to it)
$ git diff --stat --ignore-all-space 02d0dd48f1f65074b79aa344e235c7cb42515a9f 85628a597832312e4643e73ec87975e42bf92508 internal/shim-sgx/src/enclave.rs
 internal/shim-sgx/src/enclave.rs | 427 ++++++++++++++++++++++++++++++++++---------------------------------------------------
 1 file changed, 172 insertions(+), 255 deletions(-)
 
```

### internal/shim-sgx/src/start.S

```bash
# start.rs was deleted in 02d0dd48f1f65074b79aa344e235c7cb42515a9f
# move to commit preceding that deletion commit:
$ git checkout 01a286103944d11d4b97f54f22fbe9e65c028013
Previous HEAD position was 02d0dd4 feat(shim-sgx): remove build.rs
HEAD is now at 01a2861 feat(shim-sev): get rid of build.rs

$ git log --follow --pretty=oneline 02d0dd48f1f65074b79aa344e235c7cb42515a9f internal/shim-sgx/src/start.S 
02d0dd48f1f65074b79aa344e235c7cb42515a9f feat(shim-sgx): remove build.rs
c54d12802954a4f759a9defc28becfc6ee475300 feat(syscall): Collect all syscall constants
1a9e0806dfe0b3f3ec0c60002d8c3d9b13291d07 Replace jump() and exit() with inline asm
f49c7fca2e6ab7861b1c99bebeacfdc945321428 move sallyport and rcrt1 into enarx-keep
8e87040a810b824fee6f66b21a9b805680394b7e Fix some errors in comments
62249d240d4eeab3a91428be7ab0fe9edf7b69fe Merge shim crates into enarx-keep

# f49c7fca2e6ab7861b1c99bebeacfdc945321428 moved start.rs from shims/shim-sgx/src/start.S
# Do a diff of start.rs from the f49 (when it moved) to 01a2 (the commit before it was deleted)
$ git diff --stat --ignore-all-space f49c7fca2e6ab7861b1c99bebeacfdc945321428 01a286103944d11d4b97f54f22fbe9e65c028013 -- internal/shim-sgx/src/start.S
 internal/shim-sgx/src/start.S | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)
```

### shims/shim-sgx/src/start.S

`f49c7fca2e6ab7861b1c99bebeacfdc945321428` moved start.rs from `shims/shim-sgx/src/start.S`

```bash
#Do a diff for the old path of start.rs
# Go to the commit before the move 
$ git checkout d48acf9170285cb6aa48fcf516b81b5e76758c12
Previous HEAD position was f49c7fc move sallyport and rcrt1 into enarx-keep
HEAD is now at d48acf9 Use released version of `primordial`

$ git log --follow --pretty=oneline shims/shim-sgx/src/start.S
8e87040a810b824fee6f66b21a9b805680394b7e Fix some errors in comments
62249d240d4eeab3a91428be7ab0fe9edf7b69fe Merge shim crates into enarx-keep

# Do a git diff from last commit before shims/..../start.S was moved and first commit
git diff --stat --ignore-all-space d48acf9 62249d240d4eeab3a91428be7ab0fe9edf7b69fe shims/shim-sgx/src/start.S 
 shims/shim-sgx/src/start.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
```


### enarx-keep-sgx-shim/src/start.S

While the above commit was the first commit that mentions start.S, there were multiple code resets. That involved an almost empty repository between the commits 2edf9ebfa7430b0bafac44d69e59a2e7ded4e867 and 62249d240d4eeab3a91428be7ab0fe9edf7b69fe (in regards to assembly stubs).
However the last commit before the major cleanup of 2edf9ebfa7430b0bafac44d69e59a2e7ded4e867, contains the file enarx-keep-sgx-shim/src/start.S that is near identical to the shims/shim-sgx/src/start.S that we investigated prior. So we do one last comparison for this file.
This is based on the commit c114ef7edaef0d64149b23bd851435cb3181715d and we do some final investigations based on this commit.

```bash
$ git checkout c114ef7edaef0d64149b23bd851435cb3181715d
$ git log --follow --pretty=oneline enarx-keep-sgx-shim/src/start.S
72db9e765b0de0aadba74a874ea822be9b8c0fcd Fix a crasher
34a5b730bb3b9438e408321ccd30d93efa14297d Clear extended CPU state on enclave entry and exit
76d0d5887175a7db603cad92f135038f47771d8d Rework the SGX loader to pass measured argument
af61cb5b4f26ad28c60bcc1ef60c23ec8e05276e Initial stab at setting up a randomized crt0 stack
b20b17fd4998de1662bc413fa3cd58ce8132ad8a Split enter() into entry() and event()
1292402fee54edfa822ad06f8dc1549d8a4331c9 Implement syscall handlers for exit() and getuid()
42dce3b2d6a640080b3bac8bf622dea4584c4651 Reimplement an SGX keep

$ git diff --stat --ignore-all-space c114ef7edaef0d64149b23bd851435cb3181715d 42dce3b2d6a640080b3bac8bf622dea4584c4651 enarx-keep-sgx-shim/src/start.S
 enarx-keep-sgx-shim/src/start.S | 265 ++++++++++++++++++++++++++++++++++++++++++++++++++++++----------------------------------------------------------------------------------------------------------------------------------------------------------------
 1 file changed, 67 insertions(+), 198 deletions(-)

```

## Lines of code in assembly file

```bash
$ git log -n 1 internal/shim-sgx/src/main.rs
commit 6ea4aefabb590ea37da32b4648ffee7d3d3e09ae
Author: Harald Hoyer <harald@profian.com>
Date:   Tue Dec 21 11:31:47 2021 +0100

    fix: asm is stable now
    
    Depend on fixed crate versions and fix for stable `asm` macro.
    
    Signed-off-by: Harald Hoyer <harald@profian.com>

$ cloc internal/shim-sgx/src/main.rs
       1 text file.
       1 unique file.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.01 s (84.2 files/s, 23652.9 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Rust                             1             41             71            169
-------------------------------------------------------------------------------
```
