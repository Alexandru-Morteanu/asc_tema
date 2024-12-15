.data
	n_operatii: .space 4
	n_fisiere: .space 4
	operatia: .space 4
	dimensiune: .space 4
        descriptor: .space 4
	n_delete: .space 4
	n_get: .space 4
	v: .space 0x400000
	divisor: .long 8
	index: .long 0
	de_la: .long 0
	counter: .long 0
	lungime_n: .long 0
	old_index: .long 0
	omiedouspatru: .long 1024

	in: .asciz "%d"
        double_in: .asciz "%d %d"
	out: .asciz "Introdus: %d\n"
	print_vect: .asciz "%d: ((%d, %d), (%d, %d))\n"
	print_vect_get: .asciz "((%d, %d), (%d, %d))\n"
	add: .asciz "Add\n"
	get: .asciz "Get\n"
	delete: .asciz "Delete\n"
	defragmentation: .asciz "Defragmentation\n"
.text
.global main
main:
        push $n_operatii
	push $in
        call scanf
        addl $8, %esp

	xor %ecx, %ecx
	xor %eax, %eax

while_n_operatii:
	cmp n_operatii, %ecx
	je exit

	push %ecx

	push $operatia
        push $in
        call scanf
	add $8, %esp

	pop %ecx

	mov operatia, %eax
        sub $1, %eax
	shl $2, %eax
        mov switch(, %eax), %eax
        call *%eax

	inc %ecx
	jmp while_n_operatii

exit:

	mov $1, %eax
	mov $0, %ebx	
	int $0x80

switch:
        .long case_add
        .long case_get
	.long case_delete
	.long case_defragmentation




























case_add:
	push %eax
        push %ebx
        push %ecx
        push %edx

	push $n_fisiere
        push $in
        call scanf
        addl $8, %esp

	xor %ecx, %ecx
        xor %eax, %eax

while_n_fisiere:
        cmp n_fisiere, %ecx
        je exit_add

	push %ecx

	push $dimensiune
        push $descriptor
        push $double_in
        call scanf
        addl $12, %esp

	movl dimensiune, %eax
	xorl %edx, %edx
        divl divisor

	cmp $0, %edx
	je no_rest
	inc %eax
no_rest:
	cmp omiedouspatru, %eax
	jg skip_add
	call normal_add
skip_add:
	pop %ecx
        inc %ecx
        jmp while_n_fisiere
exit_add:
	mov index, %ecx
	mov %ecx, old_index
	call print_output

	pop %edx
        pop %ecx
        pop %ebx
        pop %eax

        ret





































normal_add:
	push %eax
        push %ebx
	push %ecx
        push %edx

        lea v, %edi
        xor %ecx, %ecx
        movl index, %ebx
loop_find_where_to_add:
        cmp index, %ecx
        je before_loop_push

        push %eax
        push %ebx

        mov %ecx, %eax
        xor %edx, %edx
        divl omiedouspatru

        cmp $0, %edx
        jne reset_new_line
        mov %ecx, %ebx
        movl $0, counter

reset_new_line:
        pop %ebx
        pop %eax


        push %eax
        push %ecx

        movl (%edi, %ecx, 4), %ecx

        cmp $0, %ecx
        je increment_counter

        movl $0, counter
        jmp done_reset_counter
increment_counter:
        mov counter, %ecx
        inc %ecx
        mov %ecx, counter
done_reset_counter:

        pop %ecx
        pop %eax

        cmp counter, %eax
        jne not_egale
        mov %ecx, %ebx
        subl counter, %ebx
        inc %ebx
        jmp before_loop_push
not_egale:

        inc %ecx
        jmp loop_find_where_to_add

before_loop_push:
        push %eax
        push %ebx

        addl index, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %eax, %ecx

        cmp $0, %edx
        jne no_dec_ecx
        dec %ecx

no_dec_ecx:
        mov index, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %eax, %edx


        pop %ebx
        pop %eax

        cmp %ecx, %edx
        je skip_new_line
        imull omiedouspatru, %ecx
        mov %ecx, %ebx

skip_new_line:

        xor %ecx, %ecx
loop_push:
        cmp %eax, %ecx
        je done_push

        push %ecx

        movl descriptor, %ecx
        movl %ecx, (%edi, %ebx, 4)

        pop %ecx

        inc %ebx

        cmp counter, %eax
        jle not_make_index_great_again
        mov %ebx, index

not_make_index_great_again:

        inc %ecx
        jmp loop_push

done_push:
 


	pop %edx
        pop %ecx
	pop %ebx
        pop %eax
	ret



















case_get:
        push %eax
        push %ebx
        push %ecx
        push %edx

	push $n_get
        push $in
        call scanf
        addl $8, %esp

	lea v, %edi
        xor %ecx, %ecx
        movl (%edi, %ecx, 4), %ebx
loop_print_get:
        cmp index, %ecx
        je done_print_get
        movl (%edi, %ecx, 4), %edx

        cmp %edx, %ebx
        je no_print_get

        push %eax
        push %ecx
        push %edx

        dec %ecx

        cmp n_get, %ebx
        jne skip_zero_get


        mov de_la, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %edx, de_la

        mov %ecx, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %edx, %ecx

        push %ecx
        push %eax
        push de_la
        push %eax
        push $print_vect_get
        call printf
        add $20, %esp


