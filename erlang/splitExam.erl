% 1) Define a split function, which takes a list and a number n and returns a pair of lists, where the first one
% is the prefix of the given list, and the second one is the suffix of the list of length n.
% E.g. split([1,2,3,4,5], 2) is {[1,2,3],[4,5]}.
% 2) Using split of 1), define a splitmap function which takes a function f, a list L, and a value n, and splits
% L with parameter n, then launches two process to map f on each one of the two lists resulting from the
% split. The function splitmap must return a pair with the two mapped lists.

-module(splitExam).
-export([split/2]).

split(List, SuffixLength) ->
    {lists:sublist(List, (length(List) - SuffixLength)), lists:sublist(List, (length(list) - SuffixLength))}.