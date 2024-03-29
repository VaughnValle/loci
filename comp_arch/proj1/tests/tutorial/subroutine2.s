# Demo of subroutine being invoked multiple times from different locations.
# Define a subroutine quadruple, that takes a parameter in $1, and multipies
# it by four, leaving the result in $1. First we quadruple 3, then
# we quadruple 9. In both cases, quadruple returns to the expected
# location.

main:
    movi $1, 3
    jal quadruple       # First invocation
    add $2, $0, $1

    movi $1, 9
    jal quadruple       # Second invocation
    add $3, $0, $1

    halt

# subroutine quadruple will quadruple
# the value in $1
quadruple:
    add $1, $1,$1
    add   $1, $1, $1
    jr  $7

#--
#--
#--MACHINE CODE
# ram[0] = 16'b0010000010000011;		// main: movi $1,3
# ram[1] = 16'b0110000000000111;		// jal quadruple
# ram[2] = 16'b0000000010100000;		// add $2,$0,$1
# ram[3] = 16'b0010000010001001;		// movi $1,9
# ram[4] = 16'b0110000000000111;		// jal quadruple
# ram[5] = 16'b0000000010110000;		// add $3,$0,$1
# ram[6] = 16'b0100000000000110;		// halt 
# ram[7] = 16'b0000010010010000;		// quadruple: add $1,$1,$1
# ram[8] = 16'b0000010010010000;		// add $1,$1,$1
# ram[9] = 16'b0001110000001000;		// jr $7
#--
#--
#--EXECUTION OUTPUT
# Final state:
# 	pc=    6
# 	$0=    0
# 	$1=   36
# 	$2=   12
# 	$3=   36
# 	$4=    0
# 	$5=    0
# 	$6=    0
# 	$7=    5
# 2083 6007 00a0 2089 6007 00b0 4006 0490 
# 0490 1c08 0000 0000 0000 0000 0000 0000 
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
