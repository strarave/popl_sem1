% exam theme, implementing the pyton Range function with erlang's processes

-module(rangeExam).
-compile(export_all).

range(Start, End, Step) ->
    spawn(?MODULE, range_process, [Start, End, Step]).

range_process(Start, End, Step) ->
    receive
        {_} -> 
            io:format("~d~n", Start),
            Start = Start + Step,
            if 
                Start == End ->
                    end_range;
                true -> range_process(Start, End, Step)
            end
    end.

next(RangePid) -> 
    RangePid ! val. 