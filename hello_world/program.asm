section .data
    msg db "Hello, world!", 0

section .text
    global _start

; pilha (stack)
  ; sp, esp e rsp apontam para o topo da pilha

  ; bp, ebp e rbp (base pointer) É frequentemente usado como uma referência para
      ;acessar variáveis locais e parâmetros de função na pilha.

_start:
    ; dando um print
    mov eax, 4 ; syscal para sys_write (imprimir)
    mov ebx, 1 ; descritor de arquivo: stdout
    mov ecx, msg ; endereço do buffer, no caso vai ser msg
    mov edx, 13 ; comprimento da mensagem
    int 0x80

    mov eax, 1 ; syscall para saída do sistema
    mov ebx, 0  ; código de saída, igual a zero
    int 0x80