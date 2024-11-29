/*
a) | ?- [a | [b, c, d] ] = [a, b, c, d] 
yes
b) | ?- [a | b, c, d ] = [a, b, c, d] 
no
c) | ?- [a | [b | [c, d] ] ] = [a, b, c, d] 
yes
d) | ?- [H|T] = [pfl, lbaw, fsi, ipc] 
H = pfl,
T = [lbaw,fsi,ipc]

e) | ?- [H|T] = [lbaw, ltw] 
H = lbaw,
T = [ltw]

f) | ?- [H|T] = [leic] 
H = leic,
T = [ ]

g) | ?- [H|T] = [] 
no
h) | ?- [H|T] = [leic, [pfl, ipc, lbaw, fsi] ] 
H = leic,
T = [[pfl,ipc,lbaw,fsi]]

i) | ?- [H|T] = [leic, Two] 
H = leic,
T = [Two]

j) | ?- [Inst, feup] = [gram, LEIC] 
Inst = gram,
LEIC = feup

k) | ?- [One, Two | Tail] = [1, 2, 3, 4] 
One = 1,
Two = 2,
Tail = [3,4]

l) | ?- [One, Two | Tail] = [leic | Rest] 
One = leic,
Rest = [Two|Tail]
*/

% 2.a
% Base case: the size of an empty list is 0.
list_size([], 0).

% Recursive case: the size of the list is 1 plus the size of the tail.
list_size([_|Tail], Size) :-
    list_size(Tail, TailSize),
    Size is TailSize + 1.

% 2.b
% Base case: the sum of an empty list is 0.
list_sum([], 0).

% Recursive case: the sum is the head of the list plus the sum of the tail.
list_sum([Head|Tail], Sum) :-
    list_sum(Tail, TailSum),
    Sum is Head + TailSum.

% 2.c
% Base case: the product of an empty list is 1.
list_prod([], 1).

% Recursive case: the product is the head of the list times the product of the tail.
list_prod([Head|Tail], Prod) :-
    list_prod(Tail, TailProd),
    Prod is Head * TailProd.

% 2.d
% Base case: the inner product of two empty lists is 0.
inner_product([], [], 0).

% Recursive case: compute the product of the heads and add to the inner product of the tails.
inner_product([H1|T1], [H2|T2], Result) :-
    inner_product(T1, T2, TailResult),
    Result is H1 * H2 + TailResult.

% 2.e
% Base case: an empty list contains 0 occurrences of any element.
count(_, [], 0).

% Recursive case: if the head matches Elem, increment the count.
count(Elem, [Elem|Tail], N) :-
    count(Elem, Tail, TailCount),
    N is TailCount + 1.

% Recursive case: if the head does not match Elem, continue with the tail.
count(Elem, [_|Tail], N) :-
    count(Elem, Tail, N).

% 3.a
% Base case: the reverse of an empty list is an empty list.
invert([], []).

% Recursive case: append the head to the reversed tail.
invert([Head|Tail], Reversed) :-
    invert(Tail, ReversedTail),
    append(ReversedTail, [Head], Reversed).

% 3.b
% Base case: if the head of the list matches Elem, skip it and return the tail as the result.
del_one(Elem, [Elem|Tail], Tail).

% Recursive case: if the head does not match Elem, keep the head and process the tail.
del_one(Elem, [Head|Tail], [Head|Result]) :-
    del_one(Elem, Tail, Result).

% Edge case: if the input list is empty, the result is also an empty list.
del_one(_, [], []).

% 3.c
% Base case: the result of removing an element from an empty list is an empty list.
del_all(_, [], []).

% Recursive case: if the head matches Elem, skip it and process the tail.
del_all(Elem, [Elem|Tail], Result) :-
    del_all(Elem, Tail, Result).

% Recursive case: if the head does not match Elem, keep it and process the tail.
del_all(Elem, [Head|Tail], [Head|Result]) :-
    Elem \= Head,
    del_all(Elem, Tail, Result).

% 3.d
% Base case: if ListElems is empty, List2 is the same as List1.
del_all_list([], List1, List1).

% Recursive case: delete all occurrences of the head of ListElems from List1, then process the tail.
del_all_list([Elem|TailElems], List1, List2) :-
    del_all(Elem, List1, TempList),
    del_all_list(TailElems, TempList, List2).

% Helper predicate: del_all(+Elem, +List1, ?List2) to remove all occurrences of Elem.
del_all(_, [], []).
del_all(Elem, [Elem|Tail], Result) :-
    del_all(Elem, Tail, Result).
del_all(Elem, [Head|Tail], [Head|Result]) :-
    Elem \= Head,
    del_all(Elem, Tail, Result).

% 3.e
% Base case: an empty list has no duplicates.
del_dups([], []).

