
_by Vaughn Valle_
### BOF
For this challenge, we can see that main contains the ff.
![[Pasted image 20241022173858.png]]
We see that the program is using `gets` to read into `buf`. This is insecure to buffer overflow since we can input something larger than what `buf` can contain. 

Through trial and error, `buf` seems to have a size of 40. After that, `buf` overflows which makes the program throw a Segmentation fault.

Thus, we can throw 40 'A' characters, and whatever we append afterwards will overwrite the return address, making the program jump to that address instead of the default return address. 

We can see a function called `give_shell` is located in `0x401218`
![[Pasted image 20241022174245.png]]
Appending this address after our buffer overflow payload gives us the flag
### Bypass
![[Pasted image 20241022175344.png]]
For this challenge, we are given the canary for the stack the program is running on.
![[Pasted image 20241022175203.png]]
First, we must overflow `buf` correctly such that we get into the if condition, bypassing fail. 

Through trial and error, I figured out that the buffer size is 24. Adding the memory address of `win` will give us shell
![[Pasted image 20241022175401.png]]
After doing this, we get shell access and use it to print the flag via `cat`.
### Trivia
In this challenge, we can see that the program is asking us two questions from main.
![[Pasted image 20241022174412.png]]
Key notes here are that instead of `gets` like the previous challenges, it uses `read` which is safe. Note that both inputs get stored in `buf` and `data` respectively.

However, since we're still reading into `buf`, we can overwrite the return address once we overflow the buffer by exceeding the buffer size. Thus we can feed it the memory address of `win` offset by 8 to jump over the push and mov instructions
![[Pasted image 20241022174635.png]]
![[Pasted image 20241022174812.png]]

Once we get into `win`, we have to bypass the if conditional to get into the `system()` call. To do this, `data_1` and `secret_number_1` must be equal to each outer. In `init()`, we see that `secret_number` is being set to a weird negative integers that converts to `0xdeadbeefdeadbeef` in hex. Thus, we can use this as our second input to set `data` equal to `secret_number`. After doing this, we get shell access and use it to print the flag via `cat`.

### Jumper
Looking at the decompiled code in Binja
![[Pasted image 20241022183452.png]]
First, looking at the `init` function basically tells us it's setting height to an initial value of `0x132d`, which is $4909$ in base 10.

From `get_input`, we can see that the buffer size is $56$. Thus we can have 56 'A' chars as our overflow payload.

Looking back at `main`, the objective here is to make height equal to `0x1337`, which is $4919$ in base 10. We know from the picture above that height is incremented by 1 each time main is called. 

Thus, we just need to call main $9$ more times. But how do we do that?

Let's switch to dissassembly. 
![[Pasted image 20241022184355.png]]
Here we can see the instruction that increments the height by 1. If we can overflow the input buffer by exploiting the $56$ buffer size, and overwrite the return address to `0x00401262`, we can keep going back to this instruction and increment height by 1. 

Doing this $9$ times will make height equal `0x1337`, giving us our flag.