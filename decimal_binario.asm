; ============================================================
; Program: Decimal to Binary Converter
; Course: Computer Architecture - 202016893 - UNAD
; Assembler: TASM (x86 16-bit, DOS)
; ============================================================

.MODEL SMALL
.STACK 100H

.DATA
    msg_title   DB  "=== DECIMAL TO BINARY CONVERTER ===", 13, 10, "$"
    msg_input   DB  "Enter a digit (0-9): $"
    msg_arrow   DB  " -> Binary equivalent: $"
    msg_newline DB  13, 10, "$"

.CODE
MAIN PROC
    MOV  AX, @DATA
    MOV  DS, AX

    ; Mostrar titulo
    MOV  AH, 09H
    LEA  DX, msg_title
    INT  21H

    ; Pedir digito
    MOV  AH, 09H
    LEA  DX, msg_input
    INT  21H

    ; Leer caracter
    MOV  AH, 01H
    INT  21H
    SUB  AL, '0'        ; Convertir ASCII a numero
    MOV  BL, AL         ; BL = numero (0-9)

    ; Mostrar flecha
    MOV  AH, 09H
    LEA  DX, msg_arrow
    INT  21H

    ; Mostrar 4 bits (bit 3, bit 2, bit 1, bit 0)
    ; Bit 3
    MOV  AL, BL
    AND  AL, 08H        ; Mascara 1000
    CMP  AL, 0
    JE   BIT3_0
    MOV  DL, '1'
    JMP  PRINT_BIT3
BIT3_0:
    MOV  DL, '0'
PRINT_BIT3:
    MOV  AH, 02H
    INT  21H

    ; Bit 2
    MOV  AL, BL
    AND  AL, 04H        ; Mascara 0100
    CMP  AL, 0
    JE   BIT2_0
    MOV  DL, '1'
    JMP  PRINT_BIT2
BIT2_0:
    MOV  DL, '0'
PRINT_BIT2:
    MOV  AH, 02H
    INT  21H

    ; Bit 1
    MOV  AL, BL
    AND  AL, 02H        ; Mascara 0010
    CMP  AL, 0
    JE   BIT1_0
    MOV  DL, '1'
    JMP  PRINT_BIT1
BIT1_0:
    MOV  DL, '0'
PRINT_BIT1:
    MOV  AH, 02H
    INT  21H

    ; Bit 0
    MOV  AL, BL
    AND  AL, 01H        ; Mascara 0001
    CMP  AL, 0
    JE   BIT0_0
    MOV  DL, '1'
    JMP  PRINT_BIT0
BIT0_0:
    MOV  DL, '0'
PRINT_BIT0:
    MOV  AH, 02H
    INT  21H

    ; Nueva linea
    MOV  AH, 09H
    LEA  DX, msg_newline
    INT  21H

FIN:
    MOV  AH, 4CH
    INT  21H

MAIN ENDP
END MAIN