% Recursive case: if the head is not in the tail, keep it and process the tail.
del_dups([Head|Tail], [Head|Result]) :-
    \+ member(Head, Tail),
    del_dups(Tail, Result).

% Recursive case: if the head is in the tail, skip it and process the tail.
del_dups([Head|Tail], Result) :-
    member(Head, Tail),
    del_dups(Tail, Result).

% 3.f
% Base case: an empty list is a permutation of another empty list.
list_perm([], []).

% Recursive case: L2 is a permutation of L1 if we can remove an element from L2 and the rest is a permutation of the tail of L1.
list_perm([Head|Tail], L2) :-
    select(Head, L2, L2Rest),
    list_perm(Tail, L2Rest).

% 3.g
% Base case: if the amount is 0, the resulting list is empty.
replicate(0, _, []).

% Recursive case: add Elem to the list and decrement the amount.
replicate(Amount, Elem, [Elem|Rest]) :-
    Amount > 0,
    NextAmount is Amount - 1,
    replicate(NextAmount, Elem, Rest).

% 3.h
% Base case: interspersing into an empty list results in an empty list.
intersperse(_, [], []).

% Base case: a single-element list remains unchanged (no element to intersperse).
intersperse(_, [X], [X]).

% Recursive case: insert Elem between the head and the rest of the list.
intersperse(Elem, [X, Y|Tail], [X, Elem|Rest]) :-
    intersperse(Elem, [Y|Tail], Rest).

% 3.i
% Base case: when Index is 0, insert Elem at the beginning of the list.
insert_elem(0, List1, Elem, [Elem|List1]).

% Recursive case: decrement the index and insert Elem into the tail of the list.
insert_elem(Index, [Head|Tail], Elem, [Head|Result]) :-
    Index > 0,
    NextIndex is Index - 1,
    insert_elem(NextIndex, Tail, Elem, Result).

% Edge case: if List1 is empty and Index is 0, create a list with the single element.
insert_elem(0, [], Elem, [Elem]).

% 3.j
% Base case: if Index is 0, remove the first element (Head) and unify it with Elem, keeping the Tail as List2.
delete_elem(0, [Elem|Tail], Elem, Tail).

% Recursive case: decrement the index and remove the element from the tail.
delete_elem(Index, [Head|Tail], Elem, [Head|Result]) :-
    Index > 0,
    NextIndex is Index - 1,
    delete_elem(NextIndex, Tail, Elem, Result).


% Base case for insertion: add Elem at Index 0.
modify_elem(insert, 0, List1, Elem, [Elem|List1]).

% Base case for deletion: remove Elem at Index 0.
modify_elem(delete, 0, [Elem|Tail], Elem, Tail).

% Recursive case: traverse the list for both operations.
modify_elem(Operation, Index, [Head|Tail], Elem, [Head|Result]) :-
    Index > 0,
    NextIndex is Index - 1,
    modify_elem(Operation, NextIndex, Tail, Elem, Result).

% 3.k
% Base case: if Index is 0, replace the first element (Old) with New.
replace([Old|Tail], 0, Old, New, [New|Tail]).

% Recursive case: traverse the list until the desired index is reached.
replace([Head|Tail], Index, Old, New, [Head|Result]) :-
    Index > 0,
    NextIndex is Index - 1,
    replace(Tail, NextIndex, Old, New, Result).

% 4.a
% Base case: appending an empty list to L2 results in L2.
list_append([], L2, L2).

% Recursive case: take the head of L1 and append it to the result of appending the rest of L1 and L2.
list_append([Head|Tail], L2, [Head|Result]) :-
    list_append(Tail, L2, Result).

% 4.b
list_member(Elem, List) :-
    list_append(_, [Elem|_], List).

% 4.c
list_last(List, Last) :-
    list_append(_, [Last], List).

% 4.d
list_nth(N, List, Elem) :-
    length(Front, N),
    append(Front, [Elem|_], List).

% 4.e
% Base case: appending an empty list of lists results in an empty list.
list_append([], []).

% Recursive case: append the head list to the result of appending the tail lists.
list_append([Head|Tail], Result) :-
    append(Head, TailResult, Result),
    list_append(Tail, TailResult).

% 4.f
Implement list_del(+List, +Elem, ?Res), which eliminates an occurrence of Elem from List, 
unifying the result with Res, using only the append predicate twice. 

% 4.g
list_before(First, Second, List) :-
    append(_, [First|Rest], List),   % First append/3: split the list with First as the start of the second part.
    append(_, [Second|_], Rest).    % Second append/3: split Rest with Second as the start of its second part.

% 4.h
list_replace_one(X, Y, List1, List2) :-
    append(Front, [X|Back], List1),   % First append/3: Split List1 into Front, X, and Back.
    append(Front, [Y|Back], List2).  % Second append/3: Replace X with Y and combine Front and Back.

