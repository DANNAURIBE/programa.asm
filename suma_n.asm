; ============================================================
; Program 4: Sum of First N Natural Numbers
; Course: Computer Architecture - 202016893 - UNAD
; Description: Reads N from the user (0-9) and computes the
;              sum 1 + 2 + 3 + ... + N, displaying the result.
; Assembler: MASM (x86 16-bit, DOS)
; ============================================================

.MODEL SMALL
.STACK 100H

.DATA
    msg_title   DB  "=== SUM OF FIRST N NATURAL NUMBERS ===", 13, 10, "$"
    msg_prompt  DB  "Enter N (0-9): $"
    msg_result  DB  13, 10, "Sum(1..N) = $"
    msg_newline DB  13, 10, "$"

.CODE
MAIN PROC
    ; Initialize data segment
    MOV  AX, @DATA
    MOV  DS, AX

    ; ---- Display title ----
    MOV  AH, 09H
    LEA  DX, msg_title
    INT  21H

    ; ---- Read N from user ----
    MOV  AH, 09H
    LEA  DX, msg_prompt
    INT  21H

    MOV  AH, 01H        ; Read character
    INT  21H
    SUB  AL, '0'        ; Convert ASCII to number
    MOV  CL, AL         ; CL = N (loop limit)
    MOV  CH, 0          ; Clear high byte

    ; ---- Accumulate sum in AX ----
    MOV  AX, 0          ; AX = accumulator (sum)
    MOV  BL, 1          ; BL = current addend (starts at 1)

    CMP  CL, 0
    JE   SHOW_RESULT    ; If N=0, sum=0

SUM_LOOP:
    ADD  AL, BL         ; sum = sum + current_number
    INC  BL             ; Increment current number
    DEC  CL             ; Decrement loop counter
    JNZ  SUM_LOOP       ; Repeat while CL != 0

SHOW_RESULT:
    ; ---- Display "Sum = " label ----
    MOV  AH, 09H
    LEA  DX, msg_result
    INT  21H

    ; ---- Convert AX to printable digits (max sum for N=9 is 45) ----
    MOV  AH, 0
    MOV  BL, 10
    DIV  BL             ; AL = tens, AH = units

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

    ; Terminate program
    MOV  AH, 4CH
    MOV  AL, 0
    INT  21H

MAIN ENDP
END MAIN
