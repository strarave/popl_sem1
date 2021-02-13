-module(appicative)

apply(FunctionList, DataList) ->
    [First| Other] = FunctionList,
    if 
        lists:length(Other) == 0 -> spawn(?MODULE, mapper, [First, DataList, last, self()]), wait([])
        true -> spawn(?MODULE, mapper, [First, DataList, mid, self()]), apply(Other, DataList);
    end.

wait(ResultList) ->
    receive
        {Values, end} -> ResultList ++ Values, ok;
        {Values, mid} -> wait(ResultList ++ Values)
    end.

mapper(Func, List, mid, Parent) ->
    Parent ! {map(Func, List), mid};

mapper(Func, List, last, Parent) ->
    Parent ! {map(Func, List), end}.

map(_, []) -> [];
map(F, [X |Xs]) -> [F(X) | map(F, Xs)].

