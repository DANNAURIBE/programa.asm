.model small
.stack 100h

.data
msg1 db 'Ingrese numero 1: $'
msg2 db 13,10,'Ingrese numero 2: $'
msgOp db 13,10,'Operacion (+,-,*,/): $'
res db 13,10,'Resultado: $'
error db 13,10,'Error (division por cero)$'

num1 dw ?
num2 dw ?
resultado dw ?
op db ?

buffer db 6,?,6 dup('$')

.code
main:
mov ax,@data
mov ds,ax

; ==============================
; SOLICITAR PRIMER NUMERO
; ==============================
mov ah,9
lea dx,msg1
int 21h

lea dx,buffer
call leerNumero
mov num1,ax

; ==============================
; SOLICITAR SEGUNDO NUMERO
; ==============================
mov ah,9
lea dx,msg2
int 21h

lea dx,buffer
call leerNumero
mov num2,ax

; ==============================
; SOLICITAR OPERACION
; ==============================
mov ah,9
lea dx,msgOp
int 21h

mov ah,1
int 21h
mov op,al   ; Guardamos el operador

; ==========================================================
; NOTA SOBRE ENTRADA DE OPERADORES (IMPORTANTE)
;
; En el emulador js-dos el teclado utiliza distribución inglesa (US).
; Por esta razón, algunos símbolos cambian respecto al teclado español.
;
; Para ingresar correctamente la suma (+), se debe presionar:
;        SHIFT + =
;
; Si no se hace esto, el sistema puede interpretar el símbolo '='
; en lugar de '+'. Por este motivo, el programa acepta ambos.
;
; TABLA DE EQUIVALENCIAS:
;
; TECLA PRESIONADA        CARÁCTER RECIBIDO
; -----------------------------------------
; SHIFT + =               +
; =                       =
; -                       -
; *                       *
; /                       /
;
; ==========================================================

mov al,op

cmp al,'+'
je suma

cmp al,'='   ; soporte para teclado en js-dos
je suma

cmp al,'-'
je resta

cmp al,'*'
je multi

cmp al,'/'
je divi

jmp fin

; ==============================
; OPERACIONES
; ==============================

suma:
mov ax,num1
add ax,num2
jmp guardar

resta:
mov ax,num1
sub ax,num2
jmp guardar

multi:
mov ax,num1
mul num2
jmp guardar

divi:
mov ax,num1
cmp num2,0
je error_div
xor dx,dx
div num2
jmp guardar

error_div:
mov ah,9
lea dx,error
int 21h
jmp fin

; ==============================
; MOSTRAR RESULTADO
; ==============================
guardar:
mov resultado,ax

mov ah,9
lea dx,res
int 21h

mov ax,resultado
call imprimirNumero

fin:
mov ah,4ch
int 21h

; ==============================
; LEER NUMERO
; ==============================
leerNumero proc
mov ah,0Ah
int 21h

mov si,dx
mov cl,[si+1]
mov ch,0
add si,2

xor ax,ax

convertir:
mov bl,[si]
sub bl,30h
mov bh,0

mov dx,10
mul dx
add ax,bx

inc si
loop convertir

ret
leerNumero endp

; ==============================
; IMPRIMIR NUMERO
; ==============================
imprimirNumero proc
mov cx,0
mov bx,10

cmp ax,0
jne convertir2

mov dl,'0'
mov ah,2
int 21h
ret

convertir2:
convertir_loop:
xor dx,dx
div bx
push dx
inc cx
cmp ax,0
jne convertir_loop

imprimir_loop:
pop dx
add dl,30h
mov ah,2
int 21h
loop imprimir_loop

ret
imprimirNumero endp

end main