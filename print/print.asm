section .data
  msg db "Hello, World!", 0x0A ; msg a ser impressa na tela
  msg_dois db "Primeiro Print em Assembly!!", 0x0A

section .text
  global _start

_start:
  mov esi, msg
  call print_string
  mov esi, msg_dois
  call print_string
  mov eax, 1  ; syscall de saída
  mov ebx, 0  ; código de saída
  int 0x80  ; chama o kernel

print_string:

  .print_loop:
    mov eax, 4 ; syscall para impressão
    mov ebx, 1 ; 1 = stdout
    mov edx, 1 ; quantidade de bytes
    mov ecx, esi  ; carrega o próximo caractere da string
    test byte [ecx], 0xFF ; verifica se o caractere é nullo
    jz .print_end ; se for, ele pula para o final,
    int 0x80  ; faz a chamada para o kernel do linux
    inc esi ; incrementa para o próximo caractere em esi
    jmp .print_loop ; volta para o início do loop

  .print_end:
    mov ecx, 0
    mov esi, 0
    ret ; retorna