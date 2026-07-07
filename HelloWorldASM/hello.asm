;*****************************************************************************
; hello.asm
;
;  A 32-bit (Win32) NASM program that calls the C runtime printf function to
;  print a greeting to the console, then cleanly exits via ExitProcess.
;
;  NOTE: The leading underscores (_main, _printf) and the @4 suffix on
;  ExitProcess are the 32-bit name-decoration convention, so build this
;  project for the x86 / Win32 platform.
;*****************************************************************************

    global  _main            ; entry point the linker looks for (x86)
    extern  _printf          ; C runtime: int printf(const char *fmt, ...)
    extern  _ExitProcess@4   ; Win32 API: void ExitProcess(UINT code)

section .data
msg:
    db  'Welcome to CYBV311!!', 10, 0   ; 10 = newline (\n), 0 = null terminator

section .text
_main:
    push    msg              ; push the address of msg (printf's format arg)
    call    _printf          ; call printf to write the string to stdout
    add     esp, 4           ; clean up the one argument we pushed (cdecl)

; ExitProcess(0) -- return exit code 0 to Windows
    push    0
    call    _ExitProcess@4

