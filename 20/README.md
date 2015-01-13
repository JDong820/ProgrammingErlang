Mnesia: The Erlang Database
===========================


* `mnesia:create_schema([node()])` takes in list of nodes, can be cross network
* `create_schema` creates a directory
* `mnesia:start(),
mnesia:create_table(<RECORD>, [{attributes, record_info(fields, <RECORD>)}]),
mnesia:stop()`
* `qlc:q(<LIST COMP>)` as queries
* `mnesia:write(Row)` where Row is the right kind of record
* `mnesia:delete(ObjectID)` with transaction to prevent concurrent modification
* `pessimistic locking`
* transactions keep trying, so avoid side effects
* `mnesia:abort(table)`
* `qlc:e(Query)` in a transaction
* Very easy to put Erlang data strutures in Mnesia
* Supports "fragmented" tables aka horizontal partitioning aka sharding
