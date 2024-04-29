section .data
    str_num db '105', 0
    num_res dd 0
    result_buffer db 16

section .text
global _start

_start:
    mov eax, 0    
    mov ebx, str_num ; passa str_num como parâmetro
    call str_to_int ; retorna um número
    ;mov [num_res], eax
    add eax, 2 ; eax += 2

.finish:
    mov eax, 1 ; syscall para sair do programa
    xor ebx, ebx ; código de saída, 0 para sucesso e 1 para erro
    int 0x80 ; chama o kernel


str_to_int:
    mov ecx, 0 ; inicializa o contador de dígitos
    
.next_digit:
    movzx edx, byte [ebx + ecx] ; carrega o próximo caractere
    cmp dl, 0 ; verifica se é o terminador da string
    je .done

    ;converte o caractere em um dígito decimal
    sub edx, '0'

    ;multiplica o número atual por 10 e adiciona o digito
    mov eax, dword [num_res]
    imul eax, eax, 10
    add eax, edx
    mov dword [num_res], eax

    ; avança para o próximo caractere
    inc ecx
    jmp .next_digit

.done:
    ret

int_to_str:
    xor edi, edi ; inicializa o contador de caracteres

.convert_loop:
    mov edx, 0 ; zera edx para a divisão
    mov ecx, 10 ; define 10 como divisor para o número em base 10
    div ecx

    add dl, '0' ; converte o dígito em ascii
    mov [ebx + edi], dl ; move o caractere para a posição em ebx
    inc edi ; incrementa o contador
    test eax, eax ; testa o eax para ver se não há byte nullo
    jnz .convert_loop
.reverse_loop:
    dec edi ; decrementa o contador de caracteres
    mov al, [ebx]
    mov ah, [ebx, edi]
    mov [ebx], ah
    mov [ebx + edi], al
    inc ebx ; avança para o próximo caractere
    cmp ebx, edi
    jae .done_convert ; se sim, termina a conversão
    jmp .reverse_loop

.done_convert:
    mov byte [ebx], 0
    ret

print_string:
    mov edx, 0
    mov eax, 4
    int 0x80
    ret
