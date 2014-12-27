-module(math_functions).
-export([even/1, odd/1,
         filter/2,
         split/1, split2/1,
         test_even_odd/0, test_filter/0, test_all/0]).

test_all() ->
    test_even_odd(),
    test_filter(),
    test_split(),
    all_tests_passed.

test_even_odd() ->
    true = even(2),
    true = even(4),
    false = even(3),
    false = even(4.2),
    true = odd(1),
    true = odd(5),
    false = odd(4),
    false = odd(4.2),
    tests_for_even_odd_passed.

test_filter() ->
    A = lists:seq(0, 8, 2),
    A = filter(fun(X) -> math_functions:even(X) end, lists:seq(0, 8)),
    B = lists:seq(1, 8, 2),
    B = filter(fun(X) -> math_functions:odd(X) end, lists:seq(0, 8)),
    [0, 2] = filter(fun(X) -> math_functions:even(X) end, [0, 0.1, hello, 2, -1]),
    tests_for_filter_passed.

test_split() ->
    {[0, 2, 4], [1, 3, 5]} = split(lists:seq(0, 5)),
    {[0, 2, 4], [1, 3, 5]} = split2(lists:seq(0, 5)),
    % {[], [1, 3]} = split([hi, 1, no, 3]),    these two are supposed to fail.
    % {[], [1, 3]} = split2([hi, 1, no, 3]),
    tests_for_split_passed.

even(X) when is_integer(X), X rem 2 =:= 0 -> true;
even(X) -> false.

odd(X) when is_integer(X), X rem 2 =:= 1 -> true;
odd(X) -> false.

filter(F, L) ->
    [X || X <- L, F(X)].

split(L) -> % split implemened using filter, two pass.
    {filter(fun(X) -> math_functions:even(X) end, L),
     filter(fun(X) -> math_functions:odd(X) end, L)}.

split2(L) -> % split implemented using accumulators for one pass.
    split_accumulator(L, [], []).

split_accumulator([H|T], Evens, Odds) ->
    case H rem 2 of
        0 -> split_accumulator(T, [H|Evens], Odds); % Even case.
        1 -> split_accumulator(T, Evens, [H|Odds]) % Odd case.
    end;
split_accumulator([], Evens, Odds) -> {lists:reverse(Evens), lists:reverse(Odds)}.
