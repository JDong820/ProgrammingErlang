-module(name_analysis).
-export([whats_popular/0, whats_unique/0, whats_noisy/0]).
-import(dict_count, [fun_count/1]).

max_freq([{Function, Count}|T], {MaxF, MaxC}) ->
    if
        Count > MaxC -> max_freq(T, {Function, Count});
        true -> max_freq(T, {MaxF, MaxC})
    end;
max_freq([], {MaxF, _MaxC}) ->
    MaxF.

count([{_Module, Function}|T], Results) -> % Count Function frequency.
    Oldcount = maps:find(Function, Results),
    if
        is_integer(Oldcount) ->
            count(T, orddict:update_counter(Function, 1, Results));
        true ->
            count(T, orddict:append(Function, 1, Results))
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
    Freqs = orddict:to_list(count(Funs, orddict:new())),
    max_freq(Freqs, {null, 0}).

whats_unique() ->
    Modules = lists:map(fun(X) -> element(1, X) end, code:all_loaded()),
    Funs = enumerate_funs(Modules, []),
    Freqs = orddict:to_list(count(Funs, orddict:new())),
    lists:filter(fun({Fun, 1}) -> Fun end, Freqs).
