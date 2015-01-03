-module(ring).
-export([init_ringmaster/2, kill_ring/1, send_ring/3, add_ring/2]).

%
% Create N processes in a ring. Send a message round the ring M times so that
% a total of N*M messages get sent. 
%
% The lack of self() in this implementation is worrisome.
% 

node_loop(Ringmaster, NextNode) ->
    receive
        {set_ringmaster, Pid} ->
            NextNode ! {set_ringmaster, Pid}, % Propagate to all nodes.
            node_loop(Pid, NextNode);
        {set_next_node, Pid} ->
            node_loop(Ringmaster, Pid);
        {Msg, TTL} when TTL > 0 ->
            NextNode ! {Msg, TTL-1},
            node_loop(Ringmaster, NextNode);
        {Msg, 0} ->
            Ringmaster ! {ttl_expired, Msg}, % Echo back the message.
            node_loop(Ringmaster, NextNode);
        kill ->
            % io:format("His name is ~p. ", [self()]),
            NextNode ! kill
    end.

init_ring(Ringmaster, Count) ->
    FirstNode = spawn(fun() -> node_loop(Ringmaster, null) end),
    LastNode = init_ring(Ringmaster, Count-1, FirstNode),
    FirstNode ! {set_next_node, LastNode},
    FirstNode.
init_ring(Ringmaster, Count, OldNode) when Count > 0 ->
    NewNode = spawn(fun() -> node_loop(Ringmaster, OldNode) end), % Count--
    init_ring(Ringmaster, Count-1, NewNode);
init_ring(_Ringmaster, 0, OldNode) ->
    OldNode. % Last node.

ringmaster_loop(Listener, Ring) -> % Ring is just an arbitrary node.
    receive
        kill_ring ->
            Ring ! kill,
            ringmaster_loop(Listener, null);
        {set_ring, Pid} ->
            ringmaster_loop(Listener, Pid);
        get_ring ->
            Listener ! Ring,
            ringmaster_loop(Listener, Ring);
        {send_ring, Msg, TTL} ->
            Ring ! {Msg, TTL},
            ringmaster_loop(Listener, Ring);
        {ttl_expired, Msg} ->
            Listener ! {ring_msg, Msg},
            ringmaster_loop(Listener, Ring)
    end.

init_ringmaster(Listener, Ring) when is_pid(Ring) ->
    Ringmaster = spawn(fun() -> ringmaster_loop(Listener, Ring) end),
    Ringmaster;
init_ringmaster(Listener, Count) when is_integer(Count) ->
    Ring = init_ring(null, Count),
    Ringmaster = spawn(fun() -> ringmaster_loop(Listener, Ring) end),
    Ring ! {set_ringmaster, Ringmaster},
    Ringmaster.

kill_ring(Ringmaster) ->
    Ringmaster ! kill_ring.

send_ring(Ringmaster, Msg, TTL) ->
    Ringmaster ! {send_ring, Msg, TTL}.

add_ring(Ringmaster, Size) ->
    Ring = init_ring(null, Size),
    Ring ! {set_ringmaster, Ringmaster},
    % Ringmaster ! kill_ring,
    Ringmaster ! {set_ring, Ring},
    ok.
