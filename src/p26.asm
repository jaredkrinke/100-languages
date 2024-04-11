;;; Project Euler problem 26, in an x86 boot sector

;;; Approach: keep track of remainders when dividing. If remainder
;;; seen again, then there's a cycle, so calculate how many steps are
;;; in the cycle.

;;; Boot sector requirements
bits 16				; 16-bit ("real") mode
org 0x7c00

;;; Entry point
init:
	mov ax, 0		; Set ds=0 by way of ax
	mov ds, ax		; Supposedly necessary for BIOS API
start:
	mov bx, 0		; Counter
	mov dx, 0		; Best number
	mov si, 0		; Longest period
loop:
	add bx, 1
	cmp bx, 1000		; Only check < 1000
	je done
	mov cx, bx		; Compute period
	call period
	cmp ax, si		; Check if better
	jg better
	jmp loop
better:
	mov si, ax		; Update best number/length
	mov dx, bx
	jmp loop
done:
	mov ax, dx		; Print best number
	call printn
	jmp halt

;;; Print the digit stored in ax
printd:
	push ax
	add ax, '0'		; ASCII-ify
	mov ah, 0xe		; Print character
	int 0x10
	pop ax
	ret

;;; Print the nonnegative integer stored in ax
printn:
	push dx
	push cx
	push bx
	push ax
	push si
	mov bx, 10		; Divisor
	mov si, 0		; Digit count
printn_next:
	mov dx, 0
	idiv bx 		; dx:ax -> remainder, quotient
	push dx			; Push remainder (digit) onto stack
	add si, 1
	cmp ax, 0
	jnz printn_next
printn_digit:
	cmp si, 0		; Check for done with digits
	jz printn_done
	pop ax
	call printd		; Print from stack
	sub si, 1		; Decrement count
	jmp printn_digit
printn_done:
	mov ah, 0xe
	mov al, 13		; Carriage return
	int 0x10
	mov al, 10		; Line feed
	int 0x10
	pop si
	pop ax
	pop bx
	pop cx
	pop dx
	ret

;;; Find the period (or zero) of the decimal fraction 1/cx; return in ax
period:
	push di
	push si
	push dx
	push cx
	push bx
	push ax
	mov di, 0		; Count of entries in "remainder" list
	mov bx, 10		; Base 10
	mov ax, 10		; Start numerator at 10
period_test:			; Check if remainder >= divisor
	cmp ax, cx
	jge period_divide
	imul ax, bx		; Multiply by 10
	jmp period_test
period_divide:
	mov dx, 0		; Zero top bits of numerator for idiv
	idiv cx
	cmp dx, 0		; Check for no remainder (i.e. no period at all)
	jz period_zero
	mov ax, dx	     	; Only care about remainder
	add di, 1		; Add remainder to stack of "seen" remainders
	push ax
	mov dx, 0		; Counter for loop
	mov si, sp
period_check:			; Check if remainder has been seen before
	add si, 2		; Advance through list of remainders (each 2 bytes)
	add dx, 1
	cmp dx, di		; Check if done looking
	je period_test
	cmp ax, [si]		; Check against this item
	jne period_check
	mov ax, dx		; Match! Compute distance and return it
	jmp period_done
period_zero:
	mov ax, 0
period_done:
	;; Pop list off stack
	cmp di, 0
	jz period_return
	pop bx
	sub di, 1
	jmp period_done
period_return:	
	pop bx			; Not a typo; don't restore ax since it holds the result
	pop bx
	pop cx
	pop dx
	pop si
	pop di
	ret

halt:
	hlt

;;; Boot sector magic bytes
times 510 -( $ - $$ ) db 0
db 0x55, 0xaa
