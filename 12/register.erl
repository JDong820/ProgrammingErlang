-module(register).
-export([start/2, test_start/0]).

test_start() ->
    spawn(register, start, ['TEST', fun() -> io:format("beep! ~w~n", [self()]) end]),
    spawn(register, start, ['TEST', fun() -> io:format("beep! ~w~n", [self()]) end]).

start(AnAtom, Fun) ->
    case whereis(AnAtom) of
        undefined -> register(AnAtom, spawn(Fun))
    end.
