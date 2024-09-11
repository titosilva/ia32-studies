section .data
error_msg db "Error", 0dH, 0aH
error_msg_length EQU $-error_msg

section .text

global _puts
global _gets
global _atoi

; int _puts(int, char*)
_puts:
    enter 8, 0

    mov dword eax, [ebp+12]
    mov dword [ebp-4], eax

    mov dword eax, [ebp+8]
    mov dword [ebp-8], eax
    push ebx

    mov dword eax, 4
    mov dword ebx, 1
    mov dword ecx, [ebp-4]
    mov dword edx, [ebp-8]
    int 0x80

    pop ebx
    leave
    ret

; int _gets(int, char*)
_gets:
    enter 8, 0

    mov dword eax, [ebp+12]
    mov dword [ebp-4], eax

    mov dword eax, [ebp+8]
    mov dword [ebp-8], eax
    push ebx

    mov eax, 3
    mov ebx, 0
    mov ecx, [ebp-4]
    mov edx, [ebp-8]
    int 0x80

    pop ebx
    leave
    ret

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

