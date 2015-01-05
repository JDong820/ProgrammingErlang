-module(dict_count).
-export([test_dict_funs/0, count_dict_funs/0, fun_count/1]).

test_dict_funs() ->
    22 = count_dict_funs(),
    count_dict_funs_tests_passed.

count([_|T], Count) ->
    count(T, Count+1);
count([], Count) ->
    Count.

fun_count(M) -> % Returns number of functions in a module.
    [{exports, Exports}|_] = apply(M, module_info, []),
    count(Exports, 0).

count_dict_funs() ->
    fun_count(dict).
