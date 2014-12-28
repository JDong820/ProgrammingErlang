-module(hash).
-export([hash/1, assoc/2, clear/1, default/3, delete_if/2, each/2,
         each_pair/2, each_key/2, each_value/2, empty/1, flatten/2,
         test_hash/0, test_assoc/0, test_default/0, test_default_proc/0,
         test_delete/0, test_delete_if/0, test_flatten/0,
         test_all/0]).

%
% tests
%

test_all() ->
    test_hash(),
    test_assoc(),
    test_default(),
    test_default_proc(),
    test_delete(),
    test_delete_if(),
    test_flatten(),
    all_tests_passed.

test_hash() ->
    true = #{"a"=>100, "b"=>200} =:= hash(["a", 100, "b", 200]),
    true = #{"a"=>100, "b"=>200} =:= hash([["a", 100], ["b", 200]]),
    true = #{"a"=>100, "b"=>200} =:= hash(#{"a"=>100, "b"=>200}),
    hash_tests_passed.

test_assoc() ->
    H = #{"colors"  => ["red", "blue", "green"],
          "letters" => ["a", "b", "c" ]},
    ["letters", ["a", "b", "c"]] = assoc(H, "letters"),
    error = assoc(H, "foo"),
    assoc_tests_passed.

test_default() ->
    H = #{"colors"  => ["red", "blue", "green"],
          "letters" => ["a", "b", "c" ]},
    ["red", "blue", "green"] = default(H, "colors", nil),
    nil = default(H, "foo", nil),
    default_tests_passed.

test_default_proc() ->
    F = fun(K, [V|_]) -> K ++ V end,
    H = #{"colors"  => ["red", "blue", "green"],
          "letters" => ["a", "b", "c" ]},
    "colorsred" = default_proc(H, "colors", F),
    "lettersa" = default_proc(H, "letters", F),
    default_proc_tests_passed.

test_delete() ->
    H = #{"colors"  => ["red", "blue", "green"],
          "letters" => ["a", "b", "c" ]},
    true = #{"letters" => ["a", "b", "c" ]} =:= delete(H, "colors"),
    delete_tests_passed.

test_delete_if() ->
    F = fun(T) -> element(1, T) =:= "colors" end,
    H = #{"colors"  => ["red", "blue", "green"],
          "letters" => ["a", "b", "c" ]},
    true = #{"letters" => ["a", "b", "c" ]} =:= delete_if(H, F),
    delete_if_tests_passed.

test_flatten() ->
    H = #{1=>"one", 2=>[2,"two"], 3=>"three"},
    [1, "one", 2, [2, "two"], 3, "three"] = flatten(H, 1),
    [1, "one", 2, 2, "two", 3, "three"] = flatten(H, 2),
    flatten_tests_passed.

%
% helpers
% 

list_to_pairs([K|[V|T]], Result) ->
    list_to_pairs(T, [list_to_tuple([K, V])| Result]);
list_to_pairs([], Result) ->
    Result.

lists_to_tuples(L) ->
    lists:map(fun(X) -> list_to_tuple(X) end, L).

hash_list_of_list_pairs(L) -> % Hash[ [ [key, value], ... ] ] → new_hash
    maps:from_list(lists_to_tuples(L)).

hash_flat_list(L) -> % Hash[ key, value, ... ] → new_hash
    maps:from_list(list_to_pairs(L, [])).

flatten_list_one_level([], Acc) ->
    lists:reverse(Acc);
flatten_list_one_level([H|T], Acc) when is_list(H) ->
    IsString = io_lib:printable_unicode_list(H),
    if
        false =:= IsString -> flatten_list_one_level(T, lists:reverse(H) ++ Acc);
        true =:= IsString -> flatten_list_one_level(T, [H|Acc])
    end;
flatten_list_one_level([H|T], Acc) ->
    flatten_list_one_level(T, [H|Acc]).

flatten_list(L, Level) when Level > 0->
    flatten_list(flatten_list_one_level(L, []), Level-1);
flatten_list(L, 0) ->
    L.
%
% exported functions
%

% Ruby hash constructor
hash([H1|[H2|T]]) when is_list(H1) and is_list(H2) -> % Hash[ [ [key, value], ... ] ] → new_hash
    hash_list_of_list_pairs([H1|[H2|T]]);
hash(M) when is_map(M) -> % Hash[ map ] → new_hash
    M;
hash(L) -> % Hash[ key, value, ... ] → new_hash
    hash_flat_list(L).

% Ruby hash.assoc(obj)
assoc(Hash, Key) -> % assoc(obj) → an_array or nil
    Result = maps:find(Key, hash(Hash)),
    if
        error =:= Result -> error;
        is_tuple(Result) -> [Key, element(2, Result)]
    end.

clear(_) -> % ok.
    #{}.

default(Hash, Key, Default) ->
    Result = maps:find(Key, hash(Hash)),
    if
        error =:= Result -> Default;
        is_tuple(Result) -> element(2, Result)
    end.

default_proc(Hash, Key, F) ->
    Result = maps:find(Key, hash(Hash)),
    F(Key, element(2, Result)).

delete(Hash, Key) ->
    maps:remove(Key, hash(Hash)).

delete_if(H, F) ->
    L = lists:filter(fun(T) -> false =:= F(T) end, maps:to_list(hash(H))),
    maps:from_list(L).

each(H, F) ->
    lists:map(F, maps:to_list(hash(H))),
    ok.

each_pair(H, F) ->
    each(H, F),
    ok.

each_key(H, F) ->
    lists:map(F, maps:keys(hash(H))),
    ok.

each_value(H, F) ->
    Hash = hash(H),
    Get = fun(Key) -> maps:get(Key, Hash) end,
    lists:map(F, lists:map(Get, maps:keys(Hash))),
    ok.

empty(H) ->
    #{} =:= hash(H).

flatten(H, Level) when Level > 0 ->
    Hash = hash(H),
    L = lists:map(fun(T) -> tuple_to_list(T) end, maps:to_list(Hash)),
    flatten_list(L, Level);
flatten(H, 0) ->
    hash(H). 
