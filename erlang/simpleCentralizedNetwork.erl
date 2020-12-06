-module(simpleCentralizedNetwork).
-compile(export_all).

client(Server, Msg) -> 
    case Msg of
        "quit" -> Server ! "quitting";
        true -> 
            io:format(Msg),
            if 
                rand:uniform() > 0.7 -> 
                    Server ! string:concat("Message from ", self()),
                    client(Server, "");
                true -> 
                    client(Server, "")
            end,
    end.