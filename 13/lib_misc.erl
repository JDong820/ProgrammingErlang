-module(lib_misc).
-export([on_exit/2, my_spawn/3, my_spawn2/3, my_spawn/4, monitor_beacon/1,
         spawn_an_beacon/1, monitor_multiple/2, monitor_multiple_strict/2]).


%
% No tests :(
% Everything is broken, probably.
%


%
% helpers
%

loop() ->
    receive
    after 5000 ->
              io:format("I'm still running.~n"),
              loop()
    end.

keep_alive(Pid, Fun) -> % Quoted from the book.
    on_exit(Pid, fun(_Why) -> keep_alive(spawn(Fun), Fun) end).

link_multiple(Count, WorkerFun) ->
    Pids = [spawn_link(fun() -> WorkerFun() end) || _ <- lists:seq(1, Count)],
    [self() | Pids].

%
% exported functions
%

on_exit(Pid, F) -> % Quoted from the book.
    spawn(fun() ->
                  Ref = monitor(process, Pid),
                  receive
                      {'DOWN', Ref, process, Pid, Why} ->
                        F(Why)
                  end
          end).

my_spawn(M, F, A) -> % Exercise 1.

    {Pid, Ref} = spawn_monitor(M, F, A),

    statistics(runtime), 
    statistics(wall_clock),

    receive
        {'DOWN', Ref, process, Pid, Why} ->
            {_, Runtime} = statistics(runtime),
            {_, Realtime} = statistics(wall_clock),
            io:format("~p died: ~s~n", [Pid, Why]),
            Stats = [Runtime * 1000, Realtime * 1000],
            io:format("Runtime: ~ps; Realtime: ~ps.~n", Stats)
    end.

my_spawn2(M, F, A) -> % Exercise 2.
    statistics(runtime), 
    statistics(wall_clock),
    Pid = spawn(M, F, A),
    on_exit(Pid, fun(Why) ->
            {_, Runtime} = statistics(runtime),
            {_, Realtime} = statistics(wall_clock),
            io:format("~p died: ~s~n", [Pid, Why]),
            Stats = [Runtime * 1000, Realtime * 1000],
            io:format("Runtime: ~ps; Realtime: ~ps.~n", Stats) end
    ).

my_spawn(M, F, A, Time) -> % Exercise 3.
    {Pid, _Ref} = spawn_monitor(M, F, A),

    receive
    after Time ->
              exit(Pid, 'time_out')
    end.

spawn_an_beacon(Name) ->
    Pid = spawn(fun() -> loop() end),
    register(Name, Pid),
    Pid.

monitor_beacon(Name) -> % Exercise 4.
    try
        Ref = erlang:monitor(process, Name),
        receive
            {'DOWN', Ref, process, _Pid, _Why} ->
                spawn_an_beacon(Name),
                monitor_beacon(Name) % Tail-optimization SHOULD apply.
        end
    catch
        _:_ ->
            spawn_an_beacon(Name),
            monitor_beacon(Name)
    end.

monitor_multiple(Count, WorkerFun) -> % Exercise 5.
    Pids = [spawn(WorkerFun) || _ <- lists:seq(1, Count)],
    [keep_alive(Pid, WorkerFun) || Pid <- Pids].


monitor_multiple_strict(Count, WorkerFun) -> % Exercise 6.
    Hub = spawn(fun() -> link_multiple(Count, WorkerFun) end),
    keep_alive(Hub, fun() -> link_multiple(Count, WorkerFun) end).
