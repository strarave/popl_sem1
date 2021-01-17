-module(parallel_find).

search(Master, L, V) ->
    case lists:member(V, L) of
        true -> Master ! {found, L};
        false -> Master ! {ko}
    end.

spawner(Master, L, V) ->
    [H | T] = L,
    case T of
        [] -> spawn(?MODULE, search, [Master, L, V]);
        true -> spawn(?MODULE, search, [Master, L, V]), spawner(Master, T, V)
    end.

waiter(N) -> 
    receive
        {ko} -> 
            N = N - 1,
            if 
                N == 0 -> io:format("not found~n");
                true -> waiter(N)
            end;
        {found, L} ->
            io:format("found!"),
            L
    end.


parFind(L, V) ->
    spawner(self(), L, V),
    waiter(length(L)).