.model small
.stack 100h

.data
    msg_start db 'Get Ready...',13,10,'$'
    msg_press db 'NOW!',13,10,'$'
    msg_time  db 'Your reaction time: ',0
    time_buf  db '00000 ms',13,10,'$'

.code
    start:      
                mov  ax,@data
                mov  ds,ax

    main_loop:  
                lea  dx,msg_start    ; GET READY...
                mov  ah,09h
                int  21h

                mov  cx,1000
    delay_outer:
                mov  dx,4000
    delay_inner:
                dec  dx
                jnz  delay_inner
                loop delay_outer

                lea  dx,msg_press    ; NOW!
                mov  ah,09h
                int  21h

                mov  ah,00h
                int  1Ah
                mov  bx,dx

    wait_key:   
                mov  ah,01h
                int  16h
                jz   wait_key

                mov  ah,00h
                int  1Ah
                mov  dx,dx

                sub  dx,bx
                mov  ax,dx
                mov  bx,55
                mul  bx

                lea  di,time_buf
                call PrintNumber

                lea  dx,time_buf
                mov  ah,09h
                int  21h

                mov  ah,00h
                int  16h
                jmp  main_loop

PrintNumber proc
                mov  cx,5
                add  di,4
    print_digit:
                xor  dx,dx
                mov  bx,10
                div  bx
                add  dl,'0'
                mov  [di],dl
                dec  di
                loop print_digit
                ret
PrintNumber endp

end start