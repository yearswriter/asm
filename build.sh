#!/usr/bin/env bash
source_file=`echo ".\test_print_hex.asm" | sed 's/.*\///' | sed 's/.*\\\//' |sed 's/\.asm//'`
nasm ./$source_file.asm -f bin -o ./$source_file.bin
strip -s -F binary ./$source_file.bin
dd if=/dev/zero of=./floppy.img ibs=1k count=1440
dd if=./$source_file.bin of=./floppy.img conv=notrunc
