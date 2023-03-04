;
; Prints hex value of a register
;

print_hex:
  pusha ; store registers on stack

  mov bx, hex_string ; storing output string index in bx
  add bx, 2          ; adjusting for '0x' formatting

  mov al, 12         ; Initial shiftr. value for filtering
                     ; digits ar pos.: 1111 1111 1111 1111
                     ; (digit at pos)     12   8    4    0

  hex_to_str:
    cmp [bx], byte 0 ; if output string current char is 0,
    je done_hex_to_str ;  we are done, output result
      mov si, dx     ; storing input value in si
      mov cl, al     ; setting shiftr value for current iteration
      shr si, cl     ; shiftr. input value to have the
                     ; mostright (hex) digit be in the mostright position
      and si, 0x000f ; acts as filter to the mostright value in si
      mov cx, si
      call to_char  ; converts cl hex digit into ASCII code of it
      mov [bx], cl  ; loads result of the conversion into result string
; CX is also used here to send hex value from SI
; to be converted to ASCII value using to_char procedure.
; Slightly confusing here, since there is no SIL
; in 16-bit mode, so here we send to CX, but load result from CL.
; Also, we are overwritng CL value for shiftr. while doing it,
; which will be set again using AL value at the start of the next loop.
      inc bx    ; moving to the next char in the output string
      sub al, 4 ; adjusting shiftr. value for next iteration
    jmp hex_to_str

  done_hex_to_str:

  mov bx, hex_string ; loading output string into bx
  call print_string  ; for print_stringj procedure
  popa ; restore registers state
  ret

to_char:
  sub cl, 0xa ; substruct 10d (0xa) to check if it is a digit or letter
  ; checking if we need letter or digit literal
  js digits   ; if it is digit i.e. less then ten,
              ; which results in negative flag ,to digits procedure
  add cl, 'a' ; if it is a letter, we have relative shift from literal A, and then we need to
  ret         ; add hex value of literal 'A' (or 'a' if we fancy low case),
              ; since they go one after another ex. 0x41='A', 0x42='B', etc.

digits:
  add cl, '0' + 0xa ; if it is a digit, all we need to do
  ret         ; is to add back 0xA, ASCII hex of literal '0' and the number we got,
              ; since they go one after another ex. 0x30='0', 0x31='1', etc.

; data
hex_string:
  db '0x0000', 0
