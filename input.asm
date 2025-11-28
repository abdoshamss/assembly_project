.model small
.stack 100h
.data
msg1 db "Enter a number (0-9): $"
even_msg db 0Ah,0Dh,"The number is Even$"
odd_msg db 0Ah,0Dh,"The number is Odd$"

.code
main proc
    mov ax, @data
    mov ds, ax

    ; اطبع رسالة الادخال
    mov dx, offset msg1
    mov ah, 09h
    int 21h

    ; اقرأ رقم من المستخدم
    mov ah, 01h
    int 21h
    sub al, '0'      ; حول ASCII لرقم حقيقي
    mov bl, 2
    xor ah, ah
    div bl          

    cmp ah, 0
    je is_even

is_odd:
    mov dx, offset odd_msg
    mov ah, 09h
    int 21h
    jmp exit_prog

is_even:
    mov dx, offset even_msg
    mov ah, 09h
    int 21h

exit_prog:
    mov ah, 4Ch
    int 21h

main endp
end main
