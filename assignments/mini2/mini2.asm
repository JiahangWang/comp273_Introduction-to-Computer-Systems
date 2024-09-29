.data
	askS: .asciiz "Input a string 30 characters or less: "
	askN: .asciiz "Input an integer greater than 0: "
	newL: .asciiz "\n"
	emsg: .asciiz "program exit with error"
	endmsg1: .asciiz "Shifted string = [ "
	endmsg2: .asciiz " ]"	
	
	stringInput: .space 32
	
	.align 2
	.globl main
	
.text	
main:	
	# print the message ask for a string
	la $a0, askS         
	li $v0, 4    
	syscall 
	
	# read the string from user
	la $a0, stringInput   
	li $a1, 32	
	li $v0, 8
	syscall
	
	# if no character, exit!
	lb $t1, 0($a0)         
	li $t2, 10	
	beq $t1, $t2 Exit0
	
	# save the address of string -> $s1
	move $s1, $a0        

#------------------------------------------------------------------------------#
			
	# print the message ask for an integer
	la $a0, askN        
	li $v0, 4     
	syscall
	
	# read the integer from user
	li $v0, 5           
	syscall
	
	# if interger less than or equal to 0, exit!
	ble $v0, $0, Exit0  
	
	# save the address of integer -> $s2
	move $s2, $v0 
	      
#------------------------------------------------------------------------------#	
	# find the length of the input string -> $s3
	li $s3, 0
	move $t0, $s1 
	li $t5, 10
keepfind:
	lb $t1, 0($t0)
	beq $t1, $t0, findout
	beq $t1, $t5, findout
	addi $s3, $s3, 1
	addi $t0, $t0, 1
	j keepfind
findout:	
	#li $v0, 1
	#move $a0, $s3
	#syscall
	
#------------------------------------------------------------------------------#	
	
	# the loop for shifting the string
keepshift:
	beq $s2, $0, shiftdone
	subi $s2, $s2, 1
	
	# the loop for shift the string 1 time
	move $t1, $s1
	lb $t2, 0($t1)
	li $t4, 0
	
	roll:
		addi $t1, $t1, 1
		addi $t4, $t4, 1
		beq $t4, $s3, rolldone
		lb $t3, 0($t1)
		sb $t3, -1($t1)
		j roll
	rolldone:
		
	subi $t1, $t1, 1
	sb $t2, 0($t1)
	j keepshift
shiftdone:
	sb $0, 1($t1)

#------------------------------------------------------------------------------#	
	# print the result
	la $a0, endmsg1
	li $v0, 4
	syscall
	move $a0, $s1
	syscall
	la $a0, endmsg2
	syscall

#------------------------------------------------------------------------------#
Exit1:	li $v0, 10
	syscall	
	
Exit0:	la $a0, emsg
	li $v0, 4
	syscall
	

