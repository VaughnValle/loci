- if $n$ items are put into $m$ containers, with $n > m$, then at least one container must contain more than one item


### Examples
1. Show that if 101 integers are chosen from 1 to 200 inclusive, there must be 2 with the property that one is divisible by the other.

Here is an outline for a proof.

First write the 101 integers as 

x1, x2,  ![](https://www.webassign.net/wastatic/wacache060a4492deb9aa2bf33043201fd9886e/watex/img/ldots.gif) , x101,

 and represent each in the form 

xi = 2ki · ai,

 where 

ai

 is the uniquely determined odd integer obtained by dividing 

xi

 by the highest possible power of 2 (which could be 

20).

Note that because each 

xi

 satisfies the condition 

1 ≤ xi ≤ 200

 and because each 

ai

 is odd, then 

1 ≤ ai ≤ 199,

 for each integer _i_.

Let 

X = 

|   |
|---|
|![](https://www.webassign.net/wastatic/wacache060a4492deb9aa2bf33043201fd9886e/watex/img/leftbrace1.gif)|

x1, x2,  ![](https://www.webassign.net/wastatic/wacache060a4492deb9aa2bf33043201fd9886e/watex/img/ldots.gif) , x101

|                                                                                                           |
| --------------------------------------------------------------------------------------------------------- |
| ![](https://www.webassign.net/wastatic/wacache060a4492deb9aa2bf33043201fd9886e/watex/img/rightbrace1.gif) |

 and let _Y_ be the set of all possible values of the 

ai's.

Define a function _F_ from _X_ to _Y_ by the rule 

F(xi) = that odd integer ai such that xi = 2ki · ai.

Use the fact that there are only 99 odd integers from 1 to 199 inclusive to show that 

F(xi) = F(xj)

 for some integers 

xi

 and 

xj

with 

xi ≠ xj.

Finally, show that either 

xi

 divides 

xj

 or 

xj

 divides 

xi.

Use the outline to write a complete proof for the given statement, and submit it as a f