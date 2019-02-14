## Crear pila
## addi $sp,$sp,-32
## sw $ra,20($sp)
## sw $fp,16($sp)
## addi $fp,$sp,28

## Devolver pila
## lw $ra,20($sp)
## lw $fp,16($sp)
## addi $sp,$sp,32

## $s0 guarda la direccion del primer nodo de la lista
.data
next_value_symbol:	.asciiz "|-->"
value_separator:	.asciiz "|"

.text
main:
read_input:
	## Read input value 
	li $v0,5
	syscall
	beq $v0,0,brk
	
	move $a0,$s0
	move $a1,$v0
	jal insert_in_order
	move $s0,$v0
	
	b read_input
brk:
	move $a0,$s0
	jal print
end_main:
	li $v0,10
	syscall
	
## node_t * create(int val, node_t *next):
create:
	## Rutinas pila
	addi $sp,$sp,-32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addi $fp,$sp,28
	
	## Guardo el contexto de la rutina antes de hacer syscall
	sw $a0,0($fp)
	sw $a1,-4($fp)
	
	## Reservo 8 bytes (tamaño del nodo)
	li $v0,9
	li $a0,8
	syscall
	## Si no me devuelven memoria acabo la ejecucion del programa
	beq $v0,$zero,end_main
	
	## Recupero el contexto de la rutina
	lw $a0,0($fp)
	lw $a1,-4($fp)
	
	## Inicializo el nodo
	sw $a0,0($v0)
	sw $a1,4($v0)
	
	## Devolver pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	
	jr $ra
	
## insert_in_order(node_t *first, int val)
insert_in_order:
	## Rutinas pila
	addi $sp,$sp,-32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addi $fp,$sp,28
	
	## Establezco un contador para comprobar si es menor que el primer nodo
	addi $t7,$zero,0
	## Guardo la direccion del primer nodo en la pila
	sw $a0,0($fp)
	
	## Si la lista esta vacia --> caso especial (primer nodo)
	bne $a0,$zero,search_pos
		## create(val,NULL)
		move $a0,$a1
		move $a1,$zero
		jal create
		## Devuelvo lo que me ha devuelto create
		b end_insert
	
	## Si ya hay elementos en la lista busco el lugar adecuado para guardar el nuevo
search_pos:
	## Si la direccion es 0 he llegado al final --> lo guardo el ultimo
	beq $a0,$zero,found_pos
	## Traigo el valor del nodo que hay en $t0
	lw $t0,0($a0)
	## Si el valor del nodo actual es igual al que quiero meter salgo de insert sin guardarlo devolviendo el mismo first que pase
	bne $t0,$a1,continue
		## Traigo de la pila el valor que pase como primer nodo para devolverlo
		lw $v0,0($fp)
		b end_insert
continue:
	## Si el valor que quiero meter es menor que el actual he encontrado posicion,si no avanzo al siguiente nodo
	blt $a1,$t0,found_pos
		## Actializo el contador 
		addi $t7,$t7,1
		## Guardo la direccion del nodo anterior para poder hacer un bypass
		move $t2,$a0
		## Cargo la direccion del siguiente nodo
		lw $a0,4($a0)
	b search_pos
	
found_pos:
	## Si he encontrado su hueco llamo a create
	sw $t2,4($fp)
	## create (val,$a0) teniendo $a0 la direccion del nodo con mayor valor que el que quiero insertar
	move $t6,$a1 
	move $a1,$a0
	move $a0,$t6
	jal create
	## Hago el bypass entre el anterior y el actual siguiente si el anterior no es 0 y si no es nuevo primer nodo
	beq $t7,$zero,end_insert
		lw $t2,4($fp)
		beq $t2,$zero,end_insert
			sw $v0,4($t2)
	
end_insert:
	## Si no se ha encontrado el primero tengo que devolver como primer nodo el nodo con el que llame a la funcion insert
	beq $t7,$zero,follow
		## Recupero el valor del primer nodo y lo cargo en $v0 para retornar esa direccion
		lw $v0,0($fp)
follow:
	## Devolver pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	
	jr $ra
	
## void print(node_t *node)
## if (node != null){
##	print(node->next);
##	printf(“%d\n”, node->val);
##}
##return;
print:
	## Rutinas pila
	addi $sp,$sp,-32
	sw $ra,20($sp)
	sw $fp,16($sp)
	addi $fp,$sp,28
	
	beq $a0,$zero,end_print
		## Guardo contexto
		sw $a0,0($fp)
		## Traigo direccion del siguiente nod
		lw $a0,4($a0)
		## Llamada recursiva
		jal print
		
		## Imprime simbolo valor actual
		li $v0,4
		la $a0,value_separator
		syscall
		
		## Recupero contexto (La direccion de nodo que quiero imprimir)
		lw $a0,0($fp)
		
		## Imprime el valor del nodo
		li $v0,1
		lw $a0,0($a0)
		syscall
		
		## Imprime simbolo de siguiente valor
		li $v0,4
		la $a0,next_value_symbol
		syscall
end_print:
	
	## Devolver pila
	lw $ra,20($sp)
	lw $fp,16($sp)
	addi $sp,$sp,32
	
	jr $ra
