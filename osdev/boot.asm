[org 0x7c00]

mov si, message

print_char:
  lodsb
  cmp al, 0
  je done
  mov ah, 0x0e
  int 0x10
  jmp print_char
done:
  cli
  jmp $

message db 'AndyOS', 0
times 510 - ($ - $$) db 0
dw 0xaa55