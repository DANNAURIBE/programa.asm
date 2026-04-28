; ============================================================
; Program 3: Decimal to Binary Converter (single digit 0-9)
; Course: Computer Architecture - 202016893 - UNAD
; Description: Receives a decimal digit (0-9) and displays
;              its 4-bit binary equivalent using shift/rotate.
; Assembler: MASM (x86 16-bit, DOS)
; ============================================================

.MODEL SMALL
.STACK 100H

.DATA
    msg_title   DB  "=== DECIMAL TO BINARY CONVERTER ===", 13, 10, "$"
    msg_prompt  DB  "Enter a digit (0-9): $"
    msg_result  DB  13, 10, "Binary equivalent: $"
    msg_newline DB  13, 10, "$"
    msg_arrow   DB  " -> $"

.CODE
MAIN PROC
    ; Initialize data segment
    MOV  AX, @DATA
    MOV  DS, AX

    ; ---- Display title ----
    MOV  AH, 09H
    LEA  DX, msg_title
    INT  21H

    ; ---- Read digit from user ----
    MOV  AH, 09H
    LEA  DX, msg_prompt
    INT  21H

    MOV  AH, 01H        ; Read single character
    INT  21H
    MOV  BL, AL         ; BL = ASCII character (save for echo)
    SUB  AL, '0'        ; Convert ASCII to numeric value (0-9)
    MOV  CL, AL         ; CL = numeric value

    ; ---- Print " -> " arrow ----
    MOV  AH, 09H
    LEA  DX, msg_arrow
    INT  21H

    ; ---- Display "Binary equivalent: " label ----
    MOV  AH, 09H
    LEA  DX, msg_result
    INT  21H

    ; ---- Convert to binary and display (4 bits) ----
    ; We test bits 3, 2, 1, 0 from MSB to LSB using AND mask
    MOV  AL, CL         ; AL = value to convert

    ; Bit 3 (value 8)
    MOV  AH, AL
    AND  AH, 08H        ; Mask bit 3
    JZ   BIT3_ZERO
    MOV  DL, '1'
    JMP  PRINT_BIT3
BIT3_ZERO:
    MOV  DL, '0'
PRINT_BIT3:
    MOV  AH, 02H
    INT  21H

    ; Bit 2 (value 4)
    MOV  AH, AL
    AND  AH, 04H
    JZ   BIT2_ZERO
    MOV  DL, '1'
    JMP  PRINT_BIT2
BIT2_ZERO:
    MOV  DL, '0'
PRINT_BIT2:
    MOV  AH, 02H
    INT  21H

    ; Bit 1 (value 2)
    MOV  AH, AL
    AND  AH, 02H
    JZ   BIT1_ZERO
    MOV  DL, '1'
    JMP  PRINT_BIT1
BIT1_ZERO:
    MOV  DL, '0'
PRINT_BIT1:
    MOV  AH, 02H
    INT  21H

    ; Bit 0 (value 1)
    MOV  AH, AL
    AND  AH, 01H
    JZ   BIT0_ZERO
    MOV  DL, '1'
    JMP  PRINT_BIT0
BIT0_ZERO:
    MOV  DL, '0'
PRINT_BIT0:
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
