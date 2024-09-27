[BITS 16]
[ORG 0x7C00]

start:
    cli             ; Clear interrupts
    mov ax, 0x00
    mov ds, ax
    mov es, ax      ; Fixed: changed ex to es
    mov ss, ax
    mov sp, 0x7C00
    sti             ; Fixed: changed stio to sti
    mov si, msg

print:
    lodsb           ; Load byte at ds:si into al and increment si
    cmp al, 0
    je done
    mov ah, 0x0E
    int 0x10       ; Call BIOS to print character in al
    jmp print       ; Unconditionally jump back to print

done:
    cli
    hlt             ; Halt CPU execution

msg: db 'Hello World!', 0

times 510 - ($ - $$) db 0
dw 0xAA55
