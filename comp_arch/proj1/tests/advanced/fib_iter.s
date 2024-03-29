# This is an _iterative_ implementation of fibonacci sequence in E20
# assembly language.

# We use $1 for two purposes: to store n before the run the program,
# and store the nth Fibonacci number, when the program ends.

# We use $2 and $3 to store the previous and previous-previous
# Fibonacci numbers. Every iteration, the previous number becomes
# the previous-previous number, and the current number (the sum
# of the previous and previous-previous) becomes the previous number.
#
# count = 8
# prev = 1
# prevprev = 0
# while count != 0:
#    count -= 1
#    temp = prev + prevprev
#    prevprev = prev
#    prev = temp
# print(prev)
#

main:
    movi $1, 8       # this is the initial argument: we want the nth fib number

    movi $2, 0       # previousprevious
    movi $3, 1       # previous

again:
    jeq $1, $0, done
    addi $1, $1, -1
    add $4, $2, $3  # previous + previousprevious

    add $2, $0, $3  # move everything down the line
    add $3, $0, $4
    j again

done:
    add $1, $0, $3   # our final result goes in $1
    halt
#--
#--
#--MACHINE CODE
# ram[0] = 16'b0010000010001000;		// main: movi $1,8
# ram[1] = 16'b0010000100000000;		// movi $2,0
# ram[2] = 16'b0010000110000001;		// movi $3,1
# ram[3] = 16'b1100010000000101;		// again: jeq $1,$0,done
# ram[4] = 16'b0010010011111111;		// addi $1,$1,-1
# ram[5] = 16'b0000100111000000;		// add $4,$2,$3
# ram[6] = 16'b0000000110100000;		// add $2,$0,$3
# ram[7] = 16'b0000001000110000;		// add $3,$0,$4
# ram[8] = 16'b0100000000000011;		// j again
# ram[9] = 16'b0000000110010000;		// done: add $1,$0,$3
# ram[10] = 16'b0100000000001010;		// halt 
#--
#--
#--EXECUTION OUTPUT
# Final state:
# 	pc=   10
# 	$0=    0
# 	$1=   34
# 	$2=   21
# 	$3=   34
# 	$4=   34
# 	$5=    0
# 	$6=    0
# 	$7=    0
# 2088 2100 2181 c405 24ff 09c0 01a0 0230 
# 4003 0190 400a 0000 0000 0000 0000 0000 
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
