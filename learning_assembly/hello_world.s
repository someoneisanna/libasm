; Simple assembly program that prints "Hello, World!" to the console

; SECTIONS:
; parts of the program that group different types of data and code
; they tell the assembler what kind of information is being defined and where it should be placed in memory
; they are usually three main sections: .data, .bss, and .text
; .data - contains initialized data, like strings and constants
; .bss - contains uninitialized data, like variables that don't have a value but need space allocated. The OS initializes this section to zero at runtime
; .text - contains the actual code (instructions) to be executed


; In this section, we will use the following order:
; [variable_name] [directive] [value]
; the directives we can use are: 
; - db (define byte):         1 byte (characters, small integers)
; - dw (define word):         2 bytes (short integers)
; - dd (define double word) : 4 bytes (integers, floats)
; - dq (define quad word):    8 bytes (large integers, doubles)

section .data
	msg db 'Hello, World!'

; The .text section contains the actual code to be executed
; In C, the OS looks for a function named main to start execution
; In assembly, we need to define the entry point of the program so the linker knows where to begin
; this is done using the global directive

section .text
	global _start

; Understanding the registers:
; Registers are small, fast storage locations inside the CPU (RAM is bigger, but slower). They hold data the processor is currently working on.
; In x86-64 architecture, there are several general-purpose registers, each with specific uses:
; - RAX: Accumulator — often used to store return values or results of operations; also used to hold syscall numbers.
; - RBX: Base register — general-purpose, sometimes used to store base addresses.
; - RCX: Counter — often used in loops or shifts.
; - RDX: Data register — often holds data for operations or syscall arguments.
; - RSI: Source index — often holds source data pointers (e.g., string copy source).
; - RDI: Destination index — often holds destination pointers (e.g., string copy destination).
; - RBP: Base pointer — points to the base of the current stack frame (used in functions).
; - RSP: Stack pointer — points to the top of the stack (used for function calls, pushes, pops).
; - RIP: Instruction pointer — points to the next instruction to execute (automatically managed).
; See full list: https://math.hws.edu/eck/cs220/f22/registers.html

; According to the x86-64 calling convention, when calling a function the registers are used as follows:
; - rax -> return value
; - rdi -> arg #1
; - rsi -> arg #2
; - rdx -> arg #3
; - r10 -> arg #4
; - r8  -> arg #5
; - r9  -> arg #6

; Calling conventions - set of rules that decides which registers or stack locations are used when one function calls another.
; In x86-64 Linux, the first six integer or pointer arguments are passed in registers RDI, RSI, RDX, RCX, R8, and R9.
; Additional arguments are passed on the stack. The return value is usually stored in RAX.

; Syscalls - way for programs to request services from the OS kernel (like reading/writing files, allocating memory, etc.)
; In Linux x86-64, syscalls are made using the syscall instruction. We need to set up the registers with the appropriate arguments before making the syscall:
; First you use mov to put the arguments in the right registers, then you execute the syscall instruction.
; See full syscall table: https://syscalls.w3challs.com/?arch=x86-64
; If your program is meant to run on its own, you should always properly exit with a syscall. Without it, the CPU will continue executing whatever bytes come 
; after your code, leading to crashes or undefined behavior.

_start:
	mov rax, 1          ; syscall: write
	mov rdi, 1          ; file descriptor: stdout
	mov rsi, msg        ; pointer to message
	mov rdx, 13         ; message length
	syscall

	mov rax, 60         ; syscall: exit
	mov rdi, 0          ; status: 0
	syscall

; In order to assemble and link this program, we will use:
; nasm -f elf64 hello_world.s -o hello_world.o
; ld -o hello hello_world.o
; ./hello
