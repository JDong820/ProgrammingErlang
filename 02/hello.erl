-module(hello).
-export([start/0, start/1]).

start() ->
    io:format("Hello world~n").

start(String) ->
    String.
