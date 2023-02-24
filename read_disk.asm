; Read some sectors from the boot disk using our disk_read function
[org 0x7c00]

mov [BOOT_DRIVE], dl ; BIOS stores boot drive in DL, so we remember it for later

mov bp, 0x8000      ; setting stack safely out of the way at 0x8000
mov sp, bp

mov bx, 0x9000
mov dh,5 ;Load 5 sectors to 0x0000(ES):0x9000(BX)
mov dl,[BOOT_DRIVE] ;from the boot disk
call disk_load

mov dx, [0x9000] ;Print the first loaded word
call print_hex

mov dx, [0x9000 + 512] ; Also, print the second loaded word
call print_hex

jmp $

%include "./disk_load.asm"

BOOT_DRIVE:
  db 0
; Padding and magic BIOS number.
times 510 -( $ - $$ ) db 0
dw 0xaa55
; We know that BIOS will load only the first 512 - byte sector from the disk ,
; so if we purposely add a few more sectors to our code by repeating some
; familiar numbers , we can prove to ourselfs that we actually loaded those
; additional two sectors from the disk we booted from.
times 256 dw 0xdada
times 256 dw 0xface
