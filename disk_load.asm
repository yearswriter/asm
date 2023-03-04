;
; load DH sectors to ES:BX from drive DL
;
disk_load:
  push dx ; Store DX on stack, so later we can recall
          ; how many sectors were requested to be read
          ; even if it is altered in the mean time
  mov ah, 0x02  ; BIOS read sector function
  mov al, dh    ; Read DH sectors
  mov ch, 0x00  ; celect cylinder 0
  mov dh, 0x00  ; Select head 0
  mov cl, 0x02  ; Start reading from the second sector i.e. after the boot sector

  int 0x13      ; BIOS read interrupt

  jc disk_error ; Jump if Carry flag was set,
                ; wich wil happen if error occured,
                ; here we are jumping to
                ; our own error message routine

  ; we can also try to compare al with number of sectors we expected to read
  pop dx
  cmp dh, al ; expected, actual
  jne disk_error
  ret

disk_error:
  mov bx, DISK_ERROR_MSG
  call print_string
  jmp $

  DISK_ERROR_MSG: db "Disk read error!", 0
