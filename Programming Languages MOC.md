---
tags:
  - prog-lang
---
> [!important]
> - No LATE homeworks
> - No ChatGPT

# Book Recommendations
- “Concepts of Programming Languages (11th Edition) ” by Robert Sebesta
- "Programming Languages Principles and Practice” Louden and Lambert (3rd Edition)

## Final
- Before May 16
## Syllabus
- [[Evolution of Programming Languages]]
- [[Language Evaluation Criteria]]
- [[Von Neumann architecture]]
- [[Language Categories]]
- [[Swiss-Cheese Model]]
- [[Pairwise Disjoint Set]]
	- Does not apply to bottom-up parsing 
	- only top-down parsing
- C++
	- Compiler
	- Linker
	- Loader
- [[Preprocessor]]
- [EBNF](https://ics.uci.edu/~pattis/ICS-33/lectures/ebnf.pdf)
	- [[Top-down Parsers]]
	- [[Bottom-up Parsers]]
		- [[LR Parser]]
- [[Scheme]]

## Midterm
[[Proglam Midterm Review]]
### Notes:
- Read everything first
- + o - strat
- Don't worry about:
	- Axiomatic Semantics
- Study on:
	- Writing BNF
		- [BNF](https://www.youtube.com/watch?v=F25ez8s3AsQ&pp=ygUDYm5m)
	- LR Parsing Table
		- [LR Parsing](https://www.youtube.com/watch?v=OIKL6wFjFOo)
		- shift or reduce
			- lead to:
				- hole: reject
				- accept
	- Parser
		- calls lex 
	- Syntax analyzer
		- do these tokens make sense
	- Lexical Analyzer
		- [Lexical Analyzer](https://www.youtube.com/watch?v=4nx8LEGy9kI&pp=ygUQbGV4aWNhbCBhbmFseXplcg%3D%3D)
		- source code to token
		- responsible for getting one token at a time
		- identifier vs token
		- language decides whether to use reserved word or keywords
			- guarantee that a while will be a while loop
		- Breaking things apart
		- Lexeme vs token
			- Lexeme is w h i l e
			- Token is while
		- State Diagram
			- C++ still cant start with a number
				- because of we encounter a digit, what follows are numbers
				- If we encounter a letter, we pass the lexeme to the lookup table to get a token
		- Implementation
			- add_char + get_char
			- https://github.com/huichen-cs/sebesta/blob/master/parser/front.c
	- Scheme and PHP
		- Write code, much like homework

### History
- Important
### Attribute Grammar
- Inherit vs Synthesize
	- Inherited
		- Function call
		- Knows what the return value is going to be 
```c++
int main (){
	return "Done";

}
```

In inherited, when we make a function call it inherits the return value and proceeds to execute top-down. At the bottom, it receives a string "Done", which is not an int.
### Right vs Left most Derivations
- Right: R to L
- Left: L to R
### BNF
- Write BNF or EBNF
- Repeats you can use {}
### LR Parsing
- T becomes E and LHS
- LHS becomes RHS for 
- RHS are terminal symbols, LHS are always non terminal symbols
	- terminal symbols are what you are going to find in source code
- EBNF
### Multiple choice
- 
### Long response
- Choose only 10
### Code
- PHP
- Scheme

[[Prolog]]

- Systems where memory is limited
	- System will aggregate booleans on 1 byte
	- SNOBOL
		- String oriented symbolic language
	- C style strings
		- Limited dynamic length
			- `\0` style implementation in C
			- Container is larger than needed and a special null terminating character indicates the end
	- An [[ordinal type]] is one where the domains are restricted
	- Rectangular vs jagged array?
	- Why is initial index 0?
		- Because of 
		- `add_element = add_array + (index * element_size)`
	- Questions
		- Why can't we keep track of length while having limited dynamic strings
	- [[Array Implementation]]
	- [[Y2K Problem]]
	- [[Dangling Pointer Problem]]
	- [[Garbage Collection]]
	- [[Type Checking]]
	- Operator operation is determined by [precedence and associativity](https://en.cppreference.com/w/cpp/language/operator_precedence)
	- Operand evaluation
		- [[Functional "side effect"]]
		- No passing variables by reference in Java
		- Referential Transparency
	- Type conversion
		- narrowing conversion
			- destination domain is smaller than source domain
			- `float` to `int`
			- depends on language
				- c++ allows, java does not
		- widening conversion
			- opposite
			- `int` to `float`
			- universally okay
- 1 is True, but True is not 1
	- True is anything else but False
	- True can be anything, depends on :
		- Architecture
		- compiler
		- language
- Assignment is right associative

[[Java]]
