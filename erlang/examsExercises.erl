-module(examsExercises).
-compile(export_all).

activate({leaf, V}, _) -> 
    io:format("spawning leaf~n"),
    spawn(?MODULE, leafy, [V]);

activate({branch, L, R}, F) ->
    io:format("spawning node~n"),
    Tl = activate(L, F),
    Tr = activate(R, F),
    spawn(?MODULE, branchy, [F, Tl, Tr, none, false]).

leafy(V) ->
    receive
        {ask, P} ->
            io:format("Sending value ~w to ~p~n0", [V, P]),
            P ! {self(), V}
        end.

branchy(F, L, R, Parent, Go) ->
    receive
        {ask, P} ->
            io:format("forwarding to subtrees~n"),
            L ! {ask, self()},
            R ! {ask, self()},
            branchy(F, L, R, P, false);

        {L, V} -> 
            case Go of
                false -> branchy(F, L, R, Parent, V);
                _ -> Parent ! {self(), F(V, Go)}
            end;

        {R, V} -> 
            case Go of
                false -> branchy(F, L, R, Parent, V);
                _ -> Parent ! {self(), F(Go, V)}
            end
        end.