;
; Prints hex value of dx
;
[org 0x7c00] ; Tell the assembler where this code will be loaded
mov dx , 0x1fb6 ; store the value to print in dx
call print_hex ; call the function


jmp $
%include "./print_hex.asm"
; Padding and magic BIOS number.
times 510-($ - $$) db 0
dw 0xaa55
