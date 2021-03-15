;*****************************************************************************
; hello.asm
;
;  Uses the printf function to print 
;*****************************************************************************

    global  _main
    extern  _printf
    extern  _ExitProcess@4

    section .text
_main:
    push    msg      ; push the msg on the stack
    call    _printf  ; call the printf function

; ExitProcess(0)
    push    0
    call    _ExitProcess@4

msg:
    db  'Welcome to CYBV311!!', 10, 0