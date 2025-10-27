section .text
	global ft_strlen

; man strlen - size_t strlen(const char *s);
; description: function calculates the length of the string pointed to by s, excluding the terminating null byte ('\0').
; return value: number of bytes in the string pointed to by s.

ft_strlen:
	mov rax, 0                      ; use rax as counter, initialize to 0

	.loop:
		cmp byte [rdi + rax], 0     ; check for null terminator
		jz .return                  ; if null terminator is found, jump to return
		inc rax                     ; increment counter
		jmp .loop                   ; repeat the loop

	.return:
		ret                         ; leave the function

; rax -> return value
; rdi -> arg #1
; rsi -> arg #2
; rdx -> arg #3
; rcx -> arg #4
; r8  -> arg #5
; r9  -> arg #6
; best temp registers: al, dl
