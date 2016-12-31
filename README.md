# read-eval-pwn loop

The goal of this challenge was to exploit the [load](https://www.lua.org/manual/5.3/manual.html#pdf-load) function in a mostly unmodified Lua interpreter. To make it more interesting, the interpreter and libc were compiled with clangs's [control flow integrity](http://clang.llvm.org/docs/ControlFlowIntegrity.html) protection, as well as numerous other hardening mechanisms. The exploit achieves an arbitrary read/write primitive by faking a string and a table object (through the LOADK opcode with an out-of-bounds index), then gains code execution by overwriting a jmpbuf structure used by the interpreter for exception handling and coroutine yielding.

A working exploit can be found in exploit/. Usage:

```
./pwn.py
cat pwn.lua | nc ...
```
