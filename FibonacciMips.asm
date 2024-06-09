.data
# Inicialização de variáveis
fib30:   .word 0  
fib40:   .word 0   
fib41:   .word 0   
newline: .asciiz "\n" 

.text
.globl main

# Função principal
main:
    # Calcula o 30º número de Fibonacci
    li $a0, 30       
    jal fibonacci
    move $s1, $v0    
    sw $v0, fib30    

    # Imprime o 30º número de Fibonacci
    li $v0, 1        
    move $a0, $s1
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # Calcula o 40º número de Fibonacci
    li $a0, 40      
    jal fibonacci
    move $s2, $v0    
    sw $v0, fib40    

    # Imprime o 40º número de Fibonacci
    li $v0, 1        
    move $a0, $s2
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # Calcula o 41º número de Fibonacci
    li $a0, 41      
    jal fibonacci
    move $s3, $v0   
    sw $v0, fib41   

    # Imprime o 41º número de Fibonacci
    li $v0, 1       
    move $a0, $s3
    syscall
    la $a0, newline
    li $v0, 4
    syscall

    # Calcula a razão áurea usando F_41 e F_40
    lw $t0, fib41    
    lw $t1, fib40    
    mtc1 $t0, $f4    
    mtc1 $t1, $f6    
    cvt.s.w $f4, $f4 
    cvt.s.w $f6, $f6 
    div.s $f0, $f4, $f6 

    # Imprime a razão áurea
    li $v0, 2        
    mov.s $f12, $f0
    syscall
    la $a0, newline
    li $v0, 4
    syscall

   
    li $v0, 10       
    syscall

# Função para calcular o n-ésimo termo da sequência de Fibonacci
fibonacci:
    addi $sp, $sp, -8    
    sw $ra, 4($sp)      
    sw $a0, 0($sp)       

    li $v0, 1            
    li $t0, 1            

    beq $a0, 1, fib_done 
    beq $a0, 2, fib_done 

    li $t1, 2            
fib_loop:
    add $t2, $v0, $t0    
    move $v0, $t0        
    move $t0, $t2        
    addi $t1, $t1, 1     
    bne $t1, $a0, fib_loop 

    move $v0, $t0        

fib_done:
    lw $ra, 4($sp)       
    lw $a0, 0($sp)       
    addi $sp, $sp, 8     
    jr $ra               
