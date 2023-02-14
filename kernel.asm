org 0x7e00
jmp 0x0000:start

data:
	
    title db 'JOGO'
	op_menu db 1

clear_screen:
    mov ah, 0bh
    mov bh, 00h
    mov bl, 6
    int 10h
    ret

start:
    xor ax, ax  ;zera registradores
    mov ds, ax
    mov es, ax
    mov cx, ax

    mov ah, 0
    mov al, 13h
    int 10h  ;inicia modo de video

    call clear_screen
    
    mov si, op_menu
    lodsb   ;carrega valor de op_menu em al
    dec si
    
    ;verifica a opcao selecionada
    cmp al, 1

    cmp al, 2

    cmp al, 3

   

jmp $