% 4.i
list_repeated(X, List) :-
    append(_, [X|Rest], List),         % First append/3: Split List into Front and Rest where X is the first occurrence.
    append(_, [X|_], Rest).           % Second append/3: Split Rest into a prefix and a suffix where X is found again.

% 4.j
list_slice(List1, Index, Size, List2) :-
    length(Prefix, Index),                % Create a list Prefix of length Index.
    append(Prefix, Rest, List1),          % Split List1 into Prefix and Rest, where Rest starts at Index.
    length(List2, Size),                  % Create a list List2 of length Size.
    append(List2, _, Rest).               % Split Rest into List2 and the remainder.

% 4.k
list_shift_rotate(List1, N, List2) :-
    length(Prefix, N),                 % Create a list Prefix of length N.
    append(Prefix, Suffix, List1),     % Split List1 into Prefix and Suffix.
    append(Suffix, Prefix, List2).     % Combine Suffix and Prefix to form List2.

% 5.a
list_to(0, []).                % Base case: if N is 0, the list is empty.
list_to(N, [N|Rest]) :-        % Recursive case: include N in the list and decrement.
    N > 0,
    N1 is N - 1,
    list_to(N1, Rest).

/*
list_to(N, List) :-
    list_to_helper(1, N, List).

list_to_helper(Current, N, []) :-
    Current > N.                % Stop when Current exceeds N.

list_to_helper(Current, N, [Current|Rest]) :-
    Current =< N,
    Next is Current + 1,        % Increment Current.
    list_to_helper(Next, N, Rest).
*/

% 5.b
list_from_to(Inf, Sup, []) :-          % Base case: if Inf > Sup, the list is empty.
    Inf > Sup.

list_from_to(Inf, Sup, [Inf|Rest]) :- % Recursive case: add Inf to the list and increment Inf.
    Inf =< Sup,
    Next is Inf + 1,
    list_from_to(Next, Sup, Rest).

% 5.c
list_from_to_step(Inf, Sup, Step, []) :-          % Base case: if Inf is out of bounds, return an empty list.
    (Step > 0, Inf > Sup) ;                      % For positive steps, Inf > Sup ends recursion.
    (Step < 0, Inf < Sup).                       % For negative steps, Inf < Sup ends recursion.

list_from_to_step(Inf, Sup, Step, [Inf|Rest]) :- % Recursive case: add Inf to the list and increment by Step.
    Step \= 0,                                  % Ensure Step is not zero to avoid infinite loops.
    ((Step > 0, Inf =< Sup) ;                   % For positive steps, continue if Inf <= Sup.
     (Step < 0, Inf >= Sup)),                   % For negative steps, continue if Inf >= Sup.
    Next is Inf + Step,                         % Calculate the next number.
    list_from_to_step(Next, Sup, Step, Rest).

% 5.d
list_from_to_step(Inf, Sup, Step, []) :-             % Base case: when out of bounds, return an empty list.
    (Step > 0, Inf > Sup) ;                         % For positive steps, Inf > Sup ends recursion.
    (Step < 0, Inf < Sup).                          % For negative steps, Inf < Sup ends recursion.

list_from_to_step(Inf, Sup, Step, [Inf|Rest]) :-    % Recursive case: ensure correct bounds and generate.
    Step \= 0,                                     % Avoid infinite loops for Step = 0.
    ((Step > 0, Inf =< Sup) ;                      % For positive steps, continue if Inf <= Sup.
     (Step < 0, Inf >= Sup)),                      % For negative steps, continue if Inf >= Sup.
    Next is Inf + Step,                            % Increment Inf by Step.
    list_from_to_step(Next, Sup, Step, Rest).

% 5.e
% Check if a number is prime.
is_prime(2). % Base case: 2 is a prime number.
is_prime(N) :-
    N > 2,
    \+ has_factor(N, 2).

% Check for factors from 2 to sqrt(N).
has_factor(N, Factor) :-
    Factor * Factor =< N,
    N mod Factor =:= 0.
has_factor(N, Factor) :-
    Factor * Factor =< N,
    NextFactor is Factor + 1,
    has_factor(N, NextFactor).

% Generate all primes up to N.
primes(N, List) :-
    N >= 2,
    list_from_to(2, N, AllNumbers),  % Generate numbers from 2 to N.
    include(is_prime, AllNumbers, List). % Filter primes using include/3.

% 5.f
% Fibonacci predicate: computes the N-th Fibonacci number.
fib(0, 0). % Base case: Fibonacci(0) = 0.
fib(1, 1). % Base case: Fibonacci(1) = 1.
fib(N, F) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fib(N1, F1),
    fib(N2, F2),
    F is F1 + F2.

