% Define a function for a proxy used to avoid to send PIDs; the proxy must react to the following messages:
% - {remember, PID, Name}: associate the value Name with PID.
% - {question, Name, Data}: send a question message containing Data to the PID corresponding to the value Name (e.g. an atom), like in PID ! {question, Data}
% - {answer, Name, Data}: send an answer message containing Data to the PID corresponding to the value Name (e.g. an atom), like in PID ! {answer, Data}Immersive Reader

% AddressMap is a hashmap that binds Names to Pids
% I suppose an empty one is passed as parameter on spawn
proxy(AddressMap) ->
    receive
        {remember, Pid, Name} ->
            AddressMap#{Name := Pid}, % adding the value
            Pid ! {ok};
        {question, Name, Data} ->
            {Name := P} = AddressMap, % retrieving the address
            P ! {question, Data}; % sending the data
        {answer, Name, Data} ->
            {Name := P} = AddressMap,
            P ! {answer, Data}
    end.