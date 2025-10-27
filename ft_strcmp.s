section .text
	global ft_strcmp

; man strcmp - int strcmp(const char *s1, const char *s2);
; description: compares the two strings s1 and s2.
; return value: 0 if s1 and s2 are equal, a negative value if s1 is less than s2, and a positive value if s1 is greater than s2.

ft_strcmp:
	mov rcx, 0                                ; use rcx as index counter, initialize to 0
	
	.loop:
		mov al, [rdi + rcx]                   ; load byte from s1 (rdi) into al
		mov dl, [rsi + rcx]                   ; load byte from s2 (rsi) into dl
		sub al, dl                            ; subtract s1 byte from s2 byte
		jnz .return                           ; if bytes are not equal, return the difference (which is in al)
		cmp byte [rdi + rcx], 0               ; check for null terminator in s1
		jz .return                            ; if null terminator is found, strings are equal
		inc rcx                               ; increment index counter
		jmp .loop                             ; repeat the loop

	.return:
		movsx eax, al                         ; put result in eax with sign extension
		ret

; rax -> return value
; rdi -> arg #1
; rsi -> arg #2
; rdx -> arg #3
; rcx -> arg #4
; r8  -> arg #5
; r9  -> arg #6
; best temp registers: al, dl

