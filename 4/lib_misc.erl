-module(lib_misc).
-export([test_tuple_to_list/0, tuple_to_list/1, my_time_func/1, my_date_string/0]).

test_tuple_to_list() ->
    [1, 4, 9, 16] = lib_misc:tuple_to_list({1, 4, 9, 16}),
    tuple_to_list_passed.

tuple_to_list(T) -> % Reimplementation of BIF.
    [element(Index, T) || Index <- lists:seq(1, tuple_size(T))].

nice_timestamp(T) ->
    % 3 = tuple_size(T),
    if
        element(3, T) < 0 -> nice_timestamp({element(1, T), element(2, T)-1, 1000000-element(3, T)});
        element(2, T) < 0 -> nice_timestamp({element(1, T)-1, 1000000-element(2, T), element(3, T)});
        true -> T
    end.

diff_time(T1, T2) ->
    {Mega_i, S_i, Micro_i} = T1,
    {Mega_f, S_f, Micro_f} = T2,
    nice_timestamp({Mega_f - Mega_i, S_f - S_i, Micro_f - Micro_i}).

my_time_func(F) ->
    T1 = now(),
    F(),
    T2 = now(),
    diff_time(T1, T2).

my_date_string() ->
    {Hr, Min, Sec} = time(),
    {Y, M, D} = date(),
    io:format("~2..0w:~2..0w:~2..0w ~w-~w-~w ~n", [Hr, Min, Sec, D, M, Y]).
