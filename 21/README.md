Profiling, Debugging, and Tracing
=================================

* `cprof` counts function calls
* `fprof` displays call times, but adds much more load
* `eprof` is similar to `fprof`, general time management
* `cover` for code coverage
* `xref` to cross-ref check before running
* error logger using `elog.config`:
<pre>
[{kernel,
 [{error_logger,
   {file, "/dir/to/debug.log"}}]}].
</pre>
* `erl -config elog.config`
* `im()`, `ii()` debuggers
* `dbg` to trace
* `Common Test Framework` to automate tests
* `Property-based testing` autorandom test generation with `QuickCheck`, `proper`
