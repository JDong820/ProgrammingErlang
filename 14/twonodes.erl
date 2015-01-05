-module(twonodes).
-export([start/0, do/3, echo/0, rpc/1]).

start() -> register(node, spawn(fun() -> loop() end)).

do(M, F, A) -> rpc({M, F, A}).

echo() -> rpc(echo).

rpc(Q) ->
    node ! {self(), Q},
    receive
        {node, Value} ->
            Value
    after 1000 ->
              ok
    end.

loop() ->
    receive
        {From, echo} ->
            From ! {node, "Hello world!"},
            loop();
        {From, {M, F, A}} ->
            From ! {node, apply(M, F, A)},
            loop()
    end.
