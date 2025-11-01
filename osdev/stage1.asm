[org 0x7c00]

jmp main

disk_error:
  mov si, error_message
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

main:

  mov ax, 0x0000
  mov es, ax ; Initialize es to 0.

  mov si, message
  call print_string
  mov si, message2
  call print_string

  ; Load stage 2 from sector 2 into 0x0600
  mov ah, 0x02    ; For int 0x13 interrupt, 0x02 means "read sectors from disk"
  mov al, 0x01    ; Number of sectors to read = 1
  mov ch, 0x00    ; Cylinder number = 0
  mov cl, 0x02    ; Sector number = 2 (sector number starts at 1)
  mov dh, 0x00    ; Head number = 0 for single-head disks or 
                  ;                 first head of a multi-disk
  mov dl, 0x80    ; Drive number = 0x80 for the first hard disk
  mov bx, 0x0600  ; Load the sector into memory at offset 0x0600 within segment es
  int 0x13        ; Call BIOS disk service interrupt
  jc disk_error   ; Jump if carry flag is set, caused by the disk read failing
  
  ; Jump to Stage 2
  jmp 0x0000:0x0600

message db 'Bootloader loaded successfully.', 13, 10, 0
message2 db 'Loading stage 2 bootloader.', 13, 10, 0
error_message db 'Disk read error.', 13, 10, 0
times 510 - ($ - $$) db 0
dw 0xaa55