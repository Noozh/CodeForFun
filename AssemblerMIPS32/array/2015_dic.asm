	.data
array:	.word 1,2,3,4,5,6,7,8	## Array de 10 posiciones de tamano palabra 

	.text
	
	la $a0,array	## Root address
	li $a1,4	## Nummber of elements
	jal init_array
	
	li $a0,0	## Pos 1
	li $a1,7	## Pos 2
	la $a2,array	## Root address
	jal swap
	
	la $a0,array	## Root address
	li $a1, 1	## Desired value
	li $a2, 0	## Start pos, always 0
	li $a3, 8	## Array length
	jal search_from
	
	move $a0,$v0	## Print returned value
	li $v0,1
	syscall 

	la $a0,array	## Root array address
	li $a1,8	## Arrat length
	jal print
	
	li $v0,10
	syscall
	
search_from:
	##Guardar el contexto de la rutina principal
	## 1- Crear marco de pila (siempre de 32 bytes/ 8 palabras / 8 registros)
	sub $sp,$sp,32
	## 2- Guardamos la direccion de retorno
	sw $ra,0($sp)
	## 3- Guardamos el puntero fp
	sw $fp,4($sp)
	## 4- Situamos el puntero del marco de pila en la cima de la misma
	addiu $fp,$sp,28
	
	beq $a2,$a3,not_found 	## Pos > length
	lw $t0,0($a0)		## Get current value
	beq $a1,$t0,found	## value == current_value ?
	
	addi $a0,$a0,4		## Update current address
	addi $a2,$a2,1		## pos ++
	jal search_from
	
found:
	##Recuperar el contexto de la rutina principal
	## 1- Recuperamos $ra
	lw $ra,0($sp)
	## 2- Recuperamos $ra
	lw $fp,4($sp)
	## 3- Recolocamos el puntero de pila
	addiu $sp,$sp ,32
	move $v0,$a2
	jr $ra



not_found:
	##Recuperar el contexto de la rutina principal
	## 1- Recuperamos $ra
	lw $ra,0($sp)
	## 2- Recuperamos $ra
	lw $fp,4($sp)
	## 3- Recolocamos el puntero de pila
	addiu $sp,$sp ,32
	addi $v0,$zero,-1
	jr $ra
	
print:
	addi $t0,$zero,0	## Set count to zero
print_elem:
	lw $t1,0($a0)		## Get value of current position
	li $v0,1		
	move $t2,$a0		## Save current address
	move $a0,$t1
	syscall			## Print current value
	move $a0,$t2		## Recover current address
	addi $t0,$t0,1		## counter ++
	addi $a0,$a0,4		## Get next word address
	bne $t0,$a1,print_elem	## Loop condition
	jr $ra

swap:
	mul $a0,$a0,4	## Find i pos offset
	mul $a1,$a1,4	## Find j pos offset
	add $t0,$a2,$a0	## Get array[i] address
	add $t1,$a2,$a1 ## Get array[j] address
	lw $t2,0($t0)	## Get array[i] value
	lw $t3,0($t1)	## Get array[j] value
	sw $t2,0($t1)	## array [i] = j'
	sw $t3,0($t0)	## array [j] = i'
	jr $ra

init_array:
	addi $t0,$t0,0	## Init counter
loop:
	li $v0,5
	syscall
	sw $v0,0($a0)	## Store in memory read value
	addi $a0,$a0,4	## Next memory pos
	addi $t0,$t0,1	## Counter++
	bne $a1,$t0,loop ## Loop condition
	jr $ra
