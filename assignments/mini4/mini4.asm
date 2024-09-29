.data
	bufferf: .space 51
	bufferl: .space 51
	limit: .word 50
	newline: .asciiz "\n"
	msgf: .asciiz "First name: "
	msgl: .asciiz "Last name: "
	msgr: .asciiz "You entered: "
	fp: .asciiz "."
	co: .asciiz ", "
	
.text
mian:
	# ask for first name
	la $s0, msgf
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# user give the first name
	la $s0, bufferf
	lw $s1, limit
	
	addi $sp, $sp, -8
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	jal get
	addi $sp, $sp, 8
	
	# creat new line
	la $s0, newline
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# ask for last name
	la $s0, msgl
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# user give the first name
	la $s0, bufferl
	lw $s1, limit
	
	addi $sp, $sp, -8
	sw $s0, 4($sp)
	sw $s1, 0($sp)
	jal get
	addi $sp, $sp, 8
	
	# creat new line
	la $s0, newline
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# print result part 1
	la $s0, msgr
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# print result part 2 (last name)
	la $s0, bufferl
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# print comma
	la $s0, co
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# print result part 3 (first name)
	la $s0, bufferf
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# print full point
	la $s0, fp
	
	addi $sp, $sp, -4
	sw $s0, 0($sp)
	jal put
	addi $sp, $sp, 4
	
	# end the program
	li $v0, 10
	syscall	

#---------------------------------------------------------------------#	

getchar:
	lui $a3, 0xffff
	CkReady:
	lw $t1, 0($a3)
	andi $t1, $t1, 0x1
	beqz $t1, CkReady
	lw $v0, 4($a3)
	jr $ra
	
putchar:
	lui $a3, 0xffff
	XReady:
	lw $t1, 8($a3)
	andi $t1, $t1, 0x1
	beqz $t1, XReady
	sw $a0, 12($a3)
	jr $ra

#---------------------------------------------------------------------#	
		
get:
	lw $t0, 4($sp)
	lw $t1, 0($sp)
	
	addi $sp, $sp, -12
	sw $ra, 8($sp)
	sw $t0, 4($sp)
	sw $t1, 0($sp)
	li $t2, 0
	addi $sp, $sp, -4
	sw $t2, 0($sp)
	getloop:
		lw $t0, 8($sp)
		lw $t1, 4($sp)
		lw $t2, 0($sp)
		beq $t2, $t1, getloopend
		jal getchar
		beq $v0, 10, getloopend
		add $t4, $t2, $t0
		addi $sp, $sp, -4
		sw $t4, 0($sp)
		sb $v0, 0($t4)
		addi $sp, $sp, 4
		addi $t2, $t2, 1
		sw $t2, 0($sp)
		j getloop						
	getloopend:
		lw $t0, 8($sp)
		lw $t2, 0($sp)
		move $v0, $t2
		add $t4, $t2, $t0
		addi $sp, $sp, -4
		sw $t4, 0($sp)
		sb $0, 0($t4)
		addi $sp, $sp, 4
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra

#---------------------------------------------------------------------#	
			
put:
	lw $t0, 0($sp)
	
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $t0, 0($sp)
	li $t1, 0
	addi $sp, $sp, -4
	sw $t1, 0($sp)
	putloop:
		lw $t0, 4($sp)
		lw $t1, 0($sp)
		add $t2, $t0, $t1
		addi $sp, $sp, -4
		sw $t2, 0($sp)
		lb $t3, 0($t2)
		addi $sp, $sp, -4
		sb $t3, 0($sp)
		beq $t3, $0, putloopend
		move $a0, $t3
		jal putchar
		addi $sp, $sp, 8
		lw $t1, 0($sp)
		addi $t1, $t1, 1
		sw $t1, 0($sp)
		j putloop
	putloopend:
		addi $sp, $sp, 8
		lw $t1, 0($sp)
		move $v0, $t1
	lw $ra, 8($sp)
	addi $sp, $sp, 12
	jr $ra
	
		
	
	
	
	