# GoTEE

[GoTEE](https://github.com/epfl-dcsl/gotee) keeps the assembly stubs in the file `src/runtime/asmsgx_amd64.s`.

## Stub line changes

```bash
$ git log --follow --pretty=oneline src/runtime/asmsgx_amd64.s
014b35f5e5e9d11da880580cc654e2093ac8ad7a (HEAD, origin/master, origin/HEAD, master) Partial patch for issue #3
79cb904e959d8a6518ddf7d49efc59d9d9bebe92 First commit

$ git diff --stat --ignore-all-space 014b35f5e5e9d11da880580cc654e2093ac8ad7a 79cb904e959d8a6518ddf7d49efc59d9d9bebe92 src/runtime/asmsgx_amd64.s
 src/runtime/asmsgx_amd64.s | 65 -----------------------------------------------------------------
 1 file changed, 65 deletions(-)

```

## Lines of code in assembly file

```bash
$ git status
HEAD detached at 014b35f

$ git log -n 1 src/runtime/asmsgx_amd64.s
commit 014b35f5e5e9d11da880580cc654e2093ac8ad7a (HEAD, origin/master, origin/HEAD, master)
Author: Adrien Ghosn <ghosn.adrien@gmail.com>
Date:   Mon Sep 7 16:43:19 2020 +0200

    Partial patch for issue #3
    
    Patching code for issue 3.
    Simulation works, need an SGX ubuntu machine to check SGX.

$ cloc src/runtime/asmsgx_amd64.s
       1 text file.
       1 unique file.                              
       0 files ignored.

github.com/AlDanial/cloc v 1.82  T=0.01 s (138.2 files/s, 61902.4 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
Assembly                         1             82            127            239
-------------------------------------------------------------------------------
```
