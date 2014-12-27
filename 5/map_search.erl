-module(map_search).
-export([map_search_pred/2, test_map_search_pred/0]).

test_map_search_pred() ->
    F1 = fun(X, Y) -> Y =:= 1 end,
    {a, 1} = map_search_pred(#{a => 1, b => 2, c => 1}, F1),
    {a, 1} = map_search_pred(#{b => 2, a => 1, c => 1}, F1),
    {a, 1} = map_search_pred(#{b => 2, a => 3, a => 1}, F1),
    map_search_pred_tests_passed.

map_search_pred(Map, Pred) ->
    list_search_pred(maps:to_list(Map), Pred).

list_search_pred([H|T], Pred) ->
    {K, V} = H,
    Eval = Pred(K, V),
    if
        Eval -> {K, V};
        true -> list_search_pred(T, Pred)
    end.