skip_zero_get:
        pop %edx
        pop %ecx
        pop %eax

        mov %edx, %ebx
        mov %ecx, de_la

no_print_get:

        inc %ecx
        jmp loop_print_get


done_print_get:
	cmp n_get, %ebx
	jne continue_get

        dec %ecx

        mov de_la, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %edx, de_la

        mov %ecx, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %edx, %ecx

        push %ecx
        push %eax
        push de_la
        push %eax
        push $print_vect_get
        call printf
        add $20, %esp

continue_get:
        xor %ecx, %ecx
        mov %ecx, de_la


        pop %edx
        pop %ecx
        pop %ebx
        pop %eax
	ret












case_delete:
        push %eax
        push %ebx
        push %ecx
        push %edx

	push $n_delete
        push $in
        call scanf
        addl $8, %esp

	call normal_delete

	call print_output

	pop %edx
        pop %ecx
        pop %ebx
        pop %eax
	ret





normal_delete:
	push %eax
        push %ecx
        push %edx

	lea v, %edi
        xor %ecx, %ecx
	mov %ecx, lungime_n
loop_delete:
        cmp old_index, %ecx
        je done_delete
        movl (%edi, %ecx, 4), %edx

        cmp n_delete, %edx
        jne no_delete
        mov $0, %ebx
	incl lungime_n
        movl %ebx ,(%edi, %ecx, 4)

no_delete:
        inc %ecx
        jmp loop_delete

done_delete:

	pop %edx
        pop %ecx
        pop %eax
	ret













case_defragmentation:
        push %eax
        push %ebx
        push %ecx
        push %edx


	lea v, %edi
	mov index, %ecx
	mov %ecx, old_index

	xor %ecx, %ecx
	mov %ecx, index

	
loop_defragmentation_line:
        cmp old_index, %ecx
        je done_defragmentation_line
	movl (%edi, %ecx, 4), %edx

        cmp $0, %edx
        je skip_defragmentation_line

	mov %edx, n_delete
	call normal_delete	

	mov lungime_n, %eax
	mov %edx, descriptor
	call normal_add

	addl lungime_n, %ecx
	decl %ecx

	#delete (%edx)
	#return lungime

	#add (%edx, lungime)

	#ecx += lungime - 1

skip_defragmentation_line:


        inc %ecx
        jmp loop_defragmentation_line

done_defragmentation_line:

        call print_output

        pop %edx
        pop %ecx
        pop %ebx
        pop %eax
        ret

















defragmentation_line:
        push %eax
        push %ebx
        push %edx


	movl 16(%esp), %eax

        imull omiedouspatru, %eax


	push %eax
        push %ecx

        push %eax
        push $out
        call printf
        addl $8, %esp


        pop %ecx
        pop %eax







	movl index, %esi
	subl %eax, %esi

	movl index, %ecx

	cmp omiedouspatru, %esi
	jng continue_not_cut_index
	movl omiedouspatru, %esi
	mov %eax, %ecx
	addl omiedouspatru, %ecx
continue_not_cut_index:

        lea v, %edi
        movl %eax, %ebx


loop_defragmentation:
        cmp %ecx, %eax
        je done_defragmentation
        movl (%edi, %eax, 4), %edx

        cmp $0, %edx
        je skip_defragmentation

        movl %edx, (%edi, %ebx, 4)
        inc %ebx

skip_defragmentation:
        inc %eax
        jmp loop_defragmentation

done_defragmentation:

loop_umplem_cu_zero:
        cmp %ecx, %ebx
        je done_umplem_cu_zero
        movl $0, (%edi, %ebx, 4)

        inc %ebx
        jmp loop_umplem_cu_zero

done_umplem_cu_zero:

        # mov %ebx, index

        pop %edx
        pop %ebx
        pop %eax
        ret


print_output:
        push %eax
        push %ebx
        push %ecx
        push %edx

        lea v, %edi
        xor %ecx, %ecx
        movl (%edi, %ecx, 4), %ebx
loop_print:
        cmp index, %ecx
        je done_print
        movl (%edi, %ecx, 4), %edx

        cmp %edx, %ebx
        je no_print

        push %eax
        push %ecx
        push %edx

        dec %ecx

        cmp $0, %ebx
        je skip_zero

	mov de_la, %eax
	xor %edx, %edx
	divl omiedouspatru
	mov %edx, de_la

        mov %ecx, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %edx, %ecx

	push %ecx
	push %eax
        push de_la
        push %eax
        push %ebx
        push $print_vect
        call printf
        add $24, %esp


skip_zero:
        pop %edx
        pop %ecx
        pop %eax

        mov %edx, %ebx
        mov %ecx, de_la

no_print:

        inc %ecx
        jmp loop_print


done_print:
        cmp $0, %edx
        je continue_print

        dec %ecx

	mov de_la, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %edx, de_la

        mov %ecx, %eax
        xor %edx, %edx
        divl omiedouspatru
        mov %edx, %ecx

        push %ecx
        push %eax
        push de_la
        push %eax
        push %ebx
        push $print_vect
        call printf
        add $24, %esp

continue_print:
        xor %ecx, %ecx
        mov %ecx, de_la

        pop %edx
        pop %ecx
        pop %ebx
        pop %eax
        ret









