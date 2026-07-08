;*****************************************************************************
; hello.asm
;
;  A 64-bit (Linux / x86-64) NASM program that calls the C runtime printf
;  function to print a greeting to the console, then returns cleanly to the
;  C runtime, which exits the process.
;
;  This is the Linux counterpart to HelloWorldASM/hello.asm. Use it to
;  validate a Linux install by confirming that the NASM assembler, the GNU
;  linker, and the C runtime (libc) are all present and working.
;
;  NOTE: Linux uses the System V AMD64 calling convention. The first integer
;  argument is passed in RDI (not on the stack like 32-bit Windows cdecl),
;  and for a variadic function such as printf, AL must hold the number of
;  vector (SSE) registers used - zero here. There is no leading-underscore
;  name decoration on Linux, so the entry point is 'main' and we call
;  'printf' directly. Build this project for the x86-64 (ELF64) platform.
;*****************************************************************************

    global  main             ; entry point the C runtime calls
    extern  printf           ; C runtime: int printf(const char *fmt, ...)

    default rel              ; use RIP-relative addressing for data references

section .data
msg:
    db  'Welcome to CYBV311!!', 10, 0   ; 10 = newline (\n), 0 = null terminator

section .text
main:
    push    rbp              ; keep the stack 16-byte aligned across the call
    lea     rdi, [msg]       ; 1st arg: address of msg (printf's format string)
    xor     eax, eax         ; variadic call uses 0 vector registers
    call    printf           ; call printf to write the string to stdout
    pop     rbp              ; restore the stack

; return 0 to the C runtime, which then exits the program
    xor     eax, eax
    ret

; Mark the stack as non-executable. Without this section NASM emits no stack
; note, so the linker warns and conservatively assumes an executable stack.
section .note.GNU-stack noalloc noexec nowrite progbits

