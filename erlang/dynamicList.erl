-module(dynamicList).
-compile(export_all).


elem(Value) ->
    receive
        {get, Pid} -> Pid ! Value, elem(Value);
        {set, NewValue} -> elem(NewValue);
        {apply, Func} -> elem(Func(Value))
    end.

create_dlist(N) ->
    L = [],
    create_dlist_loop(N, L),
    L.    

create_dlist_loop(N, List) ->
    lst:append(List, spawn(?MODULE, elem, [0])),
    create_dlist_loop(N-1, List);

create_dlist_loop(0, _) -> ok.

dlist_to_list(ListOfPids, InitialList) ->
    lst:append(InitialList, lst:hd(ListOfPids) ! get),
    dlist_to_list(lst:tl(ListOfPids), InitialList),
    InitialList.

dynamicMap(List, Func) -> 
    [H | T] = List,
    H ! {apply, Func},
    dynamicMap(T, Func);

dynamicMap([], _) -> ok.