-module(filter).

filter(List) -> 
    [X | Y] = List,
    spawn(?MODULE, check, [X, self()]),
    filter(Y);

filter([]) ->
    receive
        {V} -> io:format(V)
    end.

check(V, Parent) -> 
    if 
        (V =:= 0) -> Parent ! V;
        true -> ok
    end.

