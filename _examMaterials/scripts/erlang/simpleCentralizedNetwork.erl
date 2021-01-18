-module(simpleCentralizedNetwork).
-compile(export_all).

%-------------------------
% simple echo process
%-------------------------

go() -> % main code
    Pid2 = spawn(?MODULE, loop, []), % spawn( moduleName, functionAtom, listOfParameters )
    Pid2 ! {self(), "hello"},
    receive 
        {Pid2, Msg} -> io:format("P1 ~w~n", [Msg])    
    end,
    Pid2 ! quit.

loop() ->
    receive 
        {From, Msg} -> 
            From ! {self(), Msg},
            loop();
        quit -> true
    end.

srv() -> 
    io:format("[SERVER] Spawning client~n"),
    Client = spawn(?MODULE, client, [loop]),
    Client ! {self(), ""},

    receive
        {Client, spawn} ->
            io:format("[SERVER] Received spawn request~n"), 
            srv();
        {Client, selfquit} ->
            io:format("[SERVER] Received suicide note from client~n"), 
            true
    end,
    srv().

client(loop) -> 
    receive
        {Sender, _} -> 
            timer:sleep(1000),
            G = rand:uniform(),
            if
                G > 0.5 -> 
                    io:format("[CLIENT] Spawn new client~n"),
                    Sender ! {self(), spawn},
                    client(loop);
                true ->
                    io:format("[CLIENT] Ending the client~n"),
                    Sender ! {self(), selfquit}
            end
    end.
