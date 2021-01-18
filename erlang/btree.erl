-module(btree).
-compile(export_all).

branchy(Fun, L, R) -> 
    receive
        {ask, Pid} ->
            Val = 0, Var = 0,
            L ! {ask, self()},

            receive
                {L, Vl} -> Val = Vl 
            end,
            
            R ! {ask, self()},
            receive
                {R, Vr} -> Var = Vr 
            end,
            
            Pid ! {self(), Fun(Val, Var)},
            branchy(Fun, L, R)
    end.

leafy(V) ->
    receive
        {ask, Pid} -> 
            Pid ! {self(), V},
            leafy(V)
    end. 

activate(BTree, Fun) -> 
    case BTree of
        {leaf, V} -> spawn(?MODULE, leafy, [V]);

        {branch, L, R} -> 
            Left = activate(L, Fun), 
            Right = activate(R, Fun),
            spawn(?MODULE, branchy, [Fun, Left, Right]) 
    end.