Binary and the Bit Syntax
=========================

* `<<Data, Data>>` where `0 <= Data <= 255`
* binary BIFs
* bitwise syntax
* `bitstring` vs `binary`, the latter is len 0 mod 8 bits
* Bit syntax:
<pre>
Ei =
Value |
Value:Size |
Value/type-specifier-list |
Value:Size/type-specifier-list
</pre>
* `big`, `little`, and `native`
* `singed` and `unsinged`
* lots of types
* `Unit` is related to segment size (`Size` * `Unit`) bits long
* `<< X || X <= Generator >>` bit comprehension syntax

Questions
---------

* What is `Unit` and `Type`?

`Type` is for pattern matching variables. The bits are parsed based on the
`Type` into higher level data (ints, floats, etc.). `Unit` is actually
quite useful for when you know the size of the data.
[Stack Overflow](http://stackoverflow.com/a/11865643/2534876) has an example.
