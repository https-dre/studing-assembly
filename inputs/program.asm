section .data
    msg db "digite seu nome: "
    len equ $ - msg

section .bss
    name resb 1

section .text
global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, len
    int 0x80

    mov eax, 3 ; SYS_READ
    mov ebx, 0 ; STD_IN
    mov ecx, name ; destino
    mov edx, 60 ; tamanho máximo do input
    int 0x80

    mov eax, 4    ;SYS_WRITE
    mov ebx, 1    ;STD_OUT
    mov ecx, name ;Variável
    int 0x80      ;Chamar Kernell

    mov eax, 1 ; SYS_EXIT
    mov ebx, 0
    int 0x80
