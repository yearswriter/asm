nasm ./$1.asm -f bin -o ./$1.bin
dd if=/dev/zero of=./floppy.img ibs=1k count=1440
dd if=./$1.bin of=./floppy.img conv=notrunc
