Chapter 9
=========

* `-spec`, `-type` annotations
* `Type :: A | B | C`, can be recursive, `[]` for arrays
* `none()` special type
* `Fun`, `Atom`, `port()`, `any()`, etc.
* Many predefined types such as `term`, `boolean`, `byte`, etc.
(Hint: not quite related to bit operator types)
* `-spec F(T1, T2) -> T3 when ... T1 :: Type1, ...
* Opaque types useful for abstraction, e.g. `-opaque type() :: ...`
* `$ dialyzer <file>` 
* `$ typer <file>` 
* `-compile(export_all)` literally `from module import * `
* Anonymous vars make the typer confused

Questions
---------

* How to find the source for `lists.erl`?
Found it: https://github.com/erlang/otp/blob/maint/lib/stdlib/src/lists.erl
