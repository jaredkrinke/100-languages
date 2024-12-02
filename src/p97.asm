main:
    ; Add binary-coded decimal digits (10 digits, 5 bytes)
    lda digits
    add a
    daa
    sta digits
    lda digits+1
    adc a
    daa
    sta digits+1
    lda digits+2
    adc a
    daa
    sta digits+2
    lda digits+3
    adc a
    daa
    sta digits+3
    lda digits+4
    adc a
    daa
    sta digits+4

    ; Update counter
    lda counter
    sui 1
    sta counter
    lda counter+1
    sbi 0
    sta counter+1
    lda counter+2
    sbi 0
    sta counter+2
    lda counter+3
    sbi 0
    sta counter+3

    ; Loop if needed
    lda counter
    adi 0
    jnz main
    lda counter+1
    adi 0
    jnz main
    lda counter+2
    adi 0
    jnz main
    lda counter+3
    adi 0
    jnz main

    ; Add one, as given in the problem
    lda digits
    adi 1
    sta digits

    ; All done; inspect "digits" for resulting digits
    hlt

    ; Store data at 0xe0
    org 0eh

digits:
    ; 28433 as 10 packed binary coded decimal digits (little-endian)
    db 33h
    db 84h
    db 02h
    db 00h
    db 00h

counter:
    ; 7830457 as 32-bit little-endian
    db 0b9h
    db 7bh
    db 77h
    db 00h

