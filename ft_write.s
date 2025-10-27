extern __errno_location

section .text
	global ft_write

; man write - ssize_t write(int fd, const void *buf, size_t count);
; description: writes up to count bytes from the buffer starting at buf to the file referred to by the file descriptor fd.
; return value: number of bytes written, or -1 on error.

ft_write:
	mov rax, 1                          ; syscall number for sys_write. we don't need to put the other args in registers because they are already there
	syscall

	cmp rax, 0                          ; check if return value is negative (error)
	jge .return                         ; if no error (rax >= 0), return
	neg rax                             ; write syscall returns negative error code, we will convert it to positive
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
