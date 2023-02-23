;
; A simple boot sector program
;  that prints "Hello, World!" message to the screen
;  using our print include
;  and demonstrates the stack.
;
[org 0x7c00] ; Tell the assembler where this code will be loaded

mov bx, hello_world
call print_string

mov bx, goodbye_for_now
call print_string

jmp $ ; Hang
; libs:
	%include "./print_string.asm"
; data:
	hello_world:
		db 'Hello, World!', 0
	goodbye_for_now:
		db 'Goodbye for now!', 0
; Padding and magic BIOS number.
times 510 -( $ - $$ ) db 0
dw 0xaa55
