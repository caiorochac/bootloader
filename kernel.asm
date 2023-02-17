org 0x7e00
jmp 0x0000:start

data:
	
    ;menu
    title db '* Samblei surfers *', 0
    op1 db 'JOGAR', 0
    op1s db '=> JOGAR <=', 0
    op2 db 'INSTRUCOES', 0
    op2s db '=> INSTRUCOES <=', 0
    nome1 db 'crc - Caio Rocha Calado', 0
    nome2 db 'vaf - Vinicius Alves Fialho', 0
    nome3 db 'jvss2 - Jose Vinicius de Santana Souza', 0
	op_menu db 1

    ;instrucoes
    inst1 db '- Isso eh um jogo', 0
    inst2 db '- Fazer nao eh tao divertido quanto jogar', 0
    inst3 db '- Divirta-se', 0
    inst4 db '- Isso nao eh um teste', 0

;====================================================================================================================
;funcoes basicas
;====================================================================================================================
putchar:                   ;Printar caracter      
    push ax                ;Armazenar estado anterior dos registradores
    push bx              
	mov ah, 0x0e           ;Teletype output (printar)
    mov bh, 0              ;Numero da pagina
    mov bl, 0xf            ;Cor (branco)
	int 10h                ;Interrupcao de video
    pop bx                 ;Recuperar estado anterior dos registradores
    pop ax
	ret                    ;Retornar

endl:                      ;Quebra de linha
    push ax                ;Armazenar estado anterior dos registradores
	mov al, 0x0a           ;Chama uma nova linha (contudo o cursor nao vai para o inicio da proxima linha)
	call putchar
	mov al, 0x0d           ;Chama o carriage return (leva o cursor para o inicio da linha)
	call putchar
    pop ax                 ;Recuperar estado anterior dos registradores
	ret   

printString:               ;Printando uma String 
    push ax                ;Armazenar estado anterior dos registradores
    xor ax, ax             ;Limpando registradores
    .loop:
        lodsb              ;Carrega em AL o conteudo apontado por SI e inc SI
        cmp al, 0          ;Verifica o fim da string
        je .done           ;Se sim, encerra 
        call putchar
        jmp .loop          ;Printa o proximo caracter
    .done:
        call endl
        pop ax             ;Recuperar estado anterior dos registradores
        ret                ;Retornar

getchar:                   ;Ler caracter do teclado
    mov ah, 0x00           ;Chamada para ler tecla pressionada
	int 16h                ;Interrupcao de teclado
    ret 
;=====================================================================================================================

;printar menu
;=====================================================================================================================
printTitle:
    mov ah, 02h     ;Cursor
    mov dh, 3       ;Linha
    mov dl, 9      ;Coluna
    int 10h         ;Video
    mov si, title   ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    ret

printOp1:
    mov ah, 02h ;Cursor
    mov dh, 8   ;Linha
    mov dl, 16  ;Coluna
    int 10h     ;Video
    mov si, op1 ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    ret

printOp1s:
    mov ah, 02h ;Cursor
    mov dh, 8   ;Linha
    mov dl, 13  ;Coluna
    int 10h     ;Video
    mov si, op1s ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    ret

printOp2:
    mov ah, 02h ;Cursor
    mov dh, 11   ;Linha
    mov dl, 14  ;Coluna
    int 10h     ;Video
    mov si, op2 ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    ret

printOp2s:
    mov ah, 02h ;Cursor
    mov dh, 11   ;Linha
    mov dl, 11  ;Coluna
    int 10h     ;Video
    mov si, op2s ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    ret

printNome1:
    mov ah, 02h     ;Cursor
    mov dh, 20      ;Linha
    mov dl, 8       ;Coluna
    int 10h         ;Video
    mov si, nome1   ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    ret
    ret
printNome2:
    mov ah, 02h     ;Cursor
    mov dh, 21      ;Linha
    mov dl, 5       ;Coluna
    int 10h         ;Video
    mov si, nome2   ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    ret
    ret
printNome3:
    mov ah, 02h     ;Cursor
    mov dh, 22      ;Linha
    mov dl, 1       ;Coluna
    int 10h         ;Video
    mov si, nome3   ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    ret
    ret

;====================================================================================================================

;funcoes menu
;====================================================================================================================
lerInputMenu:
    cmp al, 'w'
    je W
    cmp al, 's'
    je S
    cmp al, 32
    je selecionado
    jmp start

W:
    push ax  ;Salva os registradores
    push dx
    xor ax, ax  ;Zera os registradores
    mov dx, ax

    mov si, op_menu ;carega valor de op_menu em al
    lodsb
    dec si

    dec al
    cmp al, 0
    jne .salva
    mov al, 1

    .salva:
        mov di, si   ;atualiza o valor de op_menu
        stosb

        pop ax   ;restaura registradores
        pop dx
        jmp start

S:
    push ax  ;Salva os registradores
    push dx
    xor ax, ax  ;Zera os registradores
    mov dx, ax

    mov si, op_menu ;carega valor de op_menu em al
    lodsb
    dec si

    inc al
    cmp al, 3
    jne .salva
    mov al, 2

    .salva:
        mov di, si   ;atualiza o valor de op_menu
        stosb

        pop ax   ;restaura registradores
        pop dx
        jmp start
selecionado:
    push ax  ;Salva os registradores
    push dx
    xor ax, ax  ;Zera os registradores
    mov dx, ax

    mov si, op_menu ;carega valor de op_menu em al
    lodsb

    cmp al, 1
    je jogo
    cmp al, 2
    je instrucoes
    jmp start


;=======================================================================================================================

;jogo
;=======================================================================================================================
jogo:

    jmp jogo
;=======================================================================================================================

;instrucoes
;=======================================================================================================================
instrucoes:
    mov ah, 0              
    mov al, 13h           
    int 10h 

    mov ah, 02h     ;Cursor
    mov dh, 2      ;Linha
    mov dl, 1       ;Coluna
    int 10h         ;Video
    mov si, inst1   ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString

    mov ah, 02h     ;Cursor
    mov dh, 4      ;Linha
    mov dl, 1       ;Coluna
    int 10h         ;Video
    mov si, inst2   ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString

    mov ah, 02h     ;Cursor
    mov dh, 6      ;Linha
    mov dl, 1       ;Coluna
    int 10h         ;Video
    mov si, inst3   ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString

    mov ah, 02h     ;Cursor
    mov dh, 8      ;Linha
    mov dl, 1       ;Coluna
    int 10h         ;Video
    mov si, inst4   ;Posiciona o cursor SI para o inicio da string a ser printada
    call printString
    
    call getchar
    cmp al, 27   ;ESC
    je start               
    jmp instrucoes
;=======================================================================================================================

start:
    xor ax, ax  ;zera registradores
    mov ds, ax
    mov es, ax
    mov cx, ax

    mov ah, 0
    mov al, 13h
    int 10h  ;inicia modo de video

    call printTitle
    call printNome1
    call printNome2
    call printNome3
    
    mov si, op_menu
    lodsb   ;carrega valor de op_menu em al
    dec si
    
    ;verifica a opcao selecionada
    cmp al, 1
    je .op1
    cmp al, 2
    je .op2

    .op1:
        call printOp1s
        call printOp2
        jmp .continue
    
    .op2:
        call printOp1
        call printOp2s
        jmp .continue

    .continue:
        call getchar
        call lerInputMenu

    jmp start
   

jmp $