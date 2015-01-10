Interfacing Techniques
======================

* Three options for interfacing:
  * Run a `port process`, that is, external process communicated through a
port (safe)
  * Run an OS command and capture the outputO
  * Run the code in the EVM, efficient but unsafe
* `NIFs`, `linked-in drivers`, `C-nodes`
* `open_port`
* To interface a C program, add a driver to support a port protocol

Issues
------

* `erlang/linked_in_drivers.git` doesn't seem to exist, so I played with
[erlang_js](https://github.com/basho/erlang_js) instead
