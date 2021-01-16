-module(listProcess).
-compile(export_all).

create_pipe([N | S], start) ->
    P1 = spawn(?MODULE, behave, [N, self()]),
    register(N, P1),
    create_pipe(S, P1);

create_pipe([N | S], Pid) -> 
    NewPid = spawn(?MODULE, behave, [N, Pid]),
    register(N, NewPid),
    create_pipe(S, NewPid);

create_pipe([], _) -> ok.

behave(Name, NextPid) -> 
    receive
        {kill} -> ok;
        {Msg} ->
            io:format("[~s]: ~s~n", [Name, Msg]),
            NextPid ! Msg,
            behave(name, NextPid)
    end.