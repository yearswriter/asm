;
; Print string lib
;
print_string:
  pusha
  print_char: ;main loop for the string
    mov al, [bx] ; loading our string parameter into al with char
    ; which adress stored in bx
    cmp al, 0 ; comparing what got there, which will be our first char
  je string_end ; if it is zero, we can proceed to typing LFCR
  ; cleaning up and returning to the caller
    mov ah , 0x0e ; int =10/ ah =0 x0e -> BIOS tele - type output
    int 0x10 ; print the character in al
    add bx,1 ; increment the adress of the char in the string
    jmp print_char
  string_end: ;loop exit point
  mov al,0xa ;/n
  int 0x10
  mov al,0xd ;/r
  int 0x10
  popa
  ret ; return from the function call.
