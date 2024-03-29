# Some simple math stuff

# add, addi, and sub work as you expect, except
# they take three arguments. The first argument
# is the destination, the other two are the
# sources.
# There is no subi. Instead you have to use addi
# with a negative immediate.
addi $1, $0, 5      # $1 := 5
addi $2, $1, -2     # $2 := $1 + (-2)
add $3, $1, $2      # $3 := $1 + $2

# Notice that $0 is special, because it is always
# zero. So using $0 as a source lets us effectively
# do a movi, as in the first instruction below.
# The last instruction here will produce a negative
# number, which is represented internally as a 16-bit
# 2's complement number, and is displayed in unsigned
# format.
addi $4,$0, 55     # $4 := 55
sub $5, $4,$1      # $5 := $4 - $1
sub $4, $5, $4     # $4 := $5 - $4

# We also have bitwise operators AND and OR.
# (but not ori and andi). As above, the first
# operand is the destination register.
or $6, $2, $5
and $7,$2, $5

halt       # end the program with an infinite loop
#--
#--
#--MACHINE CODE
# ram[0] = 16'b0010000010000101;		// addi $1,$0,5
# ram[1] = 16'b0010010101111110;		// addi $2,$1,-2
# ram[2] = 16'b0000010100110000;		// add $3,$1,$2
# ram[3] = 16'b0010001000110111;		// addi $4,$0,55
# ram[4] = 16'b0001000011010001;		// sub $5,$4,$1
# ram[5] = 16'b0001011001000001;		// sub $4,$5,$4
# ram[6] = 16'b0000101011100010;		// or $6,$2,$5
# ram[7] = 16'b0000101011110011;		// and $7,$2,$5
# ram[8] = 16'b0100000000001000;		// halt 
#--
#--
#--EXECUTION OUTPUT
# Final state:
# 	pc=    8
# 	$0=    0
# 	$1=    5
# 	$2=    3
# 	$3=    8
# 	$4=65531
# 	$5=   50
# 	$6=   51
# 	$7=    2
# 2085 257e 0530 2237 10d1 1641 0ae2 0af3 
# 4008 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
# 0000 0000 0000 0000 0000 0000 0000 0000 
