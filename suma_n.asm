.model small
.stack 100h

.data
msg_titulo db 13,10,'=== SUM OF THE FIRST N NATURAL NUMBERS ===',13,10,'$'
msg db 'Enter N (0-9): $'
res db 13,10,'Sum(1..N) = $'

resultado dw ?

.code
main:
mov ax,@data
mov ds,ax

; ==============================
; DISPLAY TITLE
; ==============================
mov ah,9
lea dx,msg_titulo
int 21h

; ==============================
; REQUEST N
; ==============================
mov ah,9
lea dx,msg
int 21h

mov ah,1
int 21h
sub al,30h
mov cl,al

; ==============================
; CALCULATE SUM
; ==============================
mov ax,0
mov bl,1

sumar:
add ax,bx
inc bx
loop sumar

mov resultado,ax   ; save result safely

; ==============================
; DISPLAY RESULT
; ==============================
mov ah,9
lea dx,res
int 21h

mov ax,resultado
call imprimirNumero

; ==============================
; END PROGRAM
; ==============================
mov ah,4ch
int 21h

; ==============================
; PRINT NUMBER PROCEDURE
; ==============================
imprimirNumero proc
push ax
push bx
push cx
push dx

mov cx,0
mov bx,10

cmp ax,0
jne convertir

mov dl,'0'
mov ah,2
int 21h
jmp fin_imp

convertir:
ciclo:
xor dx,dx
div bx
push dx
inc cx
cmp ax,0
jne ciclo

imprimir:
pop dx
add dl,30h
mov ah,2
int 21h
loop imprimir

fin_imp:
pop dx
pop cx
pop bx
pop ax
ret
imprimirNumero endp

end main