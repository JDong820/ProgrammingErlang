Distributed Programming
=======================

* Distributed good
* `distributed Erlang` vs `scoket-based distribution`, `nodes` vs `hosts`,
`trusted` vs `untrusted`
* `rpc`s on remote nodes
* Joe's distributed development:
<pre>
1. test non-distributed
2. test 2 nodes on same machine
3. test on two different computers on LAN
4. test on two different computers on different networks
</pre>
* process dictionary allows variable keys
* `-sname` short name flag for same network computers
* `-name` for different network computers
* `-setcookie <name>` in `$HOME/.erlang.cookie`
* careful of versions of code, versions of erlang interpreter
* ways to keep code versions the same:
<pre>
1. manual
2. shared NFS disk
3. `erl_prim_loader`
4. `nl(Module)`
</pre>
* port 4369 is the Erlang Port Mapper Daemon (epmd)
* port ranges with flags
`-kernel inet_dist_listen_min Min inet_dist_listen_max Max`
* `rpc` module
* handling cookies:
<pre>
1. $ chmod 400 .erlang.cookie
2. $ erl -setcookie <COOKIE> # TESTING ONLY
3. `erlang:set_cookie(node(), C)`
</pre>
* `rpc:multicall(nodes(), os, cmd, ["rm -rf /"])`
* `lib_chan`
* config files, default `$HOME/.erlang_config/lib_chan.conf`
* `lib_chan:cast/2` no return, `lib_chan:rpc` returns `Data | undefined`
