-module(fixed_point).

applier(S) -> 
    receive
        {Func, Sender} ->
            New = Func(S),
            if
                (New =:= S) -> Sender ! S, ok;
                true -> Sender ! notReached, applier(New)
            end
    end. 


% fix(Func, Start) ->
%     spawn(?MODULE, applier, [0]),
