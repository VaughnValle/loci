# We're going to sum an array of numbers.
# Myarray is a label pointing to the beginning of the array. The array
# can have any number of elements, but the last element must be zero.
# All non-last elements must be non-zero.

# We use $3 as our running sum, and $1 as an index into the array.
# Both are initially zero.

# In the loop, we load the value at address myarray + $1. We add that
# value to the sum, and increment the index. We check if the value
# is zero, and if so, we quit. Otherwise, we iterate.


    movi $1, 0  # initialize counter
    movi $3, 0  # initialize sum

loop:
    lw $2, myarray($1)      # fetch on array item
    add $3, $3, $2          # add it to the sum
    addi $1, $1, 1          # increment counter
    jeq $2, $0, done        # is array item 0? if so, quit
    j loop                  # otherwise loop

done:
    halt                    # end the program

myarray:                    # this label denotes beginning of array
    .fill 434
    .fill 2342
    .fill 31924
    .fill 3
    .fill 85
    .fill 0

#--
#--
#--MACHINE CODE
# ram[0] = 16'b0010000010000000;		// movi $1,0
# ram[1] = 16'b0010000110000000;		// movi $3,0
# ram[2] = 16'b1000010100001000;		// loop: lw $2,myarray($1)
# ram[3] = 16'b0000110100110000;		// add $3,$3,$2
# ram[4] = 16'b0010010010000001;		// addi $1,$1,1
# ram[5] = 16'b1100100000000001;		// jeq $2,$0,done
# ram[6] = 16'b0100000000000010;		// j loop
# ram[7] = 16'b0100000000000111;		// done: halt 
# ram[8] = 16'b0000000110110010;		// myarray: .fill 434
# ram[9] = 16'b0000100100100110;		// .fill 2342
# ram[10] = 16'b0111110010110100;		// .fill 31924
# ram[11] = 16'b0000000000000011;		// .fill 3
# ram[12] = 16'b0000000001010101;		// .fill 85
# ram[13] = 16'b0000000000000000;		// .fill 0
#--
#--
#--EXECUTION OUTPUT
# Final state:
# 	pc=    7
# 	$0=    0
# 	$1=    6
# 	$2=    0
# 	$3=34788
# 	$4=    0
# 	$5=    0
# 	$6=    0
# 	$7=    0
# 2080 2180 8508 0d30 2481 c801 4002 4007 
# 01b2 0926 7cb4 0003 0055 0000 0000 0000 
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
