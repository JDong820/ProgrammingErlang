Errors in Concurrent Programs
=============================

* "Let some other process fix the error.", "Let it crash."
* `links`, `monitors`
* Specialization: Observers handle errors, Workers handle normal cases
* `Link sets`, `Error receipts`, `fake errors`
* `process_flag(trap_exit, true)` to become an OS process
(does not die on exit receipt since it can trap signals)
* `spawn_link` atomic `spawn` + `link`
* race conditions

Questions
---------
* How does statistics/1 work in concurrent Erlang?
* How is debugging and testing done in concurrent Erlang?
* What's the point of `references` (since we have `pid`s)?

It's like the pid, except you can't send messages. It's a good abstraction for
monitors.
