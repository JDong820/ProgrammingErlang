-module(try_test).
-export([demo1/0, demo2/0]).

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'EXIT', a};
generate_exception(5) -> error(a).

demo1() -> 
    [catcher(I) || I <- [1,2,3,4,5]].

demo2() -> 
    [{I, (catch generate_exception(I))} || I <- [1,2,3,4,5]].

catcher(N) -> 
    try generate_exception(N) of 
        Val -> {N, normal, Val}
    catch
        throw:X -> log_error({N, caught, thrown, X}),
                   io:format("Oops! Bad arugument ~w.~n", [N]);
        exit:X -> log_error({N, caught, exited, X}),
                  io:format("Oops! Thread exited on ~w.~n", [N]);
        error:X -> log_error({N, caught, error, X}),
                   io:format("Oops! Error for ~w.~n", [N])
                   
    end.

log_error(E) -> % Log the detailed error for the developer.
    FD = file:open("/tmp/erlang_test.errors", append),
    Err = lists:flatten(io_lib:format("~p~n", [E])),
    file:write(FD, Err).
    %io:put_chars(standard_error, Err).
