; ============================================================
; Program 1: Integer Calculator (Two Numbers)
; Course: Computer Architecture - 202016893 - UNAD
; Description: Asks the user for two numbers and an operation
;              (+, -, *, /) and displays the result.
; Assembler: MASM (x86 16-bit, DOS)
; ============================================================

.MODEL SMALL
.STACK 100H

.DATA
    ; ---- Messages ----
    msg_title   DB  "=== INTEGER CALCULATOR ===", 13, 10, "$"
    msg_num1    DB  "Enter first number  (0-9): $"
    msg_num2    DB  "Enter second number (0-9): $"
    msg_op      DB  "Enter operation (+, -, *, /): $"
    msg_result  DB  13, 10, "Result: $"
    msg_newline DB  13, 10, "$"
    msg_error   DB  13, 10, "Division by zero!", 13, 10, "$"

.CODE
MAIN PROC
    ; Initialize data segment
    MOV  AX, @DATA
    MOV  DS, AX

    ; ---- Display title ----
    MOV  AH, 09H
    LEA  DX, msg_title
    INT  21H

    ; ---- Read first number ----
    MOV  AH, 09H
    LEA  DX, msg_num1
    INT  21H

    MOV  AH, 01H        ; Read character from keyboard
    INT  21H
    SUB  AL, '0'        ; Convert ASCII -> numeric (0-9)
    MOV  BL, AL         ; BL = first number

    ; ---- New line ----
    MOV  AH, 09H
    LEA  DX, msg_newline
    INT  21H

    ; ---- Read second number ----
    MOV  AH, 09H
    LEA  DX, msg_num2
    INT  21H

    MOV  AH, 01H
    INT  21H
    SUB  AL, '0'        ; Convert ASCII -> numeric
    MOV  CL, AL         ; CL = second number

    ; ---- New line ----
    MOV  AH, 09H
    LEA  DX, msg_newline
    INT  21H

    ; ---- Read operator ----
    MOV  AH, 09H
    LEA  DX, msg_op
    INT  21H

    MOV  AH, 01H
    INT  21H
    MOV  DL, AL         ; DL = operator character

    ; ---- New line ----
    MOV  AH, 09H
    LEA  DX, msg_newline
    INT  21H

    ; ---- Determine operation ----
    CMP  DL, '+'
    JE   DO_ADD
    CMP  DL, '-'
    JE   DO_SUB
    CMP  DL, '*'
    JE   DO_MUL
    CMP  DL, '/'
    JE   DO_DIV
    JMP  EXIT_PROG      ; Unknown operator

DO_ADD:
    MOV  AL, BL
    ADD  AL, CL         ; AL = num1 + num2
    JMP  SHOW_RESULT

DO_SUB:
    MOV  AL, BL
    SUB  AL, CL         ; AL = num1 - num2
    JMP  SHOW_RESULT

DO_MUL:
    MOV  AL, BL
    MUL  CL             ; AX = num1 * num2  (result in AX)
    JMP  SHOW_RESULT

DO_DIV:
    CMP  CL, 0          ; Check for division by zero
    JE   DIV_ERROR
    MOV  AL, BL
    MOV  AH, 0
    DIV  CL             ; AL = quotient, AH = remainder
    JMP  SHOW_RESULT

DIV_ERROR:
    MOV  AH, 09H
    LEA  DX, msg_error
    INT  21H
    JMP  EXIT_PROG

SHOW_RESULT:
    ; ---- Display "Result: " label ----
    MOV  AH, 09H
    LEA  DX, msg_result
    INT  21H

    ; ---- Convert result in AL to printable digits ----
    ; Handle numbers 0-99 (two-digit at most for 9*9=81)
    MOV  AH, 0
    MOV  BX, 10
    DIV  BL             ; AL = tens digit, AH = units digit

    CMP  AL, 0
    JE   SKIP_TENS      ; Skip leading zero
    ADD  AL, '0'
    MOV  DL, AL
    MOV  AH, 02H
    INT  21H

SKIP_TENS:
    MOV  AL, AH
    ADD  AL, '0'
    MOV  DL, AL
    MOV  AH, 02H
    INT  21H

    ; ---- New line ----
    MOV  AH, 09H
    LEA  DX, msg_newline
    INT  21H

EXIT_PROG:
    ; Terminate program
    MOV  AH, 4CH
    MOV  AL, 0
    INT  21H

MAIN ENDP
END MAIN