% Generate all Fibonacci numbers from 0 to N.
fibs(N, List) :-
    N >= 0,
    list_from_to(0, N, Indices),  % Generate indices from 0 to N.
    maplist(fib, Indices, List).  % Apply fib/2 to each index to compute Fibonacci numbers.

% 6.a
% Run-Length Encoding using grouping.
rle(List1, List2) :-
    group(List1, Groups),             % Group consecutive elements into sublists.
    maplist(encode_group, Groups, List2). % Map each group into a (Count, Element) pair.

% Helper to encode a group into a (Count, Element) pair.
encode_group(Group, (Count, Element)) :-
    length(Group, Count),             % Count the elements in the group.
    Group = [Element|_].              % Extract the element.
    
% Group consecutive elements into sublists.
group([], []).
group([X|Xs], [[X|Ys]|Zs]) :-
    prefix(X, Xs, Ys, Rest),
    group(Rest, Zs).

% Helper to extract a prefix of consecutive identical elements.
prefix(X, [X|Xs], [X|Ys], Rest) :-
    prefix(X, Xs, Ys, Rest).
prefix(_, [Y|Ys], [], [Y|Ys]).
prefix(_, [], [], []).

% 6.b
% Base case: decoding an empty list results in an empty list.
un_rle([], []).

% Recursive case: decode the first pair (Element-Count) and concatenate it to the rest.
un_rle([Elem-Count | RestEncoded], Decoded) :-
    replicate(Elem, Count, DecodedPart),  % Generate the list for Elem repeated Count times.
    un_rle(RestEncoded, RestDecoded),    % Recursively decode the rest.
    append(DecodedPart, RestDecoded, Decoded).

% Helper predicate to generate a list of repeated elements.
replicate(_, 0, []). % Base case: 0 repetitions result in an empty list.
replicate(Elem, Count, [Elem | Rest]) :-
    Count > 0,
    NextCount is Count - 1,
    replicate(Elem, NextCount, Rest).

% 7.a
% Base case: an empty list or a single-element list is ordered.
is_ordered([]).
is_ordered([_]). 

% Recursive case: the list is ordered if the first two elements are in increasing order,
% and the tail of the list is also ordered.
is_ordered([X, Y | Rest]) :-
    X =< Y,                % Ensure the first element is less than or equal to the second.
    is_ordered([Y | Rest]). % Recursively check the rest of the list.

% 7.b
% Base case: inserting into an empty list results in a single-element list.
insert_ordered(Value, [], [Value]).

% Recursive case: if Value is less than or equal to the head, insert it before the head.
insert_ordered(Value, [Head|Tail], [Value, Head|Tail]) :-
    Value =< Head.

% Recursive case: if Value is greater than the head, recursively insert into the tail.
insert_ordered(Value, [Head|Tail], [Head|Result]) :-
    Value > Head,
    insert_ordered(Value, Tail, Result).

% 7.c
% Base case: an empty list is already sorted.
insert_sort([], []).

% Recursive case: sort the tail and insert the head into the sorted tail.
insert_sort([Head|Tail], OrderedList) :-
    insert_sort(Tail, SortedTail),        % Recursively sort the tail.
    insert_ordered(Head, SortedTail, OrderedList). % Insert the head into the sorted tail.
    
% Helper predicate: insert a value into a sorted list while maintaining order.
insert_ordered(Value, [], [Value]). % Inserting into an empty list.
insert_ordered(Value, [Head|Tail], [Value, Head|Tail]) :- % Insert before the head if Value <= Head.
    Value =< Head.
insert_ordered(Value, [Head|Tail], [Head|Result]) :- % Recursively insert into the tail if Value > Head.
    Value > Head,
    insert_ordered(Value, Tail, Result).

% 8
% Base case: the first line of Pascal's triangle is [1].
pascal(1, [[1]]).

% Recursive case: generate Pascal's triangle for N > 1.
pascal(N, Lines) :-
    N > 1,
    N1 is N - 1,
    pascal(N1, PrevLines),       % Generate the first N-1 lines.
    last(PrevLines, LastLine),  % Get the last line of the previous triangle.
    next_pascal_line(LastLine, NextLine), % Compute the next line.
    append(PrevLines, [NextLine], Lines). % Append the next line to the previous lines.

% Helper to compute the next line in Pascal's triangle.
next_pascal_line(PrevLine, [1|NextLine]) :-
    pairs_sum(PrevLine, Middle), % Compute the sums of adjacent elements.
    append(Middle, [1], NextLine). % Add 1 to the end of the line.

% Helper to compute the sums of adjacent pairs in a list.
pairs_sum([X, Y|Rest], [Sum|Sums]) :-
    Sum is X + Y,            % Sum adjacent elements.
    pairs_sum([Y|Rest], Sums). % Continue with the rest of the list.
pairs_sum(_, []).            % Base case: no more pairs.



