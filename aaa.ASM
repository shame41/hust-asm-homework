assume cs:code, ds:buf, ss:stack


buf segment
        dw 64 dup(0)
buf ends

stack segment stack
        dw 32 dup(0)
stack ends

code segment

start:      
            mov ax, buf
            mov ds, ax
            mov cx, 1
getcx:    
            call loopword
            add bx, 2
            loop getcx
            mov cx, ds:[0]
;========================================================
            mov bx, 2
loopnum:    
            call loopword
            add bx, 2
            loop loopnum
;========================================================
            mov ax, 0
            mov bx, 2
            mov cx, ds:[0]
s:       
            mov dx, ds:[bx]
            and ds:[bx], 0FC00H
            cmp ds:[bx], 0FC00H
            jne set
            inc ax
set:
            add bx, 2
            loop s

            mov ax, 4C00H
            int 21H

loopword:      
            mov ah, 0      
            int 16h
            cmp al, 20H;20H是空格的ascii码
            je endloopword

            mov ah, 0
            ; mov bx, ax
            push ax
            mov ax, ds:[bx]
            mov dx, 0Ah
            mul dx
            mov ds:[bx], ax
            pop ax
            sub ax, 30h
            add ds:[bx], ax
            add ax, 30h
            jmp loopword
endloopword:ret

code ends
end start
end