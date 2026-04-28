; ============================================================
; Program 5: Personalized Text String Display
; Course: Computer Architecture - 202016893 - UNAD
; Description: Displays the student's full name and career
;              using INT 21H with decorative formatting.
;              Modify STUDENT_NAME and CAREER as needed.
; Assembler: MASM (x86 16-bit, DOS)
; ============================================================

.MODEL SMALL
.STACK 100H

.DATA
    ; ---- Decorative elements ----
    line_top    DB  "****************************************************", 13, 10, "$"
    line_mid    DB  "**                                                **", 13, 10, "$"
    line_bot    DB  "****************************************************", 13, 10, "$"
    blank_line  DB  13, 10, "$"

    ; ---- Course info ----
    label_course  DB  "**   Course  : Computer Architecture 202016893   **", 13, 10, "$"
    label_unad    DB  "**   UNAD - National Open and Distance University **", 13, 10, "$"

    ; ---- Student data (EDIT THESE) ----
    label_name    DB  "**   Student : Ana Maria Garcia Lopez             **", 13, 10, "$"
    label_career  DB  "**   Career  : Systems Engineering                **", 13, 10, "$"

    ; ---- Footer ----
    msg_greet     DB  "**         Assembly Language - Task 4             **", 13, 10, "$"
    msg_year      DB  "**                   2026                         **", 13, 10, "$"

.CODE
MAIN PROC
    ; Initialize data segment
    MOV  AX, @DATA
    MOV  DS, AX

    ; ---- Top border ----
    MOV  AH, 09H
    LEA  DX, line_top
    INT  21H

    ; ---- Blank padding ----
    MOV  AH, 09H
    LEA  DX, line_mid
    INT  21H

    ; ---- Course label ----
    MOV  AH, 09H
    LEA  DX, label_course
    INT  21H

    ; ---- University label ----
    MOV  AH, 09H
    LEA  DX, label_unad
    INT  21H

    ; ---- Separator ----
    MOV  AH, 09H
    LEA  DX, line_mid
    INT  21H

    ; ---- Student name ----
    MOV  AH, 09H
    LEA  DX, label_name
    INT  21H

    ; ---- Career ----
    MOV  AH, 09H
    LEA  DX, label_career
    INT  21H

    ; ---- Separator ----
    MOV  AH, 09H
    LEA  DX, line_mid
    INT  21H

    ; ---- Greeting / Task info ----
    MOV  AH, 09H
    LEA  DX, msg_greet
    INT  21H

    ; ---- Year ----
    MOV  AH, 09H
    LEA  DX, msg_year
    INT  21H

    ; ---- Blank padding ----
    MOV  AH, 09H
    LEA  DX, line_mid
    INT  21H

    ; ---- Bottom border ----
    MOV  AH, 09H
    LEA  DX, line_bot
    INT  21H

    ; ---- Extra blank line ----
    MOV  AH, 09H
    LEA  DX, blank_line
    INT  21H

    ; Terminate program
    MOV  AH, 4CH
    MOV  AL, 0
    INT  21H

MAIN ENDP
END MAIN
