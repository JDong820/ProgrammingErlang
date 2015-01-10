Storing Data with ETS and DETS
==============================

* `(Disk) Erlang Term Storage`
* `O(1)` or `O(log(n))` lookup
* Not garbage collected
* Implemented low level in the EVM
* `sets`, `ordered sets`, `bags`, and `duplicate bags`
* Internally represented as hash tables, except `ordered set`, which is a
balanced binary tree
* For even faster lookups, can hash values to keys
* Large binaries do not incur performance penalties
* Make sure to `close` DETS table to prevent corruption
* DETS can auto repair, but slow
* Table visualization
