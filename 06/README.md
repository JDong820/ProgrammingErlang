Error Handling in Sequential Programs
=====================================

* "Let it crash": don't return when arguments are invalid
* `exit`, `throw`, and `error`
* `try Expr of ..patterns... catch ...e:patterns... after ... end.`
* `try ... catch` has a value
* `after ...` always executed, value lost
* `{'EXIT', Value|Error}` returned by `catch`
* Errors common:
<pre>
case f(x) of
  {ok, X} -> ...;
  {error, Why} -> ...
end
</pre>
or
<pre>
{ok, X} = f(x). % raises exception on {error, Why}
</pre>
* Errors rare:
<pre>
try f(x) of
  ...
catch
  throw:...;
  throw:...
end
</pre>
or 
<pre>
f(X) ->
  case ... of
  ...patterns...
  ...patterns... -> throw({err, Data})
</pre>
* `erlang:get_stacktrace/0`
* Fail fast, and log it.
