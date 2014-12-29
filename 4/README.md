Chaper 4 Notes
==============

* `module declaration`
* `export declaration`
* `arity`
* `clause` structure:
<pre>
    Head -> body;
    Head2 -> body2;
    Head3 -> body3.
</pre>
* `expressions` and `expression sequences` compose the `body`
* order matters for clauses
* `c(<module>)` is shell only
* fail to match pattern is ok
* Commas, semicolons, and full stops
* `H|T` recursion, list is empty or nonempty
* higher level functions
* namespaces; don't ever make a module called `lists`
* `-import(<module>, [...]).`
* "fully qualified" names
* some BIFs autoimported e.g. `list_to_tuple`

Guards
------

* guard syntax: `when`
* `guard sequence` separated by ; = OR
* `(series of) guard(s)` , = AND
* only the atom `true` is truthy, all else is falsy
* true catchall guard
* 
* lists:reverse
* accumulators/recursive helpers

Questions:
----------

* Why can't I run `my_time_func(erlang:now)`?
You can. The correct syntax `my_time_func(fun erlang:now/0)`
* Erlang testing framework? What's the meta?

TODO:
-----

* Implement python `datetime`, exercise 4.
