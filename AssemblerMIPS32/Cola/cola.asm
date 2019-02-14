# Sugerencia de utilización de los registros
# $s0 – Nodo raíz de la cola
# $s1 – Ultimo nodo de la cola

	move $s0,$zero
	move $s1,$zero

read: 
	li $v0,5
	syscall
	beq $v0,0,continue
	move $a0,$s1
	move $a1,$v0
	jal insert
	move $s1,$v0
	b read

continue:
	move $a0,$s0
	li $a1,2
	jal remove
	
	move $a0,$s0
	jal print
	
	b exit_program
	
insert:
	#-- Crear la pila
	addi $sp, $sp, -32
 	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	
	sw $a0,0($fp)
	## Memory allocation
	addi $a0,$zero,8
	li $v0,9
	syscall
	## Memory dir of allocated memory
	beq $v0,0,exit_program
	#Sets structure
	lw $a0,0($fp)
	sw $a1,0($v0)	
	sw $zero,4($v0) 
	bne $s1,0,follow
		move $s0,$v0 #sets first node as $v0
		move $s1,$v0 #sets last node as $v0
		
		#-- Devolver pila
		lw $ra,20($sp)
		lw $fp,16($sp)
		addi $sp,$sp,32
		
		jr $ra
follow:
	sw $v0,4($a0)	#store dir of new node in last node
	
	#-- Devolver pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	
	jr $ra	
	
	
remove:
loop:	
	lw $t0,0($a0)
	beq $t0,$a1,found
	move $t1,$a0 #Save previous dir
	lw $a0,4($a0)
	beq $a0,0,null
	b loop
found: 
	addi $t0,$a0,8
	sw $t0,4($t1)	# Link previous node with next node
	## Free allocated memory
	sw $zero,0($a0)
	sw $zero,4($a0)
	move $v0,$a0
	jr $ra
null:
	addi $v0,$zero,0
	jr $ra
	
print:
	#-- Crear la pila
	addi $sp, $sp, -32
 	sw $ra, 20($sp)
	sw $fp, 16($sp)
	addi $fp, $sp, 28
	lw $t0,4($a0)
	beq $t0,0,print_node
		sw $a0,0($fp)
		lw $a0,4($a0)
		
		jal print
		
		lw $a0,0($fp)
	
print_node:
	lw $a0,0($a0)
	li $v0,1
	syscall
	
	#-- Devolver pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	
	jr $ra
	
exit_program:
	li $v0,10
	syscall
