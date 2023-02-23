;
; Prints hex value of dx
;
mov dx , 0x1fb6 ; store the value to print in dx
call print_hex ; call the function


jmp $
%include "./print_hex.asm"
; Padding and magic BIOS number.
times 510-($ - $$) db 0
dw 0xaa55
