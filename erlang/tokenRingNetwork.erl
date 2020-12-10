%-------------------
%simple token ring network
%-------------------

-module(tokenRingNetwork).
-compile(export_all).

start_ring(N) ->
    Pids = start_ring_node(N),
    First = hd(Pids),
    First ! {init, First},
    Pids.

do_ringy_thingy() ->
    Nodes = start_ring(5),
    hd(Nodes) ! {roundtrip, "daje sto ring"},
    lists:nth(3, Nodes) ! {nextn, 10, "Daje sto limited forwarding"},
    ok.

start_ring_node(0) ->
    NodePid = spawn(?MODULE, ring_node, [last]),
    [NodePid];

start_ring_node(N) ->
    [NextPid | Rest] = start_ring_node(N - 1),
    NodePid = spawn(?MODULE, ring_node, [NextPid]),
    [NodePid , NextPid | Rest].

% startup function
ring_node(last) ->
    receive
        {init, FirstElement} ->
            io:format("First Pid received ~p~n", [FirstElement]),
            ring_node_loop(FirstElement)
        end;

ring_node(NextPid) ->
    receive
        {init, FirstElement} ->
            NextPid ! {init, FirstElement},
            io:format("First Pid received and forwarded ~p~n", [FirstElement]),
            ring_node_loop(NextPid)
    end.

% loop function (actual body of the element in the ring)
ring_node_loop(NextPid) ->
    receive
        {roundtrip, Msg} ->
            io:format("~p: starting a roundtrip with message ~s~n", [self(), Msg]),
            NextPid ! {roundtrip, self(), Msg},
            ring_node_loop(NextPid);

        {roundtrip, TargetPid, _} when TargetPid =:= self() ->
            io:format("~p: roundtrip exhausted!~n~n", [self()]),
            ring_node_loop(NextPid);
        
        {roundtrip, TargetPid, Msg} -> 
            io:format("~p: continuing the roundtrip with message ~s~n", [self(), Msg]),
            NextPid ! {roundtrip, TargetPid, Msg},
            ring_node_loop(NextPid);

        {nextn, 0, _} ->
            io:format("~p: message reached destination~n", [self()]),
            ring_node_loop(NextPid);

        {nextn, N, Msg} ->
            io:format("~p: limited forwarding of message ~s~n", [self(), Msg]),
            NextPid ! {nextn, N - 1, Msg}
    end.
