## Pipeline
`example.bf` → C → `gcc -03` → native binary → automatically run.

## Build the Compiler
`gcc lib/brainfuck/compliler.c -O2 -o lib/brainfuck/brainfuck/compiler` (run from Documents/ax_)

## Usage
`./compiler example.bf`