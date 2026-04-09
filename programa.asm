; programa.asm
; Laboratorio Post1 Unidad 4
; Propósito: demostrar directivas de sección, datos y constantes en NASM

; === Constantes (EQU, no reservan memoria) ===
CR          EQU 0Dh          ; Carriage Return
LF          EQU 0Ah          ; Line Feed
TERMINADOR  EQU 24h          ; "$" terminador de cadena para DOS
ITERACIONES EQU 5            ; número de repeticiones del bucle

; === Datos inicializados ===
; Usamos 'segment' para asegurar compatibilidad total con ALINK 16-bits
segment data
    bienvenida  db "=== Laboratorio NASM Unidad 4 ===", CR, LF, TERMINADOR
    separador   db "---------------------------------", CR, LF, TERMINADOR
    etiqueta_a  db "Variable A (byte convertido): ", TERMINADOR
    etiqueta_b  db "Variable B (dword): ", TERMINADOR
    fin_msg     db "Programa finalizado correctamente.", CR, LF, TERMINADOR
    
    ; Tipos de datos demostrados
    var_byte    db 42            ; 1 byte con valor 42 (ASCII de '*')
    var_word    dw 1234h         ; 2 bytes
    var_dword   dd 0DEADBEEFh    ; 4 bytes
    ; Ajustamos estos valores a números de un solo dígito para que la suma 30h funcione
    tabla_bytes db 1, 2, 3, 4, 5 

; === Datos no inicializados ===
segment bss
    buffer      resb 80          ; 80 bytes para entrada
    resultado   resw 1           ; 1 word para almacenar cálculo

; === Código ejecutable ===
segment code
    global main

main:
    ; Inicializar registro de segmento de datos
    ; Esta es la forma más compatible para el formato OBJ de 16 bits
    mov ax, data             
    mov ds, ax               

    ; Imprimir mensaje de bienvenida
    mov ah, 09h              
    mov dx, bienvenida       
    int 21h                  

    mov dx, separador
    int 21h

    ; === Función 09h: imprimir cadenas ===
    mov ah, 09h
    mov dx, etiqueta_a
    int 21h

    ; === Función 02h: imprimir un carácter ===
    mov al, [var_byte]       ; AL = 42
    add al, 30h              ; 42 + 48 = 90 (Carácter 'Z')
    mov ah, 02h              
    mov dl, al
    int 21h

    ; Imprimir nueva linea
    mov ah, 02h
    mov dl, CR
    int 21h
    mov dl, LF
    int 21h

    ; === Recorrer tabla de bytes e imprimir cada elemento ===
    ; Usamos mov para cargar el desplazamiento de la tabla
    mov si, tabla_bytes      ; SI apunta al inicio de la tabla
    mov cx, ITERACIONES      ; CX = 5 iteraciones

imprimir_tabla:
    mov al, [si]             ; AL = 1, luego 2...
    add al, 30h              ; convierte 1 en '1', 2 en '2', etc.
    mov ah, 02h
    mov dl, al
    int 21h

    ; imprimir espacio entre elementos
    mov ah, 02h
    mov dl, 20h              ; Espacio en blanco
    int 21h

    inc si                   ; avanzar al siguiente byte
    loop imprimir_tabla      ; CX--; si CX != 0, repetir

    ; Imprimir nueva linea después de la tabla
    mov ah, 02h
    mov dl, CR
    int 21h
    mov dl, LF
    int 21h

    ; Imprimir mensaje de fin
    mov ah, 09h
    mov dx, fin_msg
    int 21h

    ; Terminar el programa
    mov ax, 4C00h            ; función DOS: terminar, código 0
    int 21h