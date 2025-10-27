extern malloc
extern ft_strlen
extern ft_strcpy

extern __errno_location

section .text
	global ft_strdup

; man strdup - char *strdup(const char *s);
; description: duplicates the string s by allocating sufficient memory for a copy of s.
; return value: pointer to the duplicated string, or NULL if insufficient memory was available.

ft_strdup:
	push rdi                            ; save original s pointer
	call ft_strlen                      ; get length of s (rdi is already s)
	inc rax                             ; add 1 for null terminator

	mov rdi, rax                        ; put the size into rdi for malloc call
	call malloc wrt ..plt               ; allocate memory with malloc
	cmp rax, 0                          ; check if malloc returned NULL
	jnz .continue                       ; if not NULL, continue
	call __errno_location wrt ..plt     ; get pointer to errno
	mov dword [rax], 12                 ; set errno to ENOMEM (12)
	mov rax, 0                          ; return NULL if malloc failed
	ret
	
	.continue:
		pop rdi                         ; restore original s pointer
		mov rsi, rdi                    ; source pointer for ft_strcpy is s
		mov rdi, rax                    ; destination pointer for ft_strcpy is the allocated memory
		call ft_strcpy                  ; copy string s into allocated memory
		ret                             ; return pointer to duplicated string in rax

; rax -> return value
; rdi -> arg #1
; rsi -> arg #2
; rdx -> arg #3
; rcx -> arg #4
; r8  -> arg #5
; r9  -> arg #6
; best temp registers: al, dl
