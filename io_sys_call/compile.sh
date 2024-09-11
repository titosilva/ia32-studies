#!/bin/bash

nasm -f elf io_sys_call.asm -o io_sys_call.o
gcc -m32 main.c io_sys_call.o
./a.out