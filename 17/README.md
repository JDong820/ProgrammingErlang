Programming with Sockets
========================

* `gen_udp`, `gen_tcp`

TCP
---

* marshal with `{packet, N}` arg in `get_tcp:connect` and `gen_tcp:listen`
* should set socket options immediately after accepting a connection:
<pre>
{ok, Socket} = gen_tcp:accept(Listen),
inet:setopts(Socket, [...]),
...
</pre>
* `active`, `passive`, and `hybrid` message reception
* `hybrid` with `{active, once}`, manually resetting ready status
* socket automatically linked to controlling proc

UDP
---

* careful of duplicated packets, thus use `make_ref()` to track packets
