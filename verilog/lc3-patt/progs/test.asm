.orig   x3000
main
        and     r0, r0, #0  ; x3000: assert r0 = 0
        add     r1, r0, #10 ; x3001: assert r1 = 10
        add     r2, r1, x-F ; x3002: assert r2 = -5
        not     r3, r0      ; x3003: assert r3 = -1/xFFFF
        ld      r4, CONST   ; x3004: assert r4 = xDEAD
        ldi     r5, CONSTI  ; x3005: assert r5 = xDEAD
        lea     r6, main    ; x3006: assert r6 = x3000, note that the book has it set CC
        not     r4, r4      ; x3007: assert r4 = x2152
        st      r4, CONST   ; x3008: assert mem[x300B] = x2152
        sti     r6, CONSTI  ; x3009: assert mem[x300B] = x3000
        br      ldr_str     ; x300A: assert pc = x301D
CONST   .fill   xDEAD       ; x300B:
CONSTI  .fill   CONST       ; x300C:
scratch .blkw   16          ; x300D:
ldr_str
        lea     r0, scratch ; x301D: assert r0 = x300d
        ldr     r1, r0, #-2 ; x301E: assert r1 = x3000
        add     r1, r1, #15 ; x301F: assert r1 = x300f
        str     r1, r0, #6  ; x3020: assert mem[x3013] = x300f
        ldr     r2, r0, #6  ; x3021: assert r2 = x300f
.end
