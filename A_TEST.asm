
includelib ucrtd.lib

extern _CrtIsValidHeapPointer : proc

extern puts : proc
extern gets : proc
extern atol : proc
extern calloc : proc
extern free : proc
extern strcat : proc
extern strcpy : proc
extern strlen : proc

extern _getch : proc
extern _itoa : proc
extern _exit : proc

.code

    _intToString:
    
        ; Start Prologue
        push rbp      ; Save the old base pointer value (pop later).
        mov rbp, rsp  ; Set the new base pointer value (for this method).
        sub rsp, 8   ; Make room for 1 8-byte local variable(s)s.
        ; End prologue.
        
        ; Start copy vars.
        mov [rbp-8], rcx
        ; End copy vars.
        
        ; Start method body.
        mov rcx, 100
        mov rdx, 1
        sub rsp, 32
        call calloc
        add rsp, 32
        
        ; Move pointer into rdx
        mov rdx, rax
        
        ; Move base 10 into third parameter.
        mov r8, 10
        
        ; Move the integer back into rcx.
        mov rcx, [rbp-8]
        
        sub rsp, 32
        call _itoa
        add rsp, 32
        ;End method body.

        ; Start Epilogue
        mov rsp, rbp ; Deallocate local variables
        pop rbp ; Restore the caller's base pointer value
        ret
        ; End Epilogue

    _writeInt:
        ; Prologue
        push rbp      ; Save the old base pointer value (pop later).
        mov rbp, rsp  ; Set the new base pointer value (for this method).
        ;sub rsp, 0   ; Make room for zero 8-byte local variables.
        
        sub rsp, 32
        call _intToString ; rax has pointer to string.
        add rsp, 32
        
        mov rcx, rax
        sub rsp, 32
        call puts
        add rsp, 32

        ; Subroutine Epilogue
        mov rsp, rbp ; Deallocate local variables
        pop rbp ; Restore the caller's base pointer value
        ret

    Start3$Go: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 8 
            mov rax, 0 
            mov [rbp-8], rax 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [11, 4].
                 
                ; Start compiler function (System.out.println) [12, 8].
                    lea rax, $$str0 ; [12, 27] Explicit string.
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [12, 26].
                 
                 
                ; Start assignment (num) [13, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start compiler function (System.compiler.atol) [13, 18].
                         
                        ; Start compiler function (System.in.readln) [13, 39].
                             
                            ; Start check and allocate memory [13, 39].
                                mov rcx, 2000 
                                imul rcx, 1 
                                cmp rcx, 1073741824 
                                jg allocTooBig4 
                                mov rdx, 1 
                                 
                                sub rsp, 32 
                                call calloc 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne allocSucceeded3 
                                allocTooBig4: 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr5 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 13859 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                allocSucceeded3: 
                            ; End check and allocate memory [13, 55].
                             
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call gets 
                            add rsp, 32 
                             
                        ; End compiler function (System.in.readln) [13, 55].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call atol 
                        add rsp, 32 
                         
                    ; End compiler function (System.compiler.atol) [13, 38].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (num) [13, 11].
                 
                 
                ; Start compiler function (System.out.println) [14, 8].
                     
                    ; Start plus (+) [14, 27].
                         
                        ; Start check and allocate memory [14, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig7 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded6 
                            allocTooBig7: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr8 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded6: 
                        ; End check and allocate memory [14, 30].
                         
                        push rax 
                         
                        ; Start plus (+) [14, 27].
                             
                            ; Start check and allocate memory [14, 27].
                                mov rcx, 2000 
                                imul rcx, 1 
                                cmp rcx, 1073741824 
                                jg allocTooBig10 
                                mov rdx, 1 
                                 
                                sub rsp, 32 
                                call calloc 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne allocSucceeded9 
                                allocTooBig10: 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr8 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 13859 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                allocSucceeded9: 
                            ; End check and allocate memory [14, 30].
                             
                            push rax 
                             
                            ; Start identifier (num) [14, 27].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 1 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (num) [14, 30].
                             
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _intToString 
                            add rsp, 32 
                             
                            mov rdx, rax 
                            pop rcx 
                            push rcx 
                             
                            sub rsp, 32 
                            call strcpy 
                            add rsp, 32 
                             
                            lea rax, $$str1 ; [14, 33] Explicit string.
                            mov rdx, rax 
                            pop rcx 
                             
                            sub rsp, 32 
                            call strcat 
                            add rsp, 32 
                             
                        ; End plus (+) [14, 30].
                         
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start multiply (*) [14, 51].
                             
                            ; Start identifier (num) [14, 55].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 1 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (num) [14, 58].
                             
                            push rax 
                             
                            ; Start identifier (num) [14, 51].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 1 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (num) [14, 54].
                             
                            pop r10 
                            imul rax, r10 
                        ; End multiply (*) [14, 54].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [14, 30].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [14, 26].
                 
                 
                ; Start compiler function (System.in.readln) [15, 8].
                     
                    ; Start check and allocate memory [15, 8].
                        mov rcx, 2000 
                        imul rcx, 1 
                        cmp rcx, 1073741824 
                        jg allocTooBig12 
                        mov rdx, 1 
                         
                        sub rsp, 32 
                        call calloc 
                        add rsp, 32 
                         
                        cmp rax, 0 
                        jne allocSucceeded11 
                        allocTooBig12: 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr13 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 13859 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        allocSucceeded11: 
                    ; End check and allocate memory [15, 24].
                     
                    mov rcx, rax 
                     
                    sub rsp, 32 
                    call gets 
                    add rsp, 32 
                     
                ; End compiler function (System.in.readln) [15, 24].
                 
            ; End block [11, 5].
             
        ; End statements.
         
        Start3$Go_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Start2$Go: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 8 
            mov rax, 0 
            mov [rbp-8], rax 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [22, 4].
                 
                ; Start compiler function (System.out.println) [23, 8].
                    lea rax, $$str2 ; [23, 27] Explicit string.
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [23, 26].
                 
                 
                ; Start compiler function (System.in.readln) [25, 8].
                     
                    ; Start check and allocate memory [25, 8].
                        mov rcx, 2000 
                        imul rcx, 1 
                        cmp rcx, 1073741824 
                        jg allocTooBig17 
                        mov rdx, 1 
                         
                        sub rsp, 32 
                        call calloc 
                        add rsp, 32 
                         
                        cmp rax, 0 
                        jne allocSucceeded16 
                        allocTooBig17: 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr18 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 13859 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        allocSucceeded16: 
                    ; End check and allocate memory [25, 24].
                     
                    mov rcx, rax 
                     
                    sub rsp, 32 
                    call gets 
                    add rsp, 32 
                     
                ; End compiler function (System.in.readln) [25, 24].
                 
                 
                ; Start assignment (a) [26, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start method call (AwesomeConstructor) [26, 20].
                         
                        ; Start get pointer and check [26, 20].
                             
                            ; Start new Awesome [26, 25].
                                 
                                ; Start check and allocate memory [26, 25].
                                    mov rcx, 5 
                                    imul rcx, 8 
                                    cmp rcx, 1073741824 
                                    jg allocTooBig20 
                                    mov rdx, 1 
                                     
                                    sub rsp, 32 
                                    call calloc 
                                    add rsp, 32 
                                     
                                    cmp rax, 0 
                                    jne allocSucceeded19 
                                    allocTooBig20: 
                                     
                                    ; Start write runtime string.
                                        lea rcx, $$runtimeStr21 
                                         
                                        sub rsp, 32 
                                        call puts 
                                        add rsp, 32 
                                         
                                    ; End write runtime string.
                                     
                                    mov rcx, 13859 
                                     
                                    sub rsp, 32 
                                    call _exit 
                                    add rsp, 32 
                                     
                                    allocSucceeded19: 
                                ; End check and allocate memory [26, 32].
                                 
                                lea r10, $$Awesome 
                                mov [rax], r10 
                            ; End new Awesome [26, 32].
                             
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull22 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr24 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull22: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed23 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr25 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed23: 
                            pop rax 
                        ; End get pointer and check [26, 21].
                         
                        push rax 
                        mov rax, 6 ; [26, 58] Explicit integer.
                        mov r8, rax ; arg2
                        mov rax, 5 ; [26, 55] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 4 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (AwesomeConstructor) [26, 21].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (a) [26, 15].
                 
                 
                ; Start method call (AddRef) [27, 8].
                     
                    ; Start get pointer and check [27, 8].
                         
                        ; Start identifier (a) [27, 8].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 1 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (a) [27, 9].
                         
                        push rax 
                        cmp rax, 0 
                        jne whewNotNull26 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr28 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 6 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        whewNotNull26: 
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _CrtIsValidHeapPointer 
                        add rsp, 32 
                         
                        cmp rax, 0 
                        jne whewNotFreed27 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr29 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 9 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        whewNotFreed27: 
                        pop rax 
                    ; End get pointer and check [27, 9].
                     
                    push rax 
                    mov rax, [rsp + 0 * 8] 
                    mov rcx, rax 
                    mov r10, [rax] 
                    mov r10, [r10 + 1 * 8] 
                     
                    sub rsp, 32 
                    call r10 
                    add rsp, 32 
                     
                    add rsp, 8 ; removing pushed arguemnts.
                ; End method call (AddRef) [27, 9].
                 
                 
                ; Start compiler function (System.in.readln) [28, 8].
                     
                    ; Start check and allocate memory [28, 8].
                        mov rcx, 2000 
                        imul rcx, 1 
                        cmp rcx, 1073741824 
                        jg allocTooBig31 
                        mov rdx, 1 
                         
                        sub rsp, 32 
                        call calloc 
                        add rsp, 32 
                         
                        cmp rax, 0 
                        jne allocSucceeded30 
                        allocTooBig31: 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr32 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 13859 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        allocSucceeded30: 
                    ; End check and allocate memory [28, 24].
                     
                    mov rcx, rax 
                     
                    sub rsp, 32 
                    call gets 
                    add rsp, 32 
                     
                ; End compiler function (System.in.readln) [28, 24].
                 
                 
                ; Start method call (Release) [29, 8].
                     
                    ; Start get pointer and check [29, 8].
                         
                        ; Start identifier (a) [29, 8].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 1 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (a) [29, 9].
                         
                        push rax 
                        cmp rax, 0 
                        jne whewNotNull33 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr35 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 6 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        whewNotNull33: 
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _CrtIsValidHeapPointer 
                        add rsp, 32 
                         
                        cmp rax, 0 
                        jne whewNotFreed34 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr36 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 9 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        whewNotFreed34: 
                        pop rax 
                    ; End get pointer and check [29, 9].
                     
                    push rax 
                    mov rax, [rsp + 0 * 8] 
                    mov rcx, rax 
                    mov r10, [rax] 
                    mov r10, [r10 + 2 * 8] 
                     
                    sub rsp, 32 
                    call r10 
                    add rsp, 32 
                     
                    add rsp, 8 ; removing pushed arguemnts.
                ; End method call (Release) [29, 9].
                 
                 
                ; Start compiler function (System.in.readln) [30, 8].
                     
                    ; Start check and allocate memory [30, 8].
                        mov rcx, 2000 
                        imul rcx, 1 
                        cmp rcx, 1073741824 
                        jg allocTooBig38 
                        mov rdx, 1 
                         
                        sub rsp, 32 
                        call calloc 
                        add rsp, 32 
                         
                        cmp rax, 0 
                        jne allocSucceeded37 
                        allocTooBig38: 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr39 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 13859 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        allocSucceeded37: 
                    ; End check and allocate memory [30, 24].
                     
                    mov rcx, rax 
                     
                    sub rsp, 32 
                    call gets 
                    add rsp, 32 
                     
                ; End compiler function (System.in.readln) [30, 24].
                 
            ; End block [22, 5].
             
        ; End statements.
         
        Start2$Go_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Start$Go: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 104 
            mov rax, 0 
            mov [rbp-8], rax 
            mov [rbp-16], rax 
            mov [rbp-24], rax 
            mov [rbp-32], rax 
            mov [rbp-40], rax 
            mov [rbp-48], rax 
            mov [rbp-56], rax 
            mov [rbp-64], rax 
            mov [rbp-72], rax 
            mov [rbp-80], rax 
            mov [rbp-88], rax 
            mov [rbp-96], rax 
            mov [rbp-104], rax 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [39, 4].
                 
                ; Start compiler function (System.out.println) [43, 8].
                    mov rax, 0 ; [43, 27] Explicit false.
                    mov rcx, rax ; Move result for println expression.
                    cmp rcx, 1 
                    jne printBoolFalse42 
                    lea rcx, $$true 
                    jmp printBoolEnd43 
                    printBoolFalse42: 
                    lea rcx, $$false 
                    printBoolEnd43: 
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (bool).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [43, 26].
                 
                 
                ; Start assignment (f) [46, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 3 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start new Fac [46, 16].
                         
                        ; Start check and allocate memory [46, 16].
                            mov rcx, 3 
                            imul rcx, 8 
                            cmp rcx, 1073741824 
                            jg allocTooBig45 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded44 
                            allocTooBig45: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr46 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded44: 
                        ; End check and allocate memory [46, 19].
                         
                        lea r10, $$Fac 
                        mov [rax], r10 
                    ; End new Fac [46, 19].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (f) [46, 9].
                 
                 
                ; Start assignment (dummy) [47, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start method call (SetA) [47, 16].
                         
                        ; Start get pointer and check [47, 16].
                             
                            ; Start identifier (f) [47, 16].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 3 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (f) [47, 17].
                             
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull47 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr49 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull47: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed48 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr50 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed48: 
                            pop rax 
                        ; End get pointer and check [47, 17].
                         
                        push rax 
                        mov rax, 3 ; [47, 23] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 2 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (SetA) [47, 17].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (dummy) [47, 13].
                 
                 
                ; Start assignment (dummy) [48, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start method call (SetB) [48, 16].
                         
                        ; Start get pointer and check [48, 16].
                             
                            ; Start identifier (f) [48, 16].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 3 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (f) [48, 17].
                             
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull51 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr53 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull51: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed52 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr54 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed52: 
                            pop rax 
                        ; End get pointer and check [48, 17].
                         
                        push rax 
                        mov rax, 4 ; [48, 23] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 4 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (SetB) [48, 17].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (dummy) [48, 13].
                 
                 
                ; Start compiler function (System.out.println) [49, 8].
                     
                    ; Start method call (AddAllAnd1) [49, 27].
                         
                        ; Start get pointer and check [49, 27].
                             
                            ; Start identifier (f) [49, 27].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 3 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (f) [49, 28].
                             
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull55 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr57 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull55: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed56 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr58 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed56: 
                            pop rax 
                        ; End get pointer and check [49, 28].
                         
                        push rax 
                        mov rax, 6 ; [49, 43] Explicit integer.
                        mov r8, rax ; arg2
                        mov rax, 5 ; [49, 40] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 5 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (AddAllAnd1) [49, 28].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call _writeInt ; CompilerFunction call (int).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [49, 26].
                 
                 
                ; Start method call (WriteArgs) [50, 8].
                     
                    ; Start get pointer and check [50, 8].
                         
                        ; Start identifier (f) [50, 8].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 3 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (f) [50, 9].
                         
                        push rax 
                        cmp rax, 0 
                        jne whewNotNull59 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr61 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 6 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        whewNotNull59: 
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _CrtIsValidHeapPointer 
                        add rsp, 32 
                         
                        cmp rax, 0 
                        jne whewNotFreed60 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr62 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 9 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        whewNotFreed60: 
                        pop rax 
                    ; End get pointer and check [50, 9].
                     
                    push rax 
                    mov rax, 6 ; [50, 35] Explicit integer.
                    push rax ; arg6
                    mov rax, 5 ; [50, 32] Explicit integer.
                    push rax ; arg5
                    mov rax, 4 ; [50, 29] Explicit integer.
                    push rax ; arg4
                    mov rax, 3 ; [50, 26] Explicit integer.
                    mov r9, rax ; arg3
                    mov rax, 2 ; [50, 23] Explicit integer.
                    mov r8, rax ; arg2
                    mov rax, 1 ; [50, 20] Explicit integer.
                    mov rdx, rax ; arg1
                    mov rax, [rsp + 3 * 8] 
                    mov rcx, rax 
                    mov r10, [rax] 
                    mov r10, [r10 + 6 * 8] 
                     
                    sub rsp, 32 
                    call r10 
                    add rsp, 32 
                     
                    add rsp, 32 ; removing pushed arguemnts.
                ; End method call (WriteArgs) [50, 9].
                 
                 
                ; Start assignment (f2) [53, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 4 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start new Fac2 [53, 17].
                         
                        ; Start check and allocate memory [53, 17].
                            mov rcx, 4 
                            imul rcx, 8 
                            cmp rcx, 1073741824 
                            jg allocTooBig64 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded63 
                            allocTooBig64: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr65 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded63: 
                        ; End check and allocate memory [53, 21].
                         
                        lea r10, $$Fac2 
                        mov [rax], r10 
                    ; End new Fac2 [53, 21].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (f2) [53, 10].
                 
                 
                ; Start assignment (dummy) [54, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start method call (SetA) [54, 16].
                         
                        ; Start get pointer and check [54, 16].
                             
                            ; Start identifier (f2) [54, 16].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 4 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (f2) [54, 18].
                             
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull66 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr68 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull66: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed67 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr69 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed67: 
                            pop rax 
                        ; End get pointer and check [54, 18].
                         
                        push rax 
                        mov rax, 3 ; [54, 24] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 2 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (SetA) [54, 18].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (dummy) [54, 13].
                 
                 
                ; Start assignment (dummy) [55, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start method call (SetB) [55, 16].
                         
                        ; Start get pointer and check [55, 16].
                             
                            ; Start identifier (f2) [55, 16].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 4 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (f2) [55, 18].
                             
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull70 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr72 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull70: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed71 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr73 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed71: 
                            pop rax 
                        ; End get pointer and check [55, 18].
                         
                        push rax 
                        mov rax, 4 ; [55, 24] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 4 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (SetB) [55, 18].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (dummy) [55, 13].
                 
                 
                ; Start compiler function (System.out.println) [56, 8].
                     
                    ; Start method call (AddAllAnd1) [56, 27].
                         
                        ; Start get pointer and check [56, 27].
                             
                            ; Start identifier (f2) [56, 28].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 4 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (f2) [56, 30].
                             
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull74 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr76 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull74: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed75 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr77 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed75: 
                            pop rax 
                        ; End get pointer and check [56, 28].
                         
                        push rax 
                        mov rax, 6 ; [56, 46] Explicit integer.
                        mov r8, rax ; arg2
                        mov rax, 5 ; [56, 43] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 5 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (AddAllAnd1) [56, 28].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call _writeInt ; CompilerFunction call (int).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [56, 26].
                 
                 
                ; Start compiler function (System.out.println) [57, 8].
                     
                    ; Start method call (AddAllAnd2) [57, 27].
                         
                        ; Start get pointer and check [57, 27].
                             
                            ; Start identifier (f2) [57, 28].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 4 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (f2) [57, 30].
                             
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull78 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr80 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull78: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed79 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr81 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed79: 
                            pop rax 
                        ; End get pointer and check [57, 28].
                         
                        push rax 
                        mov rax, 6 ; [57, 46] Explicit integer.
                        mov r8, rax ; arg2
                        mov rax, 5 ; [57, 43] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 9 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (AddAllAnd2) [57, 28].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call _writeInt ; CompilerFunction call (int).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [57, 26].
                 
                 
                ; Start compiler function (System.out.println) [59, 8].
                    mov rax, 11111111 ; [59, 27] Explicit integer.
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call _writeInt ; CompilerFunction call (int).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [59, 26].
                 
                 
                ; Start assignment (array) [62, 8].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start new int[] [62, 16].
                        mov rax, 10 ; [62, 24] Explicit integer.
                        push rax 
                        add rax, 1 
                         
                        ; Start check and allocate memory [62, 16].
                            mov rcx, rax 
                            imul rcx, 8 
                            cmp rcx, 1073741824 
                            jg allocTooBig83 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded82 
                            allocTooBig83: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr84 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded82: 
                        ; End check and allocate memory [62, 19].
                         
                        pop r10 
                        mov [rax], r10 
                    ; End new int[] [62, 19].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (array) [62, 13].
                 
                 
                ; Start assignment (k) [64, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 2 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    mov rax, 0 ; [64, 12] Explicit integer.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (k) [64, 9].
                 
                 
                ; Start while [65, 8].
                     
                    ; Start less (<) [65, 14].
                         
                        ; Start array length (int[].length) [65, 18].
                             
                            ; Start get pointer and check [65, 18].
                                 
                                ; Start identifier (array) [65, 18].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+1 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (array) [65, 23].
                                 
                                push rax 
                                cmp rax, 0 
                                jne whewNotNull85 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr87 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 6 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotNull85: 
                                mov rcx, rax 
                                 
                                sub rsp, 32 
                                call _CrtIsValidHeapPointer 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne whewNotFreed86 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr88 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 9 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotFreed86: 
                                pop rax 
                            ; End get pointer and check [65, 23].
                             
                            mov rax, [rax] 
                        ; End array length (int[].length) [65, 23].
                         
                        push rax 
                         
                        ; Start identifier (k) [65, 14].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (k) [65, 15].
                         
                        pop r10 
                        cmp rax, r10 
                        jnl lessFalse89 
                        mov rax, 1 
                        jmp lessEnd90 
                        lessFalse89: 
                        mov rax, 0 
                        lessEnd90: 
                    ; End less (<) [65, 15].
                     
                    cmp rax, 1 
                    jne whileEnd92 
                    whileStart91: 
                     
                    ; Start block [66, 8].
                         
                        ; Start array assignment [67, 12].
                             
                            ; Start plus (+) [67, 23].
                                mov rax, 10 ; [67, 27] Explicit integer.
                                push rax 
                                 
                                ; Start identifier (k) [67, 23].
                                     
                                    ; Start get identifier.
                                        lea rax, [rbp - 2 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (k) [67, 24].
                                 
                                pop r10 
                                add rax, r10 
                            ; End plus (+) [67, 24].
                             
                            push rax 
                             
                            ; Start get array and check [67, 12].
                                 
                                ; Start identifier (k) [67, 18].
                                     
                                    ; Start get identifier.
                                        lea rax, [rbp - 2 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (k) [67, 19].
                                 
                                push rax 
                                 
                                ; Start identifier (array) [67, 12].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+1 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (array) [67, 17].
                                 
                                pop r10 
                                cmp rax, 0 
                                jne whewTheArrayIsNotNull95 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr98 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 6 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewTheArrayIsNotNull95: 
                                cmp r10, [rax] 
                                jl whewTheArrayIndexIsNotHigh96 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr99 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 1734 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewTheArrayIndexIsNotHigh96: 
                                cmp r10, 0 
                                jge whewTheArrayIndexIsNotLow97 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr100 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 1734 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewTheArrayIndexIsNotLow97: 
                            ; End get array and check [67, 17].
                             
                            add r10, 1 
                            pop r11 
                            mov [rax + r10 * 8], r11 
                            mov rax, r11 
                        ; End array assignment [67, 17].
                         
                         
                        ; Start assignment (k) [68, 12].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                             
                            ; Start plus (+) [68, 16].
                                mov rax, 1 ; [68, 20] Explicit integer.
                                push rax 
                                 
                                ; Start identifier (k) [68, 16].
                                     
                                    ; Start get identifier.
                                        lea rax, [rbp - 2 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (k) [68, 17].
                                 
                                pop r10 
                                add rax, r10 
                            ; End plus (+) [68, 17].
                             
                            pop r10 
                            mov [r10], rax 
                        ; End assignment (k) [68, 13].
                         
                    ; End block [66, 9].
                     
                     
                    ; Start less (<) [65, 14].
                         
                        ; Start array length (int[].length) [65, 18].
                             
                            ; Start get pointer and check [65, 18].
                                 
                                ; Start identifier (array) [65, 18].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+1 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (array) [65, 23].
                                 
                                push rax 
                                cmp rax, 0 
                                jne whewNotNull101 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr87 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 6 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotNull101: 
                                mov rcx, rax 
                                 
                                sub rsp, 32 
                                call _CrtIsValidHeapPointer 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne whewNotFreed102 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr88 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 9 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotFreed102: 
                                pop rax 
                            ; End get pointer and check [65, 23].
                             
                            mov rax, [rax] 
                        ; End array length (int[].length) [65, 23].
                         
                        push rax 
                         
                        ; Start identifier (k) [65, 14].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (k) [65, 15].
                         
                        pop r10 
                        cmp rax, r10 
                        jnl lessFalse103 
                        mov rax, 1 
                        jmp lessEnd104 
                        lessFalse103: 
                        mov rax, 0 
                        lessEnd104: 
                    ; End less (<) [65, 15].
                     
                    cmp rax, 1 
                    je whileStart91 
                    whileEnd92: 
                ; End while [65, 13].
                 
                 
                ; Start assignment (k) [71, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 2 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    mov rax, 0 ; [71, 12] Explicit integer.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (k) [71, 9].
                 
                 
                ; Start while [72, 8].
                     
                    ; Start less (<) [72, 14].
                         
                        ; Start array length (int[].length) [72, 18].
                             
                            ; Start get pointer and check [72, 18].
                                 
                                ; Start identifier (array) [72, 18].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+1 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (array) [72, 23].
                                 
                                push rax 
                                cmp rax, 0 
                                jne whewNotNull105 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr107 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 6 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotNull105: 
                                mov rcx, rax 
                                 
                                sub rsp, 32 
                                call _CrtIsValidHeapPointer 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne whewNotFreed106 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr108 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 9 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotFreed106: 
                                pop rax 
                            ; End get pointer and check [72, 23].
                             
                            mov rax, [rax] 
                        ; End array length (int[].length) [72, 23].
                         
                        push rax 
                         
                        ; Start identifier (k) [72, 14].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (k) [72, 15].
                         
                        pop r10 
                        cmp rax, r10 
                        jnl lessFalse109 
                        mov rax, 1 
                        jmp lessEnd110 
                        lessFalse109: 
                        mov rax, 0 
                        lessEnd110: 
                    ; End less (<) [72, 15].
                     
                    cmp rax, 1 
                    jne whileEnd112 
                    whileStart111: 
                     
                    ; Start block [73, 8].
                         
                        ; Start compiler function (System.out.println) [74, 12].
                             
                            ; Start array access (int[x]) [74, 31].
                                 
                                ; Start get array and check [74, 31].
                                     
                                    ; Start identifier (k) [74, 37].
                                         
                                        ; Start get identifier.
                                            lea rax, [rbp - 2 * 8] 
                                        ; End get identifier.
                                         
                                        mov rax, [rax] 
                                    ; End identifier (k) [74, 38].
                                     
                                    push rax 
                                     
                                    ; Start identifier (array) [74, 31].
                                         
                                        ; Start get identifier.
                                            mov r10, [rbp + 16] 
                                            lea rax, [r10+1 * 8] 
                                        ; End get identifier.
                                         
                                        mov rax, [rax] 
                                    ; End identifier (array) [74, 36].
                                     
                                    pop r10 
                                    cmp rax, 0 
                                    jne whewTheArrayIsNotNull115 
                                     
                                    ; Start write runtime string.
                                        lea rcx, $$runtimeStr118 
                                         
                                        sub rsp, 32 
                                        call puts 
                                        add rsp, 32 
                                         
                                    ; End write runtime string.
                                     
                                    mov rcx, 6 
                                     
                                    sub rsp, 32 
                                    call _exit 
                                    add rsp, 32 
                                     
                                    whewTheArrayIsNotNull115: 
                                    cmp r10, [rax] 
                                    jl whewTheArrayIndexIsNotHigh116 
                                     
                                    ; Start write runtime string.
                                        lea rcx, $$runtimeStr119 
                                         
                                        sub rsp, 32 
                                        call puts 
                                        add rsp, 32 
                                         
                                    ; End write runtime string.
                                     
                                    mov rcx, 1734 
                                     
                                    sub rsp, 32 
                                    call _exit 
                                    add rsp, 32 
                                     
                                    whewTheArrayIndexIsNotHigh116: 
                                    cmp r10, 0 
                                    jge whewTheArrayIndexIsNotLow117 
                                     
                                    ; Start write runtime string.
                                        lea rcx, $$runtimeStr120 
                                         
                                        sub rsp, 32 
                                        call puts 
                                        add rsp, 32 
                                         
                                    ; End write runtime string.
                                     
                                    mov rcx, 1734 
                                     
                                    sub rsp, 32 
                                    call _exit 
                                    add rsp, 32 
                                     
                                    whewTheArrayIndexIsNotLow117: 
                                ; End get array and check [74, 36].
                                 
                                add r10, 1 
                                mov rax, [rax + r10 * 8] 
                            ; End array access (int[x]) [74, 36].
                             
                            mov rcx, rax ; Move result for println expression.
                             
                            sub rsp, 32 
                            call _writeInt ; CompilerFunction call (int).
                            add rsp, 32 
                             
                        ; End compiler function (System.out.println) [74, 30].
                         
                         
                        ; Start incrementer (k+=) [75, 12].
                            push rbx 
                             
                            ; Start plus (+) [75, 17].
                                mov rax, 1 ; [75, 21] Explicit integer.
                                push rax 
                                mov rax, 1 ; [75, 17] Explicit integer.
                                pop r10 
                                add rax, r10 
                            ; End plus (+) [75, 18].
                             
                            mov rbx, rax 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            add rax, rbx 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (k+=) [75, 13].
                         
                    ; End block [73, 9].
                     
                     
                    ; Start less (<) [72, 14].
                         
                        ; Start array length (int[].length) [72, 18].
                             
                            ; Start get pointer and check [72, 18].
                                 
                                ; Start identifier (array) [72, 18].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+1 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (array) [72, 23].
                                 
                                push rax 
                                cmp rax, 0 
                                jne whewNotNull121 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr107 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 6 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotNull121: 
                                mov rcx, rax 
                                 
                                sub rsp, 32 
                                call _CrtIsValidHeapPointer 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne whewNotFreed122 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr108 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 9 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotFreed122: 
                                pop rax 
                            ; End get pointer and check [72, 23].
                             
                            mov rax, [rax] 
                        ; End array length (int[].length) [72, 23].
                         
                        push rax 
                         
                        ; Start identifier (k) [72, 14].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (k) [72, 15].
                         
                        pop r10 
                        cmp rax, r10 
                        jnl lessFalse123 
                        mov rax, 1 
                        jmp lessEnd124 
                        lessFalse123: 
                        mov rax, 0 
                        lessEnd124: 
                    ; End less (<) [72, 15].
                     
                    cmp rax, 1 
                    je whileStart111 
                    whileEnd112: 
                ; End while [72, 13].
                 
                 
                ; Start assignment (k) [78, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 2 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    mov rax, 0 ; [78, 12] Explicit integer.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (k) [78, 9].
                 
                 
                ; Start compiler function (System.out.println) [79, 8].
                     
                    ; Start plus (+) [79, 27].
                         
                        ; Start check and allocate memory [79, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig126 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded125 
                            allocTooBig126: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr127 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded125: 
                        ; End check and allocate memory [79, 37].
                         
                        push rax 
                        lea rax, $$str3 ; [79, 27] Explicit string.
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start incrementer (k++) [79, 41].
                            push rbx 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            add rax, 1 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (k++) [79, 43].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [79, 37].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [79, 26].
                 
                 
                ; Start assignment (k) [80, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 2 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    mov rax, 0 ; [80, 12] Explicit integer.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (k) [80, 9].
                 
                 
                ; Start compiler function (System.out.println) [81, 8].
                     
                    ; Start plus (+) [81, 27].
                         
                        ; Start check and allocate memory [81, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig129 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded128 
                            allocTooBig129: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr130 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded128: 
                        ; End check and allocate memory [81, 38].
                         
                        push rax 
                        lea rax, $$str4 ; [81, 27] Explicit string.
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start incrementer (k++) [81, 42].
                            push rbx 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            add rax, 1 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            mov rax, r11 
                            pop rbx 
                        ; End incrementer (k++) [81, 43].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [81, 38].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [81, 26].
                 
                 
                ; Start compiler function (System.out.println) [83, 8].
                    lea rax, $$str5 ; [83, 27] Explicit string.
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [83, 26].
                 
                 
                ; Start compiler function (System.out.println) [84, 8].
                    lea rax, $$str6 ; [84, 27] Explicit string.
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [84, 26].
                 
                 
                ; Start compiler function (System.out.println) [85, 8].
                     
                    ; Start less (<) [85, 27].
                        mov rax, 4 ; [85, 31] Explicit integer.
                        push rax 
                        mov rax, 6 ; [85, 27] Explicit integer.
                        pop r10 
                        cmp rax, r10 
                        jnl lessFalse131 
                        mov rax, 1 
                        jmp lessEnd132 
                        lessFalse131: 
                        mov rax, 0 
                        lessEnd132: 
                    ; End less (<) [85, 28].
                     
                    mov rcx, rax ; Move result for println expression.
                    cmp rcx, 1 
                    jne printBoolFalse133 
                    lea rcx, $$true 
                    jmp printBoolEnd134 
                    printBoolFalse133: 
                    lea rcx, $$false 
                    printBoolEnd134: 
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (bool).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [85, 26].
                 
                 
                ; Start compiler function (System.out.println) [86, 8].
                     
                    ; Start plus (+) [86, 27].
                         
                        ; Start check and allocate memory [86, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig136 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded135 
                            allocTooBig136: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr137 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded135: 
                        ; End check and allocate memory [86, 38].
                         
                        push rax 
                         
                        ; Start plus (+) [86, 27].
                             
                            ; Start check and allocate memory [86, 27].
                                mov rcx, 2000 
                                imul rcx, 1 
                                cmp rcx, 1073741824 
                                jg allocTooBig139 
                                mov rdx, 1 
                                 
                                sub rsp, 32 
                                call calloc 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne allocSucceeded138 
                                allocTooBig139: 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr137 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 13859 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                allocSucceeded138: 
                            ; End check and allocate memory [86, 38].
                             
                            push rax 
                            lea rax, $$str7 ; [86, 27] Explicit string.
                            mov rdx, rax 
                            pop rcx 
                            push rcx 
                             
                            sub rsp, 32 
                            call strcpy 
                            add rsp, 32 
                             
                             
                            ; Start plus (+) [86, 42].
                                mov rax, 1 ; [86, 46] Explicit integer.
                                push rax 
                                mov rax, 5 ; [86, 42] Explicit integer.
                                pop r10 
                                add rax, r10 
                            ; End plus (+) [86, 43].
                             
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _intToString 
                            add rsp, 32 
                             
                            mov rdx, rax 
                            pop rcx 
                             
                            sub rsp, 32 
                            call strcat 
                            add rsp, 32 
                             
                        ; End plus (+) [86, 38].
                         
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                        lea rax, $$str8 ; [86, 51] Explicit string.
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [86, 38].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [86, 26].
                 
                 
                ; Start if [90, 8].
                     
                    ; Start equal (==) [90, 11].
                         
                        ; Start assignment (awesome) [90, 16].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 6 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, 6 ; [90, 26] Explicit integer.
                            pop r10 
                            mov [r10], rax 
                        ; End assignment (awesome) [90, 23].
                         
                        push rax 
                        mov rax, 5 ; [90, 11] Explicit integer.
                        pop r10 
                        cmp rax, r10 
                        jne equalFalse140 
                        mov rax, 1 
                        jmp equalEnd141 
                        equalFalse140: 
                        mov rax, 0 
                        equalEnd141: 
                    ; End equal (==) [90, 12].
                     
                    cmp rax, 1 
                    jne ifFalse142 
                     
                    ; Start block [91, 8].
                         
                        ; Start compiler function (System.out.println) [92, 12].
                            lea rax, $$str9 ; [92, 31] Explicit string.
                            mov rcx, rax ; Move result for println expression.
                             
                            sub rsp, 32 
                            call puts ; CompilerFunction call (string).
                            add rsp, 32 
                             
                        ; End compiler function (System.out.println) [92, 30].
                         
                    ; End block [91, 9].
                     
                    jmp ifEnd143 
                    ifFalse142: 
                     
                    ; Start block [95, 8].
                         
                        ; Start compiler function (System.out.println) [96, 12].
                            lea rax, $$str10 ; [96, 31] Explicit string.
                            mov rcx, rax ; Move result for println expression.
                             
                            sub rsp, 32 
                            call puts ; CompilerFunction call (string).
                            add rsp, 32 
                             
                        ; End compiler function (System.out.println) [96, 30].
                         
                    ; End block [95, 9].
                     
                    ifEnd143: 
                ; End if [90, 10].
                 
                 
                ; Start assignment (k) [99, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 2 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    mov rax, 10 ; [99, 12] Explicit integer.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (k) [99, 9].
                 
                 
                ; Start compiler function (System.out.println) [100, 8].
                     
                    ; Start plus (+) [100, 27].
                         
                        ; Start check and allocate memory [100, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig149 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded148 
                            allocTooBig149: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr150 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded148: 
                        ; End check and allocate memory [100, 33].
                         
                        push rax 
                        lea rax, $$str11 ; [100, 27] Explicit string.
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start incrementer (k+=) [100, 37].
                            push rbx 
                            mov rax, 5 ; [100, 42] Explicit integer.
                            mov rbx, rax 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            add rax, rbx 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (k+=) [100, 38].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [100, 33].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [100, 26].
                 
                 
                ; Start compiler function (System.out.println) [101, 8].
                     
                    ; Start plus (+) [101, 27].
                         
                        ; Start check and allocate memory [101, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig152 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded151 
                            allocTooBig152: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr153 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded151: 
                        ; End check and allocate memory [101, 33].
                         
                        push rax 
                        lea rax, $$str12 ; [101, 27] Explicit string.
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start incrementer (k-=) [101, 37].
                            push rbx 
                            mov rax, 5 ; [101, 42] Explicit integer.
                            mov rbx, rax 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            sub rax, rbx 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (k-=) [101, 38].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [101, 33].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [101, 26].
                 
                 
                ; Start compiler function (System.out.println) [102, 8].
                     
                    ; Start plus (+) [102, 27].
                         
                        ; Start check and allocate memory [102, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig155 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded154 
                            allocTooBig155: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr156 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded154: 
                        ; End check and allocate memory [102, 32].
                         
                        push rax 
                        lea rax, $$str13 ; [102, 27] Explicit string.
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start incrementer (k/=) [102, 36].
                            push rbx 
                            mov rax, 5 ; [102, 41] Explicit integer.
                            mov rbx, rax 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            mov rdx, 0 
                            idiv rbx 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (k/=) [102, 37].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [102, 32].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [102, 26].
                 
                 
                ; Start compiler function (System.out.println) [103, 8].
                     
                    ; Start plus (+) [103, 27].
                         
                        ; Start check and allocate memory [103, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig158 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded157 
                            allocTooBig158: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr159 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded157: 
                        ; End check and allocate memory [103, 33].
                         
                        push rax 
                        lea rax, $$str14 ; [103, 27] Explicit string.
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start incrementer (k*=) [103, 37].
                            push rbx 
                            mov rax, 8 ; [103, 42] Explicit integer.
                            mov rbx, rax 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            imul rax, rbx 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (k*=) [103, 38].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [103, 33].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [103, 26].
                 
                 
                ; Start compiler function (System.out.println) [104, 8].
                     
                    ; Start plus (+) [104, 27].
                         
                        ; Start check and allocate memory [104, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig161 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded160 
                            allocTooBig161: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr162 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded160: 
                        ; End check and allocate memory [104, 32].
                         
                        push rax 
                        lea rax, $$str15 ; [104, 27] Explicit string.
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start incrementer (k%=) [104, 36].
                            push rbx 
                            mov rax, 5 ; [104, 41] Explicit integer.
                            mov rbx, rax 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 2 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            mov rdx, 0 
                            idiv rbx 
                            mov rax, rdx 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (k%=) [104, 37].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [104, 32].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [104, 26].
                 
                 
                ; Start assignment (b) [106, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 7 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    lea rax, $$str16 ; [106, 19] Explicit string.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (b) [106, 14].
                 
                 
                ; Start for [107, 8].
                     
                    ; Start block [108, 8].
                         
                        ; Start assignment (lollerskates) [107, 12].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 8 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, 2 ; [107, 31] Explicit integer.
                            pop r10 
                            mov [r10], rax 
                        ; End assignment (lollerskates) [107, 15].
                         
                         
                        ; Start less (<) [107, 34].
                            mov rax, 1000000 ; [107, 49] Explicit integer.
                            push rax 
                             
                            ; Start identifier (lollerskates) [107, 34].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 8 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (lollerskates) [107, 46].
                             
                            pop r10 
                            cmp rax, r10 
                            jnl lessFalse165 
                            mov rax, 1 
                            jmp lessEnd166 
                            lessFalse165: 
                            mov rax, 0 
                            lessEnd166: 
                        ; End less (<) [107, 46].
                         
                        cmp rax, 1 
                        jne forEnd164 
                        forStart163: 
                         
                        ; Start assignment (b) [109, 12].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 7 * 8] 
                            ; End get identifier.
                             
                            push rax 
                             
                            ; Start plus (+) [109, 16].
                                 
                                ; Start check and allocate memory [109, 16].
                                    mov rcx, 2000 
                                    imul rcx, 1 
                                    cmp rcx, 1073741824 
                                    jg allocTooBig168 
                                    mov rdx, 1 
                                     
                                    sub rsp, 32 
                                    call calloc 
                                    add rsp, 32 
                                     
                                    cmp rax, 0 
                                    jne allocSucceeded167 
                                    allocTooBig168: 
                                     
                                    ; Start write runtime string.
                                        lea rcx, $$runtimeStr169 
                                         
                                        sub rsp, 32 
                                        call puts 
                                        add rsp, 32 
                                         
                                    ; End write runtime string.
                                     
                                    mov rcx, 13859 
                                     
                                    sub rsp, 32 
                                    call _exit 
                                    add rsp, 32 
                                     
                                    allocSucceeded167: 
                                ; End check and allocate memory [109, 17].
                                 
                                push rax 
                                 
                                ; Start plus (+) [109, 16].
                                     
                                    ; Start check and allocate memory [109, 16].
                                        mov rcx, 2000 
                                        imul rcx, 1 
                                        cmp rcx, 1073741824 
                                        jg allocTooBig171 
                                        mov rdx, 1 
                                         
                                        sub rsp, 32 
                                        call calloc 
                                        add rsp, 32 
                                         
                                        cmp rax, 0 
                                        jne allocSucceeded170 
                                        allocTooBig171: 
                                         
                                        ; Start write runtime string.
                                            lea rcx, $$runtimeStr169 
                                             
                                            sub rsp, 32 
                                            call puts 
                                            add rsp, 32 
                                             
                                        ; End write runtime string.
                                         
                                        mov rcx, 13859 
                                         
                                        sub rsp, 32 
                                        call _exit 
                                        add rsp, 32 
                                         
                                        allocSucceeded170: 
                                    ; End check and allocate memory [109, 17].
                                     
                                    push rax 
                                     
                                    ; Start identifier (b) [109, 16].
                                         
                                        ; Start get identifier.
                                            lea rax, [rbp - 7 * 8] 
                                        ; End get identifier.
                                         
                                        mov rax, [rax] 
                                    ; End identifier (b) [109, 17].
                                     
                                    mov rdx, rax 
                                    pop rcx 
                                    push rcx 
                                     
                                    sub rsp, 32 
                                    call strcpy 
                                    add rsp, 32 
                                     
                                     
                                    ; Start identifier (lollerskates) [109, 20].
                                         
                                        ; Start get identifier.
                                            lea rax, [rbp - 8 * 8] 
                                        ; End get identifier.
                                         
                                        mov rax, [rax] 
                                    ; End identifier (lollerskates) [109, 32].
                                     
                                    mov rcx, rax 
                                     
                                    sub rsp, 32 
                                    call _intToString 
                                    add rsp, 32 
                                     
                                    mov rdx, rax 
                                    pop rcx 
                                     
                                    sub rsp, 32 
                                    call strcat 
                                    add rsp, 32 
                                     
                                ; End plus (+) [109, 17].
                                 
                                mov rdx, rax 
                                pop rcx 
                                push rcx 
                                 
                                sub rsp, 32 
                                call strcpy 
                                add rsp, 32 
                                 
                                lea rax, $$str17 ; [109, 35] Explicit string.
                                mov rdx, rax 
                                pop rcx 
                                 
                                sub rsp, 32 
                                call strcat 
                                add rsp, 32 
                                 
                            ; End plus (+) [109, 17].
                             
                            pop r10 
                            mov [r10], rax 
                        ; End assignment (b) [109, 13].
                         
                         
                        ; Start incrementer (lollerskates*=) [107, 58].
                            push rbx 
                            mov rax, 10 ; [107, 74] Explicit integer.
                            mov rbx, rax 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 8 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            imul rax, rbx 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (lollerskates*=) [107, 70].
                         
                         
                        ; Start less (<) [107, 34].
                            mov rax, 1000000 ; [107, 49] Explicit integer.
                            push rax 
                             
                            ; Start identifier (lollerskates) [107, 34].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 8 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (lollerskates) [107, 46].
                             
                            pop r10 
                            cmp rax, r10 
                            jnl lessFalse172 
                            mov rax, 1 
                            jmp lessEnd173 
                            lessFalse172: 
                            mov rax, 0 
                            lessEnd173: 
                        ; End less (<) [107, 46].
                         
                        cmp rax, 1 
                        je forStart163 
                        forEnd164: 
                    ; End block [108, 9].
                     
                ; End for [107, 11].
                 
                 
                ; Start compiler function (System.out.println) [111, 8].
                     
                    ; Start identifier (b) [111, 27].
                         
                        ; Start get identifier.
                            lea rax, [rbp - 7 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (b) [111, 28].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [111, 26].
                 
                 
                ; Start assignment (b) [113, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 7 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    lea rax, $$str16 ; [113, 12] Explicit string.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (b) [113, 9].
                 
                 
                ; Start for [114, 8].
                     
                    ; Start block [115, 8].
                         
                        ; Start assignment (lollerskates) [114, 12].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 9 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, 2 ; [114, 31] Explicit integer.
                            pop r10 
                            mov [r10], rax 
                        ; End assignment (lollerskates) [114, 15].
                         
                         
                        ; Start less (<) [114, 34].
                            mov rax, 1000000 ; [114, 49] Explicit integer.
                            push rax 
                             
                            ; Start identifier (lollerskates) [114, 34].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 9 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (lollerskates) [114, 46].
                             
                            pop r10 
                            cmp rax, r10 
                            jnl lessFalse176 
                            mov rax, 1 
                            jmp lessEnd177 
                            lessFalse176: 
                            mov rax, 0 
                            lessEnd177: 
                        ; End less (<) [114, 46].
                         
                        cmp rax, 1 
                        jne forEnd175 
                        forStart174: 
                         
                        ; Start assignment (b) [116, 12].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 7 * 8] 
                            ; End get identifier.
                             
                            push rax 
                             
                            ; Start plus (+) [116, 16].
                                 
                                ; Start check and allocate memory [116, 16].
                                    mov rcx, 2000 
                                    imul rcx, 1 
                                    cmp rcx, 1073741824 
                                    jg allocTooBig179 
                                    mov rdx, 1 
                                     
                                    sub rsp, 32 
                                    call calloc 
                                    add rsp, 32 
                                     
                                    cmp rax, 0 
                                    jne allocSucceeded178 
                                    allocTooBig179: 
                                     
                                    ; Start write runtime string.
                                        lea rcx, $$runtimeStr180 
                                         
                                        sub rsp, 32 
                                        call puts 
                                        add rsp, 32 
                                         
                                    ; End write runtime string.
                                     
                                    mov rcx, 13859 
                                     
                                    sub rsp, 32 
                                    call _exit 
                                    add rsp, 32 
                                     
                                    allocSucceeded178: 
                                ; End check and allocate memory [116, 17].
                                 
                                push rax 
                                 
                                ; Start plus (+) [116, 16].
                                     
                                    ; Start check and allocate memory [116, 16].
                                        mov rcx, 2000 
                                        imul rcx, 1 
                                        cmp rcx, 1073741824 
                                        jg allocTooBig182 
                                        mov rdx, 1 
                                         
                                        sub rsp, 32 
                                        call calloc 
                                        add rsp, 32 
                                         
                                        cmp rax, 0 
                                        jne allocSucceeded181 
                                        allocTooBig182: 
                                         
                                        ; Start write runtime string.
                                            lea rcx, $$runtimeStr180 
                                             
                                            sub rsp, 32 
                                            call puts 
                                            add rsp, 32 
                                             
                                        ; End write runtime string.
                                         
                                        mov rcx, 13859 
                                         
                                        sub rsp, 32 
                                        call _exit 
                                        add rsp, 32 
                                         
                                        allocSucceeded181: 
                                    ; End check and allocate memory [116, 17].
                                     
                                    push rax 
                                     
                                    ; Start identifier (b) [116, 16].
                                         
                                        ; Start get identifier.
                                            lea rax, [rbp - 7 * 8] 
                                        ; End get identifier.
                                         
                                        mov rax, [rax] 
                                    ; End identifier (b) [116, 17].
                                     
                                    mov rdx, rax 
                                    pop rcx 
                                    push rcx 
                                     
                                    sub rsp, 32 
                                    call strcpy 
                                    add rsp, 32 
                                     
                                     
                                    ; Start identifier (lollerskates) [116, 20].
                                         
                                        ; Start get identifier.
                                            lea rax, [rbp - 9 * 8] 
                                        ; End get identifier.
                                         
                                        mov rax, [rax] 
                                    ; End identifier (lollerskates) [116, 32].
                                     
                                    mov rcx, rax 
                                     
                                    sub rsp, 32 
                                    call _intToString 
                                    add rsp, 32 
                                     
                                    mov rdx, rax 
                                    pop rcx 
                                     
                                    sub rsp, 32 
                                    call strcat 
                                    add rsp, 32 
                                     
                                ; End plus (+) [116, 17].
                                 
                                mov rdx, rax 
                                pop rcx 
                                push rcx 
                                 
                                sub rsp, 32 
                                call strcpy 
                                add rsp, 32 
                                 
                                lea rax, $$str17 ; [116, 35] Explicit string.
                                mov rdx, rax 
                                pop rcx 
                                 
                                sub rsp, 32 
                                call strcat 
                                add rsp, 32 
                                 
                            ; End plus (+) [116, 17].
                             
                            pop r10 
                            mov [r10], rax 
                        ; End assignment (b) [116, 13].
                         
                         
                        ; Start incrementer (lollerskates*=) [114, 58].
                            push rbx 
                            mov rax, 2 ; [114, 74] Explicit integer.
                            mov rbx, rax 
                             
                            ; Start get identifier.
                                lea rax, [rbp - 9 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, [rax] 
                            push rax 
                            imul rax, rbx 
                            pop r11 
                            pop r10 
                            mov [r10], rax 
                            pop rbx 
                        ; End incrementer (lollerskates*=) [114, 70].
                         
                         
                        ; Start less (<) [114, 34].
                            mov rax, 1000000 ; [114, 49] Explicit integer.
                            push rax 
                             
                            ; Start identifier (lollerskates) [114, 34].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp - 9 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (lollerskates) [114, 46].
                             
                            pop r10 
                            cmp rax, r10 
                            jnl lessFalse183 
                            mov rax, 1 
                            jmp lessEnd184 
                            lessFalse183: 
                            mov rax, 0 
                            lessEnd184: 
                        ; End less (<) [114, 46].
                         
                        cmp rax, 1 
                        je forStart174 
                        forEnd175: 
                    ; End block [115, 9].
                     
                ; End for [114, 11].
                 
                 
                ; Start compiler function (System.out.println) [118, 8].
                     
                    ; Start identifier (b) [118, 27].
                         
                        ; Start get identifier.
                            lea rax, [rbp - 7 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (b) [118, 28].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [118, 26].
                 
                 
                ; Start if [121, 8].
                     
                    ; Start instanceof [121, 11].
                         
                        ; Start can cast [121, 11].
                             
                            ; Start get pointer and check [121, 11].
                                 
                                ; Start identifier (f2) [121, 11].
                                     
                                    ; Start get identifier.
                                        lea rax, [rbp - 4 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (f2) [121, 13].
                                 
                            ; End get pointer and check [121, 13].
                             
                            push rax 
                            cmp rax, 0 
                            je cancastFalse189 
                            mov rax, [rax] 
                            lea r10, $$Fac 
                            cancastStart187: 
                            cmp rax, r10 
                            je cancastTrue188 
                            mov rax, [rax] 
                            cmp rax, 0 
                            je cancastFalse189 
                            jmp cancastStart187 
                            cancastTrue188: 
                            pop rax 
                            jmp cancastEnd190 
                            cancastFalse189: 
                            pop rax 
                            mov rax, 0 
                            cancastEnd190: 
                        ; End can cast [121, 13].
                         
                        cmp rax, 0 
                        je instanceofFalse185 
                        mov rax, 1 
                        jmp instanceofEnd186 
                        instanceofFalse185: 
                        mov rax, 0 
                        instanceofEnd186: 
                    ; End instanceof [121, 13].
                     
                    cmp rax, 1 
                    jne ifFalse191 
                     
                    ; Start block [122, 8].
                         
                        ; Start assignment (dummy) [123, 12].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 11 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, 5 ; [123, 24] Explicit integer.
                            pop r10 
                            mov [r10], rax 
                        ; End assignment (dummy) [123, 15].
                         
                         
                        ; Start compiler function (System.out.println) [124, 12].
                            lea rax, $$str16 ; [124, 12] Explicit string.
                            mov rcx, rax ; Move result for println expression.
                             
                            sub rsp, 32 
                            call puts ; CompilerFunction call (string).
                            add rsp, 32 
                             
                        ; End compiler function (System.out.println) [124, 30].
                         
                         
                        ; Start compiler function (System.out.println) [125, 12].
                             
                            ; Start plus (+) [125, 31].
                                 
                                ; Start check and allocate memory [125, 31].
                                    mov rcx, 2000 
                                    imul rcx, 1 
                                    cmp rcx, 1073741824 
                                    jg allocTooBig196 
                                    mov rdx, 1 
                                     
                                    sub rsp, 32 
                                    call calloc 
                                    add rsp, 32 
                                     
                                    cmp rax, 0 
                                    jne allocSucceeded195 
                                    allocTooBig196: 
                                     
                                    ; Start write runtime string.
                                        lea rcx, $$runtimeStr197 
                                         
                                        sub rsp, 32 
                                        call puts 
                                        add rsp, 32 
                                         
                                    ; End write runtime string.
                                     
                                    mov rcx, 13859 
                                     
                                    sub rsp, 32 
                                    call _exit 
                                    add rsp, 32 
                                     
                                    allocSucceeded195: 
                                ; End check and allocate memory [125, 38].
                                 
                                push rax 
                                lea rax, $$str18 ; [125, 31] Explicit string.
                                mov rdx, rax 
                                pop rcx 
                                push rcx 
                                 
                                sub rsp, 32 
                                call strcpy 
                                add rsp, 32 
                                 
                                 
                                ; Start identifier (dummy) [125, 41].
                                     
                                    ; Start get identifier.
                                        lea rax, [rbp - 11 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (dummy) [125, 46].
                                 
                                mov rcx, rax 
                                 
                                sub rsp, 32 
                                call _intToString 
                                add rsp, 32 
                                 
                                mov rdx, rax 
                                pop rcx 
                                 
                                sub rsp, 32 
                                call strcat 
                                add rsp, 32 
                                 
                            ; End plus (+) [125, 38].
                             
                            mov rcx, rax ; Move result for println expression.
                             
                            sub rsp, 32 
                            call puts ; CompilerFunction call (string).
                            add rsp, 32 
                             
                        ; End compiler function (System.out.println) [125, 30].
                         
                    ; End block [122, 9].
                     
                    jmp ifEnd192 
                    ifFalse191: 
                     
                    ; Start block [128, 8].
                         
                        ; Start assignment (dummy) [129, 12].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 12 * 8] 
                            ; End get identifier.
                             
                            push rax 
                            mov rax, 3 ; [129, 24] Explicit integer.
                            pop r10 
                            mov [r10], rax 
                        ; End assignment (dummy) [129, 15].
                         
                         
                        ; Start compiler function (System.out.println) [131, 12].
                            lea rax, $$str10 ; [131, 31] Explicit string.
                            mov rcx, rax ; Move result for println expression.
                             
                            sub rsp, 32 
                            call puts ; CompilerFunction call (string).
                            add rsp, 32 
                             
                        ; End compiler function (System.out.println) [131, 30].
                         
                    ; End block [128, 9].
                     
                    ifEnd192: 
                ; End if [121, 10].
                 
                 
                ; Start compiler function (System.out.println) [135, 8].
                     
                    ; Start method call (GetString) [135, 27].
                         
                        ; Start get pointer and check [135, 27].
                            mov rax, [rbp + 16] ; [135, 27] Explicit this.
                            push rax 
                            cmp rax, 0 
                            jne whewNotNull200 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr202 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 6 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotNull200: 
                            mov rcx, rax 
                             
                            sub rsp, 32 
                            call _CrtIsValidHeapPointer 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne whewNotFreed201 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr203 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 9 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            whewNotFreed201: 
                            pop rax 
                        ; End get pointer and check [135, 31].
                         
                        push rax 
                        mov rax, 500 ; [135, 42] Explicit integer.
                        mov rdx, rax ; arg1
                        mov rax, [rsp + 0 * 8] 
                        mov rcx, rax 
                        mov r10, [rax] 
                        mov r10, [r10 + 2 * 8] 
                         
                        sub rsp, 32 
                        call r10 
                        add rsp, 32 
                         
                        add rsp, 8 ; removing pushed arguemnts.
                    ; End method call (GetString) [135, 31].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [135, 26].
                 
            ; End block [39, 5].
             
        ; End statements.
         
        Start$Go_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Start$GetString: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [141, 4].
                 
                ; Start if [142, 8].
                     
                    ; Start greater (>) [142, 11].
                        mov rax, 100 ; [142, 15] Explicit integer.
                        push rax 
                         
                        ; Start identifier (x) [142, 11].
                             
                            ; Start get identifier.
                                lea rax, [rbp + 16 + 1 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (x) [142, 12].
                         
                        pop r10 
                        cmp rax, r10 
                        jng greaterFalse206 
                        mov rax, 1 
                        jmp greaterEnd207 
                        greaterFalse206: 
                        mov rax, 0 
                        greaterEnd207: 
                    ; End greater (>) [142, 12].
                     
                    cmp rax, 1 
                    jne ifFalse208 
                    lea rax, $$str19 ; [143, 19] Explicit string.
                    jmp Start$GetString_Return 
                    jmp ifEnd209 
                    ifFalse208: 
                    lea rax, $$str20 ; [145, 19] Explicit string.
                    jmp Start$GetString_Return 
                    ifEnd209: 
                ; End if [142, 10].
                 
            ; End block [141, 5].
             
        ; End statements.
         
        Start$GetString_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac$GetA: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [153, 22].
                 
                ; Start identifier (a) [153, 31].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+1 * 8] 
                    ; End get identifier.
                     
                    mov rax, [rax] 
                ; End identifier (a) [153, 32].
                 
                jmp Fac$GetA_Return 
            ; End block [153, 23].
             
        ; End statements.
         
        Fac$GetA_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac$SetA: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [154, 27].
                 
                ; Start assignment (a) [154, 29].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start identifier (i) [154, 33].
                         
                        ; Start get identifier.
                            lea rax, [rbp + 16 + 1 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (i) [154, 34].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (a) [154, 30].
                 
                 
                ; Start identifier (i) [154, 43].
                     
                    ; Start get identifier.
                        lea rax, [rbp + 16 + 1 * 8] 
                    ; End get identifier.
                     
                    mov rax, [rax] 
                ; End identifier (i) [154, 44].
                 
                jmp Fac$SetA_Return 
            ; End block [154, 28].
             
        ; End statements.
         
        Fac$SetA_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac$GetB: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [156, 22].
                 
                ; Start identifier (b) [156, 31].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+2 * 8] 
                    ; End get identifier.
                     
                    mov rax, [rax] 
                ; End identifier (b) [156, 32].
                 
                jmp Fac$GetB_Return 
            ; End block [156, 23].
             
        ; End statements.
         
        Fac$GetB_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac$SetB: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [157, 27].
                 
                ; Start assignment (b) [157, 29].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+2 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start identifier (i) [157, 33].
                         
                        ; Start get identifier.
                            lea rax, [rbp + 16 + 1 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (i) [157, 34].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (b) [157, 30].
                 
                 
                ; Start identifier (i) [157, 43].
                     
                    ; Start get identifier.
                        lea rax, [rbp + 16 + 1 * 8] 
                    ; End get identifier.
                     
                    mov rax, [rax] 
                ; End identifier (i) [157, 44].
                 
                jmp Fac$SetB_Return 
            ; End block [157, 28].
             
        ; End statements.
         
        Fac$SetB_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac$AddAllAnd1: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 8 
            mov rax, 0 
            mov [rbp-8], rax 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [160, 4].
                 
                ; Start assignment (v) [162, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    mov rax, 1 ; [162, 12] Explicit integer.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (v) [162, 9].
                 
                 
                ; Start plus (+) [163, 15].
                     
                    ; Start identifier (v) [163, 31].
                         
                        ; Start get identifier.
                            lea rax, [rbp - 1 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (v) [163, 32].
                     
                    push rax 
                     
                    ; Start plus (+) [163, 15].
                         
                        ; Start identifier (y) [163, 27].
                             
                            ; Start get identifier.
                                lea rax, [rbp + 16 + 2 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (y) [163, 28].
                         
                        push rax 
                         
                        ; Start plus (+) [163, 15].
                             
                            ; Start identifier (x) [163, 23].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp + 16 + 1 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (x) [163, 24].
                             
                            push rax 
                             
                            ; Start plus (+) [163, 15].
                                 
                                ; Start identifier (b) [163, 19].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+2 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (b) [163, 20].
                                 
                                push rax 
                                 
                                ; Start identifier (a) [163, 15].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+1 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (a) [163, 16].
                                 
                                pop r10 
                                add rax, r10 
                            ; End plus (+) [163, 16].
                             
                            pop r10 
                            add rax, r10 
                        ; End plus (+) [163, 16].
                         
                        pop r10 
                        add rax, r10 
                    ; End plus (+) [163, 16].
                     
                    pop r10 
                    add rax, r10 
                ; End plus (+) [163, 16].
                 
                jmp Fac$AddAllAnd1_Return 
            ; End block [160, 5].
             
        ; End statements.
         
        Fac$AddAllAnd1_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac$WriteArgs: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [167, 4].
                 
                ; Start compiler function (System.out.println) [168, 8].
                     
                    ; Start plus (+) [168, 27].
                         
                        ; Start check and allocate memory [168, 27].
                            mov rcx, 2000 
                            imul rcx, 1 
                            cmp rcx, 1073741824 
                            jg allocTooBig223 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded222 
                            allocTooBig223: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr224 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded222: 
                        ; End check and allocate memory [168, 28].
                         
                        push rax 
                         
                        ; Start plus (+) [168, 27].
                             
                            ; Start check and allocate memory [168, 27].
                                mov rcx, 2000 
                                imul rcx, 1 
                                cmp rcx, 1073741824 
                                jg allocTooBig226 
                                mov rdx, 1 
                                 
                                sub rsp, 32 
                                call calloc 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne allocSucceeded225 
                                allocTooBig226: 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr224 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 13859 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                allocSucceeded225: 
                            ; End check and allocate memory [168, 28].
                             
                            push rax 
                             
                            ; Start plus (+) [168, 27].
                                 
                                ; Start check and allocate memory [168, 27].
                                    mov rcx, 2000 
                                    imul rcx, 1 
                                    cmp rcx, 1073741824 
                                    jg allocTooBig228 
                                    mov rdx, 1 
                                     
                                    sub rsp, 32 
                                    call calloc 
                                    add rsp, 32 
                                     
                                    cmp rax, 0 
                                    jne allocSucceeded227 
                                    allocTooBig228: 
                                     
                                    ; Start write runtime string.
                                        lea rcx, $$runtimeStr224 
                                         
                                        sub rsp, 32 
                                        call puts 
                                        add rsp, 32 
                                         
                                    ; End write runtime string.
                                     
                                    mov rcx, 13859 
                                     
                                    sub rsp, 32 
                                    call _exit 
                                    add rsp, 32 
                                     
                                    allocSucceeded227: 
                                ; End check and allocate memory [168, 28].
                                 
                                push rax 
                                 
                                ; Start plus (+) [168, 27].
                                     
                                    ; Start check and allocate memory [168, 27].
                                        mov rcx, 2000 
                                        imul rcx, 1 
                                        cmp rcx, 1073741824 
                                        jg allocTooBig230 
                                        mov rdx, 1 
                                         
                                        sub rsp, 32 
                                        call calloc 
                                        add rsp, 32 
                                         
                                        cmp rax, 0 
                                        jne allocSucceeded229 
                                        allocTooBig230: 
                                         
                                        ; Start write runtime string.
                                            lea rcx, $$runtimeStr224 
                                             
                                            sub rsp, 32 
                                            call puts 
                                            add rsp, 32 
                                             
                                        ; End write runtime string.
                                         
                                        mov rcx, 13859 
                                         
                                        sub rsp, 32 
                                        call _exit 
                                        add rsp, 32 
                                         
                                        allocSucceeded229: 
                                    ; End check and allocate memory [168, 28].
                                     
                                    push rax 
                                     
                                    ; Start plus (+) [168, 27].
                                         
                                        ; Start check and allocate memory [168, 27].
                                            mov rcx, 2000 
                                            imul rcx, 1 
                                            cmp rcx, 1073741824 
                                            jg allocTooBig232 
                                            mov rdx, 1 
                                             
                                            sub rsp, 32 
                                            call calloc 
                                            add rsp, 32 
                                             
                                            cmp rax, 0 
                                            jne allocSucceeded231 
                                            allocTooBig232: 
                                             
                                            ; Start write runtime string.
                                                lea rcx, $$runtimeStr224 
                                                 
                                                sub rsp, 32 
                                                call puts 
                                                add rsp, 32 
                                                 
                                            ; End write runtime string.
                                             
                                            mov rcx, 13859 
                                             
                                            sub rsp, 32 
                                            call _exit 
                                            add rsp, 32 
                                             
                                            allocSucceeded231: 
                                        ; End check and allocate memory [168, 28].
                                         
                                        push rax 
                                         
                                        ; Start plus (+) [168, 27].
                                             
                                            ; Start check and allocate memory [168, 27].
                                                mov rcx, 2000 
                                                imul rcx, 1 
                                                cmp rcx, 1073741824 
                                                jg allocTooBig234 
                                                mov rdx, 1 
                                                 
                                                sub rsp, 32 
                                                call calloc 
                                                add rsp, 32 
                                                 
                                                cmp rax, 0 
                                                jne allocSucceeded233 
                                                allocTooBig234: 
                                                 
                                                ; Start write runtime string.
                                                    lea rcx, $$runtimeStr224 
                                                     
                                                    sub rsp, 32 
                                                    call puts 
                                                    add rsp, 32 
                                                     
                                                ; End write runtime string.
                                                 
                                                mov rcx, 13859 
                                                 
                                                sub rsp, 32 
                                                call _exit 
                                                add rsp, 32 
                                                 
                                                allocSucceeded233: 
                                            ; End check and allocate memory [168, 28].
                                             
                                            push rax 
                                             
                                            ; Start plus (+) [168, 27].
                                                 
                                                ; Start check and allocate memory [168, 27].
                                                    mov rcx, 2000 
                                                    imul rcx, 1 
                                                    cmp rcx, 1073741824 
                                                    jg allocTooBig236 
                                                    mov rdx, 1 
                                                     
                                                    sub rsp, 32 
                                                    call calloc 
                                                    add rsp, 32 
                                                     
                                                    cmp rax, 0 
                                                    jne allocSucceeded235 
                                                    allocTooBig236: 
                                                     
                                                    ; Start write runtime string.
                                                        lea rcx, $$runtimeStr224 
                                                         
                                                        sub rsp, 32 
                                                        call puts 
                                                        add rsp, 32 
                                                         
                                                    ; End write runtime string.
                                                     
                                                    mov rcx, 13859 
                                                     
                                                    sub rsp, 32 
                                                    call _exit 
                                                    add rsp, 32 
                                                     
                                                    allocSucceeded235: 
                                                ; End check and allocate memory [168, 28].
                                                 
                                                push rax 
                                                 
                                                ; Start plus (+) [168, 27].
                                                     
                                                    ; Start check and allocate memory [168, 27].
                                                        mov rcx, 2000 
                                                        imul rcx, 1 
                                                        cmp rcx, 1073741824 
                                                        jg allocTooBig238 
                                                        mov rdx, 1 
                                                         
                                                        sub rsp, 32 
                                                        call calloc 
                                                        add rsp, 32 
                                                         
                                                        cmp rax, 0 
                                                        jne allocSucceeded237 
                                                        allocTooBig238: 
                                                         
                                                        ; Start write runtime string.
                                                            lea rcx, $$runtimeStr224 
                                                             
                                                            sub rsp, 32 
                                                            call puts 
                                                            add rsp, 32 
                                                             
                                                        ; End write runtime string.
                                                         
                                                        mov rcx, 13859 
                                                         
                                                        sub rsp, 32 
                                                        call _exit 
                                                        add rsp, 32 
                                                         
                                                        allocSucceeded237: 
                                                    ; End check and allocate memory [168, 28].
                                                     
                                                    push rax 
                                                     
                                                    ; Start plus (+) [168, 27].
                                                         
                                                        ; Start check and allocate memory [168, 27].
                                                            mov rcx, 2000 
                                                            imul rcx, 1 
                                                            cmp rcx, 1073741824 
                                                            jg allocTooBig240 
                                                            mov rdx, 1 
                                                             
                                                            sub rsp, 32 
                                                            call calloc 
                                                            add rsp, 32 
                                                             
                                                            cmp rax, 0 
                                                            jne allocSucceeded239 
                                                            allocTooBig240: 
                                                             
                                                            ; Start write runtime string.
                                                                lea rcx, $$runtimeStr224 
                                                                 
                                                                sub rsp, 32 
                                                                call puts 
                                                                add rsp, 32 
                                                                 
                                                            ; End write runtime string.
                                                             
                                                            mov rcx, 13859 
                                                             
                                                            sub rsp, 32 
                                                            call _exit 
                                                            add rsp, 32 
                                                             
                                                            allocSucceeded239: 
                                                        ; End check and allocate memory [168, 28].
                                                         
                                                        push rax 
                                                         
                                                        ; Start plus (+) [168, 27].
                                                             
                                                            ; Start check and allocate memory [168, 27].
                                                                mov rcx, 2000 
                                                                imul rcx, 1 
                                                                cmp rcx, 1073741824 
                                                                jg allocTooBig242 
                                                                mov rdx, 1 
                                                                 
                                                                sub rsp, 32 
                                                                call calloc 
                                                                add rsp, 32 
                                                                 
                                                                cmp rax, 0 
                                                                jne allocSucceeded241 
                                                                allocTooBig242: 
                                                                 
                                                                ; Start write runtime string.
                                                                    lea rcx, $$runtimeStr224 
                                                                     
                                                                    sub rsp, 32 
                                                                    call puts 
                                                                    add rsp, 32 
                                                                     
                                                                ; End write runtime string.
                                                                 
                                                                mov rcx, 13859 
                                                                 
                                                                sub rsp, 32 
                                                                call _exit 
                                                                add rsp, 32 
                                                                 
                                                                allocSucceeded241: 
                                                            ; End check and allocate memory [168, 28].
                                                             
                                                            push rax 
                                                             
                                                            ; Start identifier (t) [168, 27].
                                                                 
                                                                ; Start get identifier.
                                                                    lea rax, [rbp + 16 + 1 * 8] 
                                                                ; End get identifier.
                                                                 
                                                                mov rax, [rax] 
                                                            ; End identifier (t) [168, 28].
                                                             
                                                            mov rcx, rax 
                                                             
                                                            sub rsp, 32 
                                                            call _intToString 
                                                            add rsp, 32 
                                                             
                                                            mov rdx, rax 
                                                            pop rcx 
                                                            push rcx 
                                                             
                                                            sub rsp, 32 
                                                            call strcpy 
                                                            add rsp, 32 
                                                             
                                                            lea rax, $$str17 ; [168, 31] Explicit string.
                                                            mov rdx, rax 
                                                            pop rcx 
                                                             
                                                            sub rsp, 32 
                                                            call strcat 
                                                            add rsp, 32 
                                                             
                                                        ; End plus (+) [168, 28].
                                                         
                                                        mov rdx, rax 
                                                        pop rcx 
                                                        push rcx 
                                                         
                                                        sub rsp, 32 
                                                        call strcpy 
                                                        add rsp, 32 
                                                         
                                                         
                                                        ; Start identifier (u) [168, 38].
                                                             
                                                            ; Start get identifier.
                                                                lea rax, [rbp + 16 + 2 * 8] 
                                                            ; End get identifier.
                                                             
                                                            mov rax, [rax] 
                                                        ; End identifier (u) [168, 39].
                                                         
                                                        mov rcx, rax 
                                                         
                                                        sub rsp, 32 
                                                        call _intToString 
                                                        add rsp, 32 
                                                         
                                                        mov rdx, rax 
                                                        pop rcx 
                                                         
                                                        sub rsp, 32 
                                                        call strcat 
                                                        add rsp, 32 
                                                         
                                                    ; End plus (+) [168, 28].
                                                     
                                                    mov rdx, rax 
                                                    pop rcx 
                                                    push rcx 
                                                     
                                                    sub rsp, 32 
                                                    call strcpy 
                                                    add rsp, 32 
                                                     
                                                    lea rax, $$str17 ; [168, 42] Explicit string.
                                                    mov rdx, rax 
                                                    pop rcx 
                                                     
                                                    sub rsp, 32 
                                                    call strcat 
                                                    add rsp, 32 
                                                     
                                                ; End plus (+) [168, 28].
                                                 
                                                mov rdx, rax 
                                                pop rcx 
                                                push rcx 
                                                 
                                                sub rsp, 32 
                                                call strcpy 
                                                add rsp, 32 
                                                 
                                                 
                                                ; Start identifier (v) [168, 49].
                                                     
                                                    ; Start get identifier.
                                                        lea rax, [rbp + 16 + 3 * 8] 
                                                    ; End get identifier.
                                                     
                                                    mov rax, [rax] 
                                                ; End identifier (v) [168, 50].
                                                 
                                                mov rcx, rax 
                                                 
                                                sub rsp, 32 
                                                call _intToString 
                                                add rsp, 32 
                                                 
                                                mov rdx, rax 
                                                pop rcx 
                                                 
                                                sub rsp, 32 
                                                call strcat 
                                                add rsp, 32 
                                                 
                                            ; End plus (+) [168, 28].
                                             
                                            mov rdx, rax 
                                            pop rcx 
                                            push rcx 
                                             
                                            sub rsp, 32 
                                            call strcpy 
                                            add rsp, 32 
                                             
                                            lea rax, $$str17 ; [168, 53] Explicit string.
                                            mov rdx, rax 
                                            pop rcx 
                                             
                                            sub rsp, 32 
                                            call strcat 
                                            add rsp, 32 
                                             
                                        ; End plus (+) [168, 28].
                                         
                                        mov rdx, rax 
                                        pop rcx 
                                        push rcx 
                                         
                                        sub rsp, 32 
                                        call strcpy 
                                        add rsp, 32 
                                         
                                         
                                        ; Start identifier (x) [168, 60].
                                             
                                            ; Start get identifier.
                                                lea rax, [rbp + 16 + 4 * 8] 
                                            ; End get identifier.
                                             
                                            mov rax, [rax] 
                                        ; End identifier (x) [168, 61].
                                         
                                        mov rcx, rax 
                                         
                                        sub rsp, 32 
                                        call _intToString 
                                        add rsp, 32 
                                         
                                        mov rdx, rax 
                                        pop rcx 
                                         
                                        sub rsp, 32 
                                        call strcat 
                                        add rsp, 32 
                                         
                                    ; End plus (+) [168, 28].
                                     
                                    mov rdx, rax 
                                    pop rcx 
                                    push rcx 
                                     
                                    sub rsp, 32 
                                    call strcpy 
                                    add rsp, 32 
                                     
                                    lea rax, $$str17 ; [168, 64] Explicit string.
                                    mov rdx, rax 
                                    pop rcx 
                                     
                                    sub rsp, 32 
                                    call strcat 
                                    add rsp, 32 
                                     
                                ; End plus (+) [168, 28].
                                 
                                mov rdx, rax 
                                pop rcx 
                                push rcx 
                                 
                                sub rsp, 32 
                                call strcpy 
                                add rsp, 32 
                                 
                                 
                                ; Start identifier (y) [168, 71].
                                     
                                    ; Start get identifier.
                                        lea rax, [rbp + 16 + 5 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (y) [168, 72].
                                 
                                mov rcx, rax 
                                 
                                sub rsp, 32 
                                call _intToString 
                                add rsp, 32 
                                 
                                mov rdx, rax 
                                pop rcx 
                                 
                                sub rsp, 32 
                                call strcat 
                                add rsp, 32 
                                 
                            ; End plus (+) [168, 28].
                             
                            mov rdx, rax 
                            pop rcx 
                            push rcx 
                             
                            sub rsp, 32 
                            call strcpy 
                            add rsp, 32 
                             
                            lea rax, $$str17 ; [168, 75] Explicit string.
                            mov rdx, rax 
                            pop rcx 
                             
                            sub rsp, 32 
                            call strcat 
                            add rsp, 32 
                             
                        ; End plus (+) [168, 28].
                         
                        mov rdx, rax 
                        pop rcx 
                        push rcx 
                         
                        sub rsp, 32 
                        call strcpy 
                        add rsp, 32 
                         
                         
                        ; Start identifier (z) [168, 82].
                             
                            ; Start get identifier.
                                lea rax, [rbp + 16 + 6 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (z) [168, 83].
                         
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _intToString 
                        add rsp, 32 
                         
                        mov rdx, rax 
                        pop rcx 
                         
                        sub rsp, 32 
                        call strcat 
                        add rsp, 32 
                         
                    ; End plus (+) [168, 28].
                     
                    mov rcx, rax ; Move result for println expression.
                     
                    sub rsp, 32 
                    call puts ; CompilerFunction call (string).
                    add rsp, 32 
                     
                ; End compiler function (System.out.println) [168, 26].
                 
            ; End block [167, 5].
             
        ; End statements.
         
        Fac$WriteArgs_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac2$GetThisA: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [176, 26].
                 
                ; Start identifier (a) [176, 35].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+3 * 8] 
                    ; End get identifier.
                     
                    mov rax, [rax] 
                ; End identifier (a) [176, 36].
                 
                jmp Fac2$GetThisA_Return 
            ; End block [176, 27].
             
        ; End statements.
         
        Fac2$GetThisA_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac2$SetThisA: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [177, 31].
                 
                ; Start assignment (a) [177, 33].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+3 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start identifier (i) [177, 37].
                         
                        ; Start get identifier.
                            lea rax, [rbp + 16 + 1 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (i) [177, 38].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (a) [177, 34].
                 
                 
                ; Start identifier (i) [177, 47].
                     
                    ; Start get identifier.
                        lea rax, [rbp + 16 + 1 * 8] 
                    ; End get identifier.
                     
                    mov rax, [rax] 
                ; End identifier (i) [177, 48].
                 
                jmp Fac2$SetThisA_Return 
            ; End block [177, 32].
             
        ; End statements.
         
        Fac2$SetThisA_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Fac2$AddAllAnd2: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 8 
            mov rax, 0 
            mov [rbp-8], rax 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [180, 4].
                 
                ; Start assignment (v) [182, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    mov rax, 2 ; [182, 12] Explicit integer.
                    pop r10 
                    mov [r10], rax 
                ; End assignment (v) [182, 9].
                 
                 
                ; Start plus (+) [183, 15].
                     
                    ; Start identifier (v) [183, 31].
                         
                        ; Start get identifier.
                            lea rax, [rbp - 1 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (v) [183, 32].
                     
                    push rax 
                     
                    ; Start plus (+) [183, 15].
                         
                        ; Start identifier (y) [183, 27].
                             
                            ; Start get identifier.
                                lea rax, [rbp + 16 + 2 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (y) [183, 28].
                         
                        push rax 
                         
                        ; Start plus (+) [183, 15].
                             
                            ; Start identifier (x) [183, 23].
                                 
                                ; Start get identifier.
                                    lea rax, [rbp + 16 + 1 * 8] 
                                ; End get identifier.
                                 
                                mov rax, [rax] 
                            ; End identifier (x) [183, 24].
                             
                            push rax 
                             
                            ; Start plus (+) [183, 15].
                                 
                                ; Start identifier (b) [183, 19].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+2 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (b) [183, 20].
                                 
                                push rax 
                                 
                                ; Start identifier (a) [183, 15].
                                     
                                    ; Start get identifier.
                                        mov r10, [rbp + 16] 
                                        lea rax, [r10+3 * 8] 
                                    ; End get identifier.
                                     
                                    mov rax, [rax] 
                                ; End identifier (a) [183, 16].
                                 
                                pop r10 
                                add rax, r10 
                            ; End plus (+) [183, 16].
                             
                            pop r10 
                            add rax, r10 
                        ; End plus (+) [183, 16].
                         
                        pop r10 
                        add rax, r10 
                    ; End plus (+) [183, 16].
                     
                    pop r10 
                    add rax, r10 
                ; End plus (+) [183, 16].
                 
                jmp Fac2$AddAllAnd2_Return 
            ; End block [180, 5].
             
        ; End statements.
         
        Fac2$AddAllAnd2_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    SmartPointer$AddRef: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [192, 4].
                 
                ; Start incrementer (_refCount++) [193, 15].
                    push rbx 
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                    mov rax, [rax] 
                    push rax 
                    add rax, 1 
                    pop r11 
                    pop r10 
                    mov [r10], rax 
                    pop rbx 
                ; End incrementer (_refCount++) [193, 17].
                 
                jmp SmartPointer$AddRef_Return 
            ; End block [192, 5].
             
        ; End statements.
         
        SmartPointer$AddRef_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    SmartPointer$Release: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 8 
            mov rax, 0 
            mov [rbp-8], rax 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [197, 4].
                 
                ; Start assignment (count) [198, 8].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start incrementer (_refCount--) [198, 21].
                        push rbx 
                         
                        ; Start get identifier.
                            mov r10, [rbp + 16] 
                            lea rax, [r10+1 * 8] 
                        ; End get identifier.
                         
                        push rax 
                        mov rax, [rax] 
                        push rax 
                        sub rax, 1 
                        pop r11 
                        pop r10 
                        mov [r10], rax 
                        pop rbx 
                    ; End incrementer (_refCount--) [198, 23].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (count) [198, 11].
                 
                 
                ; Start if [200, 8].
                     
                    ; Start less equal (<=) [200, 11].
                        mov rax, 0 ; [200, 20] Explicit integer.
                        push rax 
                         
                        ; Start identifier (count) [200, 11].
                             
                            ; Start get identifier.
                                lea rax, [rbp - 1 * 8] 
                            ; End get identifier.
                             
                            mov rax, [rax] 
                        ; End identifier (count) [200, 16].
                         
                        pop r10 
                        cmp rax, r10 
                        jnle lessEqualFalse253 
                        mov rax, 1 
                        jmp lessEqualEnd254 
                        lessEqualFalse253: 
                        mov rax, 0 
                        lessEqualEnd254: 
                    ; End less equal (<=) [200, 16].
                     
                    cmp rax, 1 
                    jne ifFalse255 
                     
                    ; Start block [201, 8].
                         
                        ; Start method call (Destroy) [202, 12].
                             
                            ; Start get pointer and check [202, 12].
                                mov rax, [rbp + 16] ; [202, 12] Explicit this.
                                push rax 
                                cmp rax, 0 
                                jne whewNotNull259 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr261 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 6 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotNull259: 
                                mov rcx, rax 
                                 
                                sub rsp, 32 
                                call _CrtIsValidHeapPointer 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne whewNotFreed260 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr262 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 9 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                whewNotFreed260: 
                                pop rax 
                            ; End get pointer and check [202, 16].
                             
                            push rax 
                            mov rax, [rsp + 0 * 8] 
                            mov rcx, rax 
                            mov r10, [rax] 
                            mov r10, [r10 + 3 * 8] 
                             
                            sub rsp, 32 
                            call r10 
                            add rsp, 32 
                             
                            add rsp, 8 ; removing pushed arguemnts.
                        ; End method call (Destroy) [202, 16].
                         
                    ; End block [201, 9].
                     
                    jmp ifEnd256 
                    ifFalse255: 
                     
                    ; Start block [205, 8].
                    ; End block [205, 9].
                     
                    ifEnd256: 
                ; End if [200, 10].
                 
                 
                ; Start identifier (count) [207, 15].
                     
                    ; Start get identifier.
                        lea rax, [rbp - 1 * 8] 
                    ; End get identifier.
                     
                    mov rax, [rax] 
                ; End identifier (count) [207, 20].
                 
                jmp SmartPointer$Release_Return 
            ; End block [197, 5].
             
        ; End statements.
         
        SmartPointer$Release_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    SmartPointer$Destroy: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [211, 4].
                 
                ; Start compiler function (System.compiler.destroy) [212, 8].
                    mov rax, [rbp + 16] ; [212, 32] Explicit this.
                    mov rcx, rax 
                     
                    sub rsp, 32 
                    call free 
                    add rsp, 32 
                     
                ; End compiler function (System.compiler.destroy) [212, 31].
                 
            ; End block [211, 5].
             
        ; End statements.
         
        SmartPointer$Destroy_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Awesome$AwesomeConstructor: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [223, 4].
                 
                ; Start assignment (a) [224, 8].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+3 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start identifier (x) [224, 12].
                         
                        ; Start get identifier.
                            lea rax, [rbp + 16 + 1 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (x) [224, 13].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (a) [224, 9].
                 
                 
                ; Start assignment (b) [225, 8].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+4 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start identifier (y) [225, 12].
                         
                        ; Start get identifier.
                            lea rax, [rbp + 16 + 2 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (y) [225, 13].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (b) [225, 9].
                 
                 
                ; Start assignment (array) [226, 8].
                     
                    ; Start get identifier.
                        mov r10, [rbp + 16] 
                        lea rax, [r10+2 * 8] 
                    ; End get identifier.
                     
                    push rax 
                     
                    ; Start new int[] [226, 16].
                        mov rax, 134217727 ; [226, 24] Explicit integer.
                        push rax 
                        add rax, 1 
                         
                        ; Start check and allocate memory [226, 16].
                            mov rcx, rax 
                            imul rcx, 8 
                            cmp rcx, 1073741824 
                            jg allocTooBig270 
                            mov rdx, 1 
                             
                            sub rsp, 32 
                            call calloc 
                            add rsp, 32 
                             
                            cmp rax, 0 
                            jne allocSucceeded269 
                            allocTooBig270: 
                             
                            ; Start write runtime string.
                                lea rcx, $$runtimeStr271 
                                 
                                sub rsp, 32 
                                call puts 
                                add rsp, 32 
                                 
                            ; End write runtime string.
                             
                            mov rcx, 13859 
                             
                            sub rsp, 32 
                            call _exit 
                            add rsp, 32 
                             
                            allocSucceeded269: 
                        ; End check and allocate memory [226, 19].
                         
                        pop r10 
                        mov [rax], r10 
                    ; End new int[] [226, 19].
                     
                    pop r10 
                    mov [r10], rax 
                ; End assignment (array) [226, 13].
                 
                mov rax, [rbp + 16] ; [228, 15] Explicit this.
                jmp Awesome$AwesomeConstructor_Return 
            ; End block [223, 5].
             
        ; End statements.
         
        Awesome$AwesomeConstructor_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    Awesome$Destroy: ; [1, 6]
     
         
        ; Start prologue.
            push rbp 
            mov rbp, rsp 
            sub rsp, 0 
            mov rax, 0 
            mov [rbp + 16], rcx 
            mov [rbp + 24], rdx 
            mov [rbp + 32], r8 
            mov [rbp + 40], r9 
        ; End prologue.
         
         
        ; Start statements.
             
            ; Start block [232, 4].
                 
                ; Start compiler function (System.compiler.destroy) [233, 8].
                     
                    ; Start identifier (array) [233, 32].
                         
                        ; Start get identifier.
                            mov r10, [rbp + 16] 
                            lea rax, [r10+2 * 8] 
                        ; End get identifier.
                         
                        mov rax, [rax] 
                    ; End identifier (array) [233, 37].
                     
                    mov rcx, rax 
                     
                    sub rsp, 32 
                    call free 
                    add rsp, 32 
                     
                ; End compiler function (System.compiler.destroy) [233, 31].
                 
                 
                ; Start compiler function (System.compiler.destroy) [234, 8].
                    mov rax, [rbp + 16] ; [234, 32] Explicit this.
                    mov rcx, rax 
                     
                    sub rsp, 32 
                    call free 
                    add rsp, 32 
                     
                ; End compiler function (System.compiler.destroy) [234, 31].
                 
            ; End block [232, 5].
             
        ; End statements.
         
        Awesome$Destroy_Return: 
         
        ; Start epilogue.
            mov rsp, rbp 
            pop rbp 
        ; End epilogue.
         
        ret 
    mainCRTStartup proc ; [1, 6] Main method.
     
         
        ; Start statements.
             
            ; Start block [3, 4].
                 
                ; Start method call (Go) [4, 9].
                     
                    ; Start get pointer and check [4, 9].
                         
                        ; Start new Start2 [4, 9].
                             
                            ; Start check and allocate memory [4, 9].
                                mov rcx, 1 
                                imul rcx, 8 
                                cmp rcx, 1073741824 
                                jg allocTooBig277 
                                mov rdx, 1 
                                 
                                sub rsp, 32 
                                call calloc 
                                add rsp, 32 
                                 
                                cmp rax, 0 
                                jne allocSucceeded276 
                                allocTooBig277: 
                                 
                                ; Start write runtime string.
                                    lea rcx, $$runtimeStr278 
                                     
                                    sub rsp, 32 
                                    call puts 
                                    add rsp, 32 
                                     
                                ; End write runtime string.
                                 
                                mov rcx, 13859 
                                 
                                sub rsp, 32 
                                call _exit 
                                add rsp, 32 
                                 
                                allocSucceeded276: 
                            ; End check and allocate memory [4, 15].
                             
                            lea r10, $$Start2 
                            mov [rax], r10 
                        ; End new Start2 [4, 15].
                         
                        push rax 
                        cmp rax, 0 
                        jne whewNotNull279 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr281 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 6 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        whewNotNull279: 
                        mov rcx, rax 
                         
                        sub rsp, 32 
                        call _CrtIsValidHeapPointer 
                        add rsp, 32 
                         
                        cmp rax, 0 
                        jne whewNotFreed280 
                         
                        ; Start write runtime string.
                            lea rcx, $$runtimeStr282 
                             
                            sub rsp, 32 
                            call puts 
                            add rsp, 32 
                             
                        ; End write runtime string.
                         
                        mov rcx, 9 
                         
                        sub rsp, 32 
                        call _exit 
                        add rsp, 32 
                         
                        whewNotFreed280: 
                        pop rax 
                    ; End get pointer and check [4, 15].
                     
                    push rax 
                    mov rax, [rsp + 0 * 8] 
                    mov rcx, rax 
                    mov r10, [rax] 
                    mov r10, [r10 + 1 * 8] 
                     
                    sub rsp, 32 
                    call r10 
                    add rsp, 32 
                     
                    add rsp, 8 ; removing pushed arguemnts.
                ; End method call (Go) [4, 15].
                 
            ; End block [3, 5].
             
        ; End statements.
         
         
        ; Main Epilogue.
        mov rcx, 0 
         
        sub rsp, 32 
        call _exit 
        add rsp, 32 
         
        ret 
    mainCRTStartup endp 
.data 
    $$Start3 qword 0, Start3$Go, 0 
    $$Start2 qword 0, Start2$Go, 0 
    $$Start qword 0, Start$Go, Start$GetString, 0 
    $$Fac qword 0, Fac$GetA, Fac$SetA, Fac$GetB, Fac$SetB, Fac$AddAllAnd1, Fac$WriteArgs, 0 
    $$Fac2 qword $$Fac, Fac$GetA, Fac$SetA, Fac$GetB, Fac$SetB, Fac$AddAllAnd1, Fac$WriteArgs, Fac2$GetThisA, Fac2$SetThisA, Fac2$AddAllAnd2, 0 
    $$SmartPointer qword 0, SmartPointer$AddRef, SmartPointer$Release, SmartPointer$Destroy, 0 
    $$Awesome qword $$SmartPointer, SmartPointer$AddRef, SmartPointer$Release, Awesome$Destroy, Awesome$AwesomeConstructor, 0 
    $$true byte 'true', 0 
    $$false byte 'false', 0 
    $$str0 byte 'Enter a number: ', 0 
    $$str1 byte ' squared is ', 0 
    $$str2 byte 'Waiting...', 0 
    $$str3 byte 'Prefix: ', 0 
    $$str4 byte 'Postfix: ', 0 
    $$str5 byte 'Cool!', 0 
    $$str6 byte 'Bro!', 0 
    $$str7 byte 'Awesome: ', 0 
    $$str8 byte '.', 0 
    $$str9 byte 'YAY', 0 
    $$str10 byte 'Fail!', 0 
    $$str11 byte '15: ', 0 
    $$str12 byte '10: ', 0 
    $$str13 byte '2: ', 0 
    $$str14 byte '16: ', 0 
    $$str15 byte '1: ', 0 
    $$str16 byte 0 
    $$str17 byte ', ', 0 
    $$str18 byte 'Win! ', 0 
    $$str19 byte 'Big!', 0 
    $$str20 byte 'Small!', 0 
    $$runtimeStr5 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [13, 39].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr8 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [14, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr13 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [15, 8].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr18 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [25, 8].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr21 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [26, 25].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr24 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [26, 20].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr25 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [26, 20].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr28 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [27, 8].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr29 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [27, 8].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr32 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [28, 8].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr35 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [29, 8].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr36 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [29, 8].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr39 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [30, 8].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr46 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [46, 16].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr49 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [47, 16].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr50 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [47, 16].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr53 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [48, 16].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr54 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [48, 16].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr57 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [49, 27].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr58 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [49, 27].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr61 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [50, 8].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr62 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [50, 8].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr65 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [53, 17].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr68 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [54, 16].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr69 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [54, 16].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr72 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [55, 16].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr73 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [55, 16].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr76 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [56, 27].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr77 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [56, 27].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr80 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [57, 27].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr81 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [57, 27].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr84 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [62, 16].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr87 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [65, 18].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr88 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [65, 18].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr98 byte 10, '!!!!!ERROR!!!!!', 10, '    Array null reference at [67, 12].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr99 byte 10, '!!!!!ERROR!!!!!', 10, '    Array index is out of bounds (> length) at [67, 18].  Killing application and reporting exit code (1734)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr100 byte 10, '!!!!!ERROR!!!!!', 10, '    Array index is out of bounds (< 0) at [67, 18].  Killing application and reporting exit code (1734)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr107 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [72, 18].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr108 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [72, 18].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr118 byte 10, '!!!!!ERROR!!!!!', 10, '    Array null reference at [74, 31].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr119 byte 10, '!!!!!ERROR!!!!!', 10, '    Array index is out of bounds (> length) at [74, 37].  Killing application and reporting exit code (1734)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr120 byte 10, '!!!!!ERROR!!!!!', 10, '    Array index is out of bounds (< 0) at [74, 37].  Killing application and reporting exit code (1734)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr127 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [79, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr130 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [81, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr137 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [86, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr150 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [100, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr153 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [101, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr156 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [102, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr159 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [103, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr162 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [104, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr169 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [109, 16].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr180 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [116, 16].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr197 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [125, 31].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr202 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [135, 27].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr203 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [135, 27].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr224 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [168, 27].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr261 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [202, 12].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr262 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [202, 12].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr271 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [226, 16].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr278 byte 10, '!!!!!ERROR!!!!!', 10, '    Failed to allocate memory (more than 1 GB) at [4, 9].  Killing application and reporting exit code (13859)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr281 byte 10, '!!!!!ERROR!!!!!', 10, '    Null reference at [4, 9].  Killing application and reporting exit code (6)...', 10, '!!!!!ERROR!!!!!', 10, 0 
    $$runtimeStr282 byte 10, '!!!!!ERROR!!!!!', 10, '    Memory previously freed at [4, 9].  Killing application and reporting exit code (9)...', 10, '!!!!!ERROR!!!!!', 10, 0 
end
