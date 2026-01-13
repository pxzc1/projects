## About
Brainfuck Compiler (Interpreter as provide by developer) written in C.
- This version is a patch version of its original, this will generate .C file and run it, to increase compile speed as it runs native code.

## Pipeline
`<example>.bf` → C → `gcc -03` → native binary → automatically run.

## Build the Compiler
`gcc scripts/resources/brainfuck/compiler.c -O2 -o scripts/resources/brainfuck/compiler` (run from Documents/ax_)

## Usage
`./compiler <example>.bf` (run from Documents/ax_/scripts/resources/brainfuck)

## Developer
(Brainfuck-C)['github.com/kgabis/brainfuck-c'] by "@kgabis", patched by [pxzc1]('github.com/pxzc1)