-module(name_analysis).
-export([whats_popular/0, whats_unique/0, whats_noisy/0]).
-import(dict_count, [fun_count/1]).

count([{Module, Function}|T], Results) ->
    Oldcount = maps:find(Function, Results),
    if
        is_integer(Oldcount) -> count(T, Results#{H -> 1});
        true -> count(T, Results#{H -> Oldcount + 1})
    end;
count([], Results) ->
    Results.

enumerate_funs([Module|T], Results) ->
    [{exports, Exports}|_] = apply(Module, module_info, []),
    enumerate_funs(T, lists:map(fun(E) -> {Module, E} end, Exports) ++ Results).

whats_noisy() ->
    Modules = lists:map(fun(X) -> element(1, X) end, code:all_loaded()),
    Counts = lists:map(fun(Module) -> {fun_count(Module), Module} end, Modules),
    {_Count, Popular} = lists:max(Counts),
    Popular.

whats_popular() ->
    Modules = lists:map(fun(X) -> element(1, X) end, code:all_loaded()),
    Funs = enumerate_funs(Modules, []),
    Freqs = count(Funs, #{}).

whats_unique() ->
    ok.

