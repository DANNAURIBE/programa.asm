; ============================================================
; Program 2: Ascending Counter 1 to 10
; Course: Computer Architecture - 202016893 - UNAD
; Description: Displays numbers from 1 to 10 sequentially
;              using a loop (LOOP instruction).
; Assembler: MASM (x86 16-bit, DOS)
; ============================================================

.MODEL SMALL
.STACK 100H

.DATA
    msg_title   DB  "=== COUNTER 1 TO 10 ===", 13, 10, "$"
    msg_space   DB  " ", "$"
    msg_newline DB  13, 10, "$"
    msg_done    DB  13, 10, "Count complete!", 13, 10, "$"

.CODE
MAIN PROC
    ; Initialize data segment
    MOV  AX, @DATA
    MOV  DS, AX

    ; ---- Display title ----
    MOV  AH, 09H
    LEA  DX, msg_title
    INT  21H

    ; ---- Initialize counter ----
    MOV  CX, 10         ; CX = loop counter (10 iterations)
    MOV  BL, 1          ; BL = current number to display (starts at 1)

COUNT_LOOP:
    ; ---- Print current number ----
    MOV  AL, BL
    CMP  AL, 10         ; Check if number is 10 (two digits)
    JE   PRINT_TEN

    ; Single-digit: 1-9
    ADD  AL, '0'        ; Convert digit to ASCII
    MOV  DL, AL
    MOV  AH, 02H
    INT  21H
    JMP  AFTER_PRINT

PRINT_TEN:
    ; Print '1' then '0'
    MOV  DL, '1'
    MOV  AH, 02H
    INT  21H
    MOV  DL, '0'
    MOV  AH, 02H
    INT  21H

AFTER_PRINT:
    ; ---- Print space separator ----
    MOV  AH, 09H
    LEA  DX, msg_space
    INT  21H

    INC  BL             ; Increment number to display

    LOOP COUNT_LOOP     ; Decrement CX; jump if CX != 0

    ; ---- Done message ----
    MOV  AH, 09H
    LEA  DX, msg_done
    INT  21H

    ; Terminate program
    MOV  AH, 4CH
    MOV  AL, 0
    INT  21H

MAIN ENDP
END MAIN
