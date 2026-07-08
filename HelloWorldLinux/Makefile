# Makefile for the Linux Hello World (x86-64 NASM + libc printf)
#
#   make        Assemble and link the program (default target: build)
#   make run    Build if needed, then run it
#   make debug  Build with DWARF debug symbols for gdb
#   make gdb    Build with symbols and launch gdb on the program
#   make clean  Remove the generated object file and executable
#
# Requirements: nasm, ld, and gcc (with a C runtime / libc). On Debian or
# Ubuntu:   sudo apt install nasm gcc gdb

TARGET  := hello
SRC     := hello.asm
OBJ     := hello.o

# nasm produces a 64-bit ELF object; gcc links it against libc for printf.
# -no-pie keeps the linker from requiring position-independent startup code.
ASM     := nasm
ASMFLAGS:= -f elf64
CC      := gcc
LDFLAGS := -no-pie

# Debug builds add DWARF line/symbol info: -g -F dwarf for nasm, -g for gcc.
DBGASMFLAGS := $(ASMFLAGS) -g -F dwarf
DBGLDFLAGS  := $(LDFLAGS) -g

.PHONY: build run debug gdb clean

build: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(LDFLAGS) $(OBJ) -o $(TARGET)

$(OBJ): $(SRC)
	$(ASM) $(ASMFLAGS) $(SRC) -o $(OBJ)

run: build
	./$(TARGET)

# Rebuild from scratch with debug symbols so gdb can show source lines.
debug: clean
	$(ASM) $(DBGASMFLAGS) $(SRC) -o $(OBJ)
	$(CC) $(DBGLDFLAGS) $(OBJ) -o $(TARGET)

# Build with symbols and drop into gdb.
gdb: debug
	gdb ./$(TARGET)

clean:
	rm -f $(OBJ) $(TARGET)
