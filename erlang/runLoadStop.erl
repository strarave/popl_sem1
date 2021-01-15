-module(runLoadStop).
% -compile(export_all).

% main() -> 
%     spawn(?MODULE, behave, [self(), [inc]]).

% behave(Creator, [Fs]) -> 
%     receive
%         {Pid, load, F} -> 
%             if 
%                 Pid == Creator -> behave(Creator, [F | Fs]);
%                 true -> error
%             end;
%         {Pid, run, D} ->
%             if
%                 Pid == Creator -> 
%                     foral
%     end.

% inc(x) ->
%     x + 1.