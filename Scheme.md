
## Literals
In Scheme, a "literal" refers to a self-evaluating expression that directly represents a data value, such as numbers, strings, booleans, symbols, or lists, which can be written directly in the code without needing further computation to determine their value; essentially, they are the raw data values you type into your program as they are meant to be interpreted. [[1](https://docs.scheme.org/schintro/schintro_51.html), [2](https://www.cefns.nau.edu/~edo/Classes/CS396_WWW/Misc_docs/schemeCheatsheet.pdf), [3](https://www.cs.williams.edu/~morgan/cs334/handouts/scheme-overview.pdf)]

  

Key points about literals in Scheme: [[2](https://www.cefns.nau.edu/~edo/Classes/CS396_WWW/Misc_docs/schemeCheatsheet.pdf), [4](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_4.html)]

- Examples:
    - Numbers like 5
    - Strings like "hello"
    - Booleans like #t (true) and #f (false)
    - Symbols like 'car
    - Lists like '(a b c)
- Self-evaluating: Literals evaluate to themselves when encountered in a Scheme expression.
- Quotation for complex literals: To create more complex data structures like nested lists, you can use the quote operator (') to prevent evaluation of a list until needed. [[1](https://docs.scheme.org/schintro/schintro_51.html), [2](https://www.cefns.nau.edu/~edo/Classes/CS396_WWW/Misc_docs/schemeCheatsheet.pdf), [3](https://www.cs.williams.edu/~morgan/cs334/handouts/scheme-overview.pdf), [4](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_4.html)] 

> [! example] References
> - [https://docs.scheme.org/schintro/schintro_51.html](https://docs.scheme.org/schintro/schintro_51.html)
> - [https://www.cefns.nau.edu/~edo/Classes/CS396_WWW/Misc_docs/schemeCheatsheet.pdf](https://www.cefns.nau.edu/~edo/Classes/CS396_WWW/Misc_docs/schemeCheatsheet.pdf)
> - [https://www.cs.williams.edu/~morgan/cs334/handouts/scheme-overview.pdf](https://www.cs.williams.edu/~morgan/cs334/handouts/scheme-overview.pdf)
> -  [https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_4.html](https://groups.csail.mit.edu/mac/ftpdir/scheme-reports/r5rs-html/r5rs_4.html)