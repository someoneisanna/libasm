extern __errno_location

section .text
	global ft_read

; man read - ssize_t read(int fd, void *buf, size_t count);
; description: attempts to read up to count bytes from file descriptor fd into the buffer starting at buf
; return value: number of bytes read, or -1 on error.

ft_read:
	mov rax, 0                          ; syscall number for sys_read. we don't need to put the other args in registers because they are already there
	syscall

	cmp rax, 0                          ; check if return value is negative (error)
	jge .return                         ; if no error (rax >= 0), return
	neg rax                             ; read syscall returns negative error code, we will convert it to positive
	mov rdi, rax                        ; move error value (rax) into rdi temporarily
	call __errno_location wrt ..plt     ; returns in rax a pointer to the thread-local errno variable
	mov [rax], edi                      ; store errno value (lower 32-bits of rdi) into the memory location pointed by rax -> errno will have the positive error code
	mov rax, -1                         ; set return value to -1 to indicate error

	.return:
		ret

; rax -> return value
; rdi -> arg #1
; rsi -> arg #2
; rdx -> arg #3
; rcx -> arg #4
; r8  -> arg #5
; r9  -> arg #6
; best temp registers: al, dl
