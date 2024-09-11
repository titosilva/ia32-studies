%define array_sz 10

section .data
error_msg db "Error", 0dH, 0aH
error_msg_length EQU $-error_msg

section .bss
array resb array_sz

section .text

global _start
_start:
    enter 0,0
    push esi
    push ebx


    pop ebx
    pop esi
    leave 
    
    mov eax, 0
    ret

    ; Usando exit:
    ;mov eax, 1
    ;mov ebx, 0
    ;int 0x80

; int atoi(char*)
_atoi:
    enter 0,0
    push ebx
    push esi
    push ecx
    
    mov dword ebx, [ebp+8]
    mov dword esi, 0
    mov dword eax, 0

__loop_atoi:
    cmp byte [ebx+esi], 0
    je __end_atoi

    mov ecx, 0
    mov cl, [ebx+esi]
    sub cl, 030h

    mov edx, 10
    mul edx
    jo __fatal_error

    add eax, ecx
    inc esi
    jmp __loop_atoi
    
__end_atoi:
    pop ecx
    pop esi
    pop ebx
    leave
    ret

__fatal_error:
    push dword error_msg
    push dword error_msg_length
    call _puts

    mov eax, 1
    mov ebx, 1
    int 0x80