.data
	InputAsk: .asciiz "Please input an integer value greater than or equal to 0:"
	ErrorMsg: .asciiz "The value you entered is less than zero. This program only works with values greater than or equal to zero."
	NewLine: .asciiz "\n"
	Msg1: .asciiz "You input:"
	Msg2: .asciiz "The factorial is:"
	AgainAsk: .asciiz " input 'Y' to do it again, all other characters will terminate the program:"
.text

main:

# prompt the user to input an integer number greater than or equal to zero 
	la $a0, InputAsk
	li $v0, 4
	syscall

	li $v0, 5
	syscall

# If the user inputs a value less than zero, then terminate the program with error message
	blt $v0, $0, end2
	move $s1, $v0
	
# Call the function
	addi $sp, $sp, -4
	sw $s1, 0($sp)

	jal factorial

	addi $sp, $sp, 4
	move $s2, $v0 
# Print the result message
	la $a0, Msg1
	li $v0, 4
	syscall

	move $a0, $s1
	li $v0, 1
	syscall

	la $a0, NewLine
	li $v0, 4
	syscall

	la $a0, Msg2
	li $v0, 4
	syscall

	move $a0, $s2
	li $v0, 1
	syscall

	la $a0, NewLine
	li $v0, 4
	syscall

# prompt the user to see if they would like to do this again

	la $a0, AgainAsk
	li $v0, 4
	syscall

	li $v0, 12
	syscall

	beq $v0, 89, jMain

# End with success
end1:
	li $v0, 10
	syscall

# End with error
end2:
	la $a0, ErrorMsg
	li $v0, 4
	syscall
	
	li $v0, 10
	syscall

# Function of factorial	
factorial:
	lw $t0, 0($sp)
	
	addi $sp, $sp, -8
	sw $ra, 4($sp)
	sw $t0, 0($sp)
	
	beq $t0, $0, basecase
	
	addi $sp, $sp, -4
	addi $t0, $t0, -1
	sw $t0, 0($sp)

	jal factorial

	lw $ra, 8($sp)
	lw $t0, 4($sp)
	addi $sp, $sp, 12
	mult $v0, $t0
	mflo $v0
	jr $ra

basecase:
	li $v0, 1
	lw $ra, 4($sp)
	lw $t0, 0($sp)
	addi $sp, $sp, 8
	jr $ra


# If yes, jump back to main function with a new line
jMain:
	la $a0, NewLine
	li $v0, 4
	syscall
	j main
	
	
