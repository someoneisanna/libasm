section .text
	global ft_strcpy

; man strcpy - char *strcpy(char *dest, const char *src);
; description: copies the string pointed to by src, including the terminating null byte ('\0'), to the buffer pointed to by dest.
; return value: pointer to the destination string dest.

ft_strcpy:
	mov rcx, 0                  ; use rcx as index counter, initialize to 0
	
	.loop:
		mov al, [rsi + rcx]     ; load byte from src (rsi) into a 8-bit temp register
		mov [rdi + rcx], al     ; store byte from the temp register into dest (rdi)
		inc rcx                 ; increment index counter
		cmp al, 0               ; check for null terminator in src
		jnz .loop               ; if null terminator is not found, repeat the loop
	
	mov rax, rdi                ; set return value to dest pointer
	ret

; rax -> return value
; rdi -> arg #1
; rsi -> arg #2
; rdx -> arg #3
; rcx -> arg #4
; r8  -> arg #5
; r9  -> arg #6
; best temp registers: al, dl
