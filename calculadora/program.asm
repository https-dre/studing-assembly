section .data
    LF equ 0xA
    STD_IN equ 0x0
    STD_OUT equ 0x1
    SYS_EXIT equ 0xA
    RET_EXIT equ 0x0
    SYS_READ equ 0x3
    SYS_WRITE equ 0x4
    CALL_KERNEL equ 0x80


    msg db "Digite seu número:"
    len equ $ - msg

    msg_print_soma db "Soma: "
    len_soma equ $ - msg_print_soma

section .bss
    num1 resb 4
    num2 resb 4
    soma resb 4

section .text
global _start
_start:
    call print_message
    mov ecx, num1
    call input

    call print_message
    mov ecx, num2
    call input
    ; CALCULANDO A SOMA
    mov eax, dword [num1]
    mov ebx, dword [num2]
    add eax, ebx
    mov dword [soma], eax


    ; MOSTRANDO A SOMA
    mov eax, SYS_WRITE ; syscall imprimir
    mov ebx, STD_OUT ; STD_OUT
    mov ecx, msg_print_soma ; conteúdo do print
    mov edx, len_soma ; qntd bytes
    int CALL_KERNEL ; chama o kernel

    mov eax, SYS_WRITE ; syscall imprimir
    mov ebx, STD_OUT ; STD_OUT
    mov ecx, soma ; conteúdo do print
    int CALL_KERNEL ; chama o kernel

    jmp exit

print_message:
    mov eax, SYS_WRITE
    mov ebx, STD_OUT ; STD_OUT
    mov ecx, msg
    mov edx, len
    int CALL_KERNEL
    ret

input:
    mov eax, SYS_READ  ; SYS_READ
    mov ebx, STD_IN  ; STD_IN
    ; lembrar de passar a variável para ecx
    mov edx, 4
    int CALL_KERNEL
    ret

exit:
    mov eax, SYS_EXIT  ; SYS_EXIT
    mov ebx, RET_EXIT  ; OUT CODE
    int CALL_KERNEL ; chama o kernel
