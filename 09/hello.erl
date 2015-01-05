-module(hello).
-export([start/0, start/1]).

-spec start() -> ok.
-spec start(string()) -> string().

start() ->
    io:format("Hello world~n").

start(String) ->
    String.
