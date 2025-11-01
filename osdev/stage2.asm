[org 0x0600]

main:
  mov si, message
  call print_string
  hlt

print_string:
  print_char:
    lodsb
    cmp al, 0
    je done
    mov ah, 0x0e
    int 0x10
    jmp print_char
  done:
    ret

message db 'Stage 2 bootloader loaded successfully!', 13, 10, 0