> [! important] 
> - Shift-reduce algorithms
> - Table driven, ([[ACTION table]] and [[GOTO table]])
> - LR config uses state to keep track of parser 

An LR parser, in computer science, is a type of bottom-up parsing algorithm used to analyze the syntax of a programming language by reading the input from left to right and constructing a parse tree based on a rightmost derivation in reverse; "LR" stands for "left-to-right, rightmost derivation" - making it a powerful tool for compiler design due to its ability to handle a wide range of context-free grammars. [[1](https://en.wikipedia.org/wiki/Canonical_LR_parser#:~:text=A%20canonical%20LR%20parser%20\(also%20called%20a,stands%20for%20%22left%2Dto%2Dright%2C%20rightmost%20derivation%20in%20reverse.%22), [2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html)]

  

Key points about LR parsers: [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [3](https://www2.lawrence.edu/fast/GREGGJ/CMSC515/Parsing/LR.html#:~:text=Running%20the%20parser%20*%20Take%20the%20transition,rule%20you%20just%20used%20in%20the%20reduction.)]

- Functionality: LR parsers operate by building a parse tree by progressively "shifting" input tokens onto a stack and then performing "reductions" when a pattern matching a grammar rule is recognized on the stack. [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [3](https://www2.lawrence.edu/fast/GREGGJ/CMSC515/Parsing/LR.html#:~:text=Running%20the%20parser%20*%20Take%20the%20transition,rule%20you%20just%20used%20in%20the%20reduction.)]
- Advantages: [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [4](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html), [5](https://www.uoanbar.edu.iq/eStoreImages/Bank/26086.pdf#:~:text=LR%20parsers%20can%20be%20constructed%20to%20recognize,implemented%20as%20efficiently%20as%20other%20shift%2Dreduce%20methods.)]
    - Can parse a larger class of grammars compared to other parsing techniques like predictive parsers. [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [4](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html), [5](https://www.uoanbar.edu.iq/eStoreImages/Bank/26086.pdf#:~:text=LR%20parsers%20can%20be%20constructed%20to%20recognize,implemented%20as%20efficiently%20as%20other%20shift%2Dreduce%20methods.)]
    - Efficiently handles most programming language constructs that can be described by context-free grammars. [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [4](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html), [5](https://www.uoanbar.edu.iq/eStoreImages/Bank/26086.pdf#:~:text=LR%20parsers%20can%20be%20constructed%20to%20recognize,implemented%20as%20efficiently%20as%20other%20shift%2Dreduce%20methods.)]
    - Provides fast error detection. [[4](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html), [6](https://www.geeksforgeeks.org/lr-parser/)]
- Different types of LR parsers: [[7](https://ieeexplore.ieee.org/document/10010906/#:~:text=The%20four%20forms%20of%20bottom%2Dup%20parsing%20LR,to%20parse%20a%20variety%20of%20context%2Dfree%20grammar.), [8](https://en.wikipedia.org/wiki/Simple_LR_parser#:~:text=In%20computer%20science%2C%20a%20Simple%20LR%20or,and%20a%20relatively%20simple%20parser%20generator%20algorithm.)]
    - SLR (Simple LR): A basic LR parser with a simpler construction process but may not work for all grammars. [[7](https://ieeexplore.ieee.org/document/10010906/#:~:text=The%20four%20forms%20of%20bottom%2Dup%20parsing%20LR,to%20parse%20a%20variety%20of%20context%2Dfree%20grammar.), [8](https://en.wikipedia.org/wiki/Simple_LR_parser#:~:text=In%20computer%20science%2C%20a%20Simple%20LR%20or,and%20a%20relatively%20simple%20parser%20generator%20algorithm.)]
    - LALR (Look-Ahead LR): An improved version of SLR that uses a limited lookahead to resolve parsing conflicts, making it more powerful [[7](https://ieeexplore.ieee.org/document/10010906/#:~:text=The%20four%20forms%20of%20bottom%2Dup%20parsing%20LR,to%20parse%20a%20variety%20of%20context%2Dfree%20grammar.)]
    - Canonical LR (CLR): The most powerful LR parser, but can be computationally expensive to construct. [[1](https://en.wikipedia.org/wiki/Canonical_LR_parser#:~:text=A%20canonical%20LR%20parser%20\(also%20called%20a,stands%20for%20%22left%2Dto%2Dright%2C%20rightmost%20derivation%20in%20reverse.%22), [9](https://testbook.com/question-answer/which-of-the-following-statements-isare-correct--61a9fb01c07225cfbe262978#:~:text=Canonical%20\(CLR\)%20is%20the%20most%20powerful%20Parsers%20among%20all%20the%20LR\(k\)%20Parsers%20or%20SLR.)]

How LR parsing works: [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [6](https://www.geeksforgeeks.org/lr-parser/), [10](https://www.youtube.com/watch?v=8UDWd-Axd5A)]

- Parsing table: A table is generated based on the grammar which specifies actions (shift, reduce, accept) to take based on the current state on the stack and the next input symbol. [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [6](https://www.geeksforgeeks.org/lr-parser/), [10](https://www.youtube.com/watch?v=8UDWd-Axd5A)]
- Stack operations: [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [3](https://www2.lawrence.edu/fast/GREGGJ/CMSC515/Parsing/LR.html#:~:text=Running%20the%20parser%20*%20Take%20the%20transition,rule%20you%20just%20used%20in%20the%20reduction.), [11](https://groups.seas.harvard.edu/courses/cs153/2018fa/lectures/Lec06-LR-Parsing.pdf)]
    - Shift: Push the current input symbol and the corresponding state onto the stack. [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [3](https://www2.lawrence.edu/fast/GREGGJ/CMSC515/Parsing/LR.html#:~:text=Running%20the%20parser%20*%20Take%20the%20transition,rule%20you%20just%20used%20in%20the%20reduction.), [11](https://groups.seas.harvard.edu/courses/cs153/2018fa/lectures/Lec06-LR-Parsing.pdf)]
    - Reduce: Pop elements from the stack that match the right-hand side of a grammar rule and push the corresponding non-terminal and state onto the stack. [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [3](https://www2.lawrence.edu/fast/GREGGJ/CMSC515/Parsing/LR.html#:~:text=Running%20the%20parser%20*%20Take%20the%20transition,rule%20you%20just%20used%20in%20the%20reduction.), [11](https://groups.seas.harvard.edu/courses/cs153/2018fa/lectures/Lec06-LR-Parsing.pdf)]

Important considerations: [[4](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html), [5](https://www.uoanbar.edu.iq/eStoreImages/Bank/26086.pdf#:~:text=LR%20parsers%20can%20be%20constructed%20to%20recognize,implemented%20as%20efficiently%20as%20other%20shift%2Dreduce%20methods.)]

- Grammar restrictions: Not all context-free grammars can be parsed by LR parsers; certain conditions need to be met to avoid parsing conflicts. [[4](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html), [5](https://www.uoanbar.edu.iq/eStoreImages/Bank/26086.pdf#:~:text=LR%20parsers%20can%20be%20constructed%20to%20recognize,implemented%20as%20efficiently%20as%20other%20shift%2Dreduce%20methods.)]
- Implementation complexity: While powerful, generating an LR parsing table for a complex grammar can be challenging and often requires specialized parser generators. [[2](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html), [4](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html)]

  

[1] [https://en.wikipedia.org/wiki/Canonical_LR_parser](https://en.wikipedia.org/wiki/Canonical_LR_parser#:~:text=A%20canonical%20LR%20parser%20\(also%20called%20a,stands%20for%20%22left%2Dto%2Dright%2C%20rightmost%20derivation%20in%20reverse.%22)

[2] [https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html](https://www.vemeko.com/blog/lr-parser-basics-what-is-lr-parser.html)

[3] [https://www2.lawrence.edu/fast/GREGGJ/CMSC515/Parsing/LR.html](https://www2.lawrence.edu/fast/GREGGJ/CMSC515/Parsing/LR.html#:~:text=Running%20the%20parser%20*%20Take%20the%20transition,rule%20you%20just%20used%20in%20the%20reduction.)

[4] [https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html](https://www.csd.uwo.ca/~mmorenom/CS447/Lectures/Syntax.html/node29.html)

[5] [https://www.uoanbar.edu.iq/eStoreImages/Bank/26086.pdf](https://www.uoanbar.edu.iq/eStoreImages/Bank/26086.pdf#:~:text=LR%20parsers%20can%20be%20constructed%20to%20recognize,implemented%20as%20efficiently%20as%20other%20shift%2Dreduce%20methods.)

[6] [https://www.geeksforgeeks.org/lr-parser/](https://www.geeksforgeeks.org/lr-parser/)

[7] [https://ieeexplore.ieee.org/document/10010906/](https://ieeexplore.ieee.org/document/10010906/#:~:text=The%20four%20forms%20of%20bottom%2Dup%20parsing%20LR,to%20parse%20a%20variety%20of%20context%2Dfree%20grammar.)

[8] [https://en.wikipedia.org/wiki/Simple_LR_parser](https://en.wikipedia.org/wiki/Simple_LR_parser#:~:text=In%20computer%20science%2C%20a%20Simple%20LR%20or,and%20a%20relatively%20simple%20parser%20generator%20algorithm.)

[9] [https://testbook.com/question-answer/which-of-the-following-statements-isare-correct--61a9fb01c07225cfbe262978](https://testbook.com/question-answer/which-of-the-following-statements-isare-correct--61a9fb01c07225cfbe262978#:~:text=Canonical%20\(CLR\)%20is%20the%20most%20powerful%20Parsers%20among%20all%20the%20LR\(k\)%20Parsers%20or%20SLR.)

[10] [https://www.youtube.com/watch?v=8UDWd-Axd5A](https://www.youtube.com/watch?v=8UDWd-Axd5A)

[11] [https://groups.seas.harvard.edu/courses/cs153/2018fa/lectures/Lec06-LR-Parsing.pdf](https://groups.seas.harvard.edu/courses/cs153/2018fa/lectures/Lec06-LR-Parsing.pdf)