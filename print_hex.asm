;
; Prints hex value of a register
;

print_hex:
  ; TODO : manipulate chars at hex_string to reflect DX
  ; TODO : there is a room for sum loops here to reduce code repetition
  mov cx, dx
  and cx, 0xf000 ; f->0
  ; 0001 1111 1011 0110    AND     1111 0000 0000 0000
  ; 0001 0000 0000 0000            0001
  ; fedc|ba98 7654 3210 ->12 SHR-> fedc
  shr cx, 12 ;4x3
  call to_char
  mov [hex_string + 0], cx ; we got '0x' in the result string,
  ; this is adjustment for that, TODO: can I shift whole string in memory at the very and?

  mov cx, dx
  and cx, 0x0f00 ;f->1
  ; fedc ba98|7654 3210 ->12 SHR-> 0000 ba98
  shr cx, 8 ;4x2
  call to_char
  mov [hex_string + 1], cx

  mov cx, dx
  and cx, 0x00f0 ;f->2
  shr cx, 4 ; 4x1
  call to_char
  mov [hex_string + 2], cx

  mov cx, dx
  and cx, 0x000f ;f->4
  ;4x0
  call to_char
  mov [hex_string + 3], cx

  mov bx, hex_string
  call print_string
  ret

to_char:
  sub cx, 0xa ; substruct 10d (0xa) to check if it is a digit or letter
  ; checking if we need letter or digit literal
  js digits   ; if it is digit i.e. less then ten,
              ; which results in negative flag ,to digits procedure
  add cx, 'a' ; if it is a letter, we have relative shift from literal A, and then we need to
  ret         ; add hex value of literal 'A' (or 'a' if we fancy low case),
              ; since they go one after another ex. 0x41='A', 0x42='B', etc.

digits:
  add cx, '0' + 0xa ; if it is a digit, all we need to do
  ret         ; is to add back 0xA, ASCII hex of literal '0' and the number we got,
              ; since they go one after another ex. 0x30='0', 0x31='1', etc.

; includes
%include "./print_string.asm"
; data
hex_string:
  db '0000', 0
