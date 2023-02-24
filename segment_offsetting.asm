;
; A simple boot sector program that demonstrates segment offsetting
;
mov ah, 0x0e ; BIOS teletype interrupt routine

mov al, [the_secret]
int 0x10 ;correct absolute address, cpu does it for us

mov bx, 0x7c0
mov ds,bx ; we must take an additional step to transfer the value via a general purpose register
mov al, [the_secret]
int 0x10

mov bx, 0x7c0
mov es, bx;  we must take an additional step to transfer the value via a general purpose register
mov al, [es:the_secret] ;same as previous output, but we also explicitly state where we calculate adress
int 0x10

jmp $

the_secret:
  db "X"

; Padding and magic BIOS number.
times 510 -( $ - $$ ) db 0
dw 0xaa55
