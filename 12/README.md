Chapter 12
==========

* Handling processes is very fast in general
* `spawn`, `!`, and `receive ... end`
* sending a reply address via `{self(), Data}` is standard practice
* `receive ... after Timeout ... end`
* can be used to handle the mailbox (flushing)
* can be used to do priority receives (inefficient!)
* After a timeout, saved messages are put back into the mailbox
* `register(Atom, Pid)`, `unregister(Atom)`,
`whereis(Atom) -> Pid | undefined`, `registered()`
* Concurrent program template:
<pre>
start() -> spawn(loop).
rpc(Pid, D) ->
    Pid ! {self(), D},
    recv
        {Pid, D} ->
            f(D)
    end.
loop(X) ->
    recv
        _D ->
            f(_D),
            loop(X)
    end.
</pre>
* MFA vs F spawning
