% Practical Class 3
% Lists

% 1. Lists

% a | ?- [a | [b, c, d] ] = [a, b, c, d] yes
% b | ?- [a | b, c, d ] = [a, b, c, d] syntax error
% c | ?- [a | [b | [c, d] ] ] = [a, b, c, d] yes
% d | ?- [H|T] = [pfl, lbaw, fsi, ipc] no
% e | ?- [H|T] = [lbaw, ltw] no
% f | ?- [H|T] = [leic] no
% g | ?- [H|T] = [] no
% h | ?- [H|T] = [leic, [pfl, ipc, lbaw, fsi] ] no
% i | ?- [H|T] = [leic, Two] no
% j | ?- [Inst, feup] = [gram, LEIC] no
% k | ?- [One, Two | Tail] = [1, 2, 3, 4] no
% l | ?- [One, Two | Tail] = [leic | Rest] no

% 2. Recursion over Lists

% a 

list_size([], 0).           % Base case: an empty list has size 0
list_size([_ | Tail], Size) :-  % Recursive case: remove the head of the list
    list_size(Tail, TailSize),  % Recursively calculate the size of the tail
    Size is TailSize + 1.      % Increment the size by 1

% b

list_sum([], 0).           % Base case: the sum of an empty list is 0
list_sum([X | Tail], Sum) :-  % Recursive case: sum the head with the sum of the tail
    list_sum(Tail, TailSum),  % Recursively calculate the sum of the tail
    Sum is X + TailSum.      % Sum the head value with the sum of the tail

% c

list_prod([], 1).            % Base case: the product of an empty list is 1
list_prod([X | Tail], Prod) :-  % Recursive case: multiply the head with the product of the tail
    list_prod(Tail, TailProd),  % Recursively calculate the product of the tail
    Prod is X * TailProd.      % Multiply the head value with the product of the tail


% d

inner_product([], [], 0).  % Base case: inner product of two empty lists is 0
inner_product([X1 | Tail1], [X2 | Tail2], Result) :-
    inner_product(Tail1, Tail2, TailProduct),  % Recursively calculate the inner product of the tails
    Result is X1 * X2 + TailProduct.           % Calculate the inner product of the heads and add it to the tail product


% e 

count(_, [], 0).          % Base case: count of an element in an empty list is 0
count(Elem, [Elem | Tail], N) :-
    count(Elem, Tail, TailCount),  % Recursively count in the tail
    N is TailCount + 1.            % Increment the count by 1 when Elem is found
count(Elem, [_ | Tail], N) :-
    count(Elem, Tail, N).          % Continue searching in the tail without incrementing the count


% 3. List Manipulation

% a 

invert([], []).                % Base case: inverting an empty list results in an empty list
invert([X | Tail], Inverted) :-
    invert(Tail, TailInverted),  % Recursively invert the tail
    append(TailInverted, [X], Inverted). % Append the head to the inverted tail to get the inverted list

% b 

del_one(_, [], []).             % Base case: deleting from an empty list results in an empty list
del_one(Elem, [Elem | Tail], Tail).  % If Elem is the head, skip it
del_one(Elem, [X | Tail], [X | Rest]) :-  % If Elem is not the head, keep it in the result
    del_one(Elem, Tail, Rest).            % Recursively search for Elem in the tail

% c 

del_all(_, [], []).  % Base case: deleting from an empty list results in an empty list
del_all(Elem, [Elem | Tail], Result) :-  % If Elem is the head, skip it and continue searching
    del_all(Elem, Tail, Result).
del_all(Elem, [X | Tail], [X | Rest]) :-  % If Elem is not the head, keep it in the result
    Elem \= X,                           % Ensure Elem is not equal to X
    del_all(Elem, Tail, Rest).           % Recursively search for Elem in the tail

% d 

del_all_list([], List, List).  % Base case: nothing to delete, return the original list
del_all_list([Elem | RestElems], List, Result) :-
    del_all(Elem, List, TempList),  % Delete all occurrences of Elem from List
    del_all_list(RestElems, TempList, Result).  % Recursively delete the next element in RestElems

% e 

del_dups([], []).  % Base case: an empty list remains empty
del_dups([X | Rest], Result) :-
    member(X, Rest),  % Check if X is a member of the remaining list
    !,               % Cut to avoid backtracking and skip X
    del_dups(Rest, Result).
del_dups([X | Rest], [X | Result]) :-  % X is not repeated, keep it
    del_dups(Rest, Result).

% f 
list_perm(L1, L2) :-
    permutation(L1, L2),       % L2 is a permutation of L1
    same_elements(L1, L2).     % L1 and L2 have the same elements

% Helper predicate to check if two lists have the same elements
same_elements([], []).
same_elements([X | Rest], L2) :-
    select(X, L2, RestL2),     % Remove X from L2, resulting in RestL2
    same_elements(Rest, RestL2).

% g 
 
replicate(0, _, []).
replicate(Amount, Elem, [Elem | Rest]) :-
    Amount > 0,
    NewAmount is Amount - 1,
    replicate(NewAmount, Elem, Rest).


% h 

intersperse(_, [], []).  % Base case: interspersing with an empty list results in an empty list
intersperse(_, [X], [X]).  % Base case: interspersing with a single element list results in the same list
intersperse(Elem, [X | Rest], [X, Elem | InterspersedRest]) :-
    intersperse(Elem, Rest, InterspersedRest).

% i 

insert_elem(Index, List1, Elem, List2) :-
    split(Index, List1, Prefix, Suffix),  % Split List1 into Prefix and Suffix at the given Index
    append(Prefix, [Elem | Suffix], List2).  % Append Elem between Prefix and Suffix to create List2

% Helper predicate to split a list into a prefix and a suffix at the specified index
split(0, List, [], List).  % When Index is 0, the prefix is an empty list, and the suffix is the original list
split(Index, [X | Rest], [X | Prefix], Suffix) :-
    Index > 0,
    NewIndex is Index - 1,
    split(NewIndex, Rest, Prefix, Suffix).

% j 
delete_elem(Index, List1, Elem, List2) :-
    split(Index, List1, Prefix, [Elem | Suffix]),  % Split List1 into Prefix, Elem, and Suffix
    append(Prefix, Suffix, List2).  % Append Prefix and Suffix to create List2

% Helper predicate to split a list into a prefix and a suffix at the specified index
split(0, [X | Rest], [], X, Rest).  % When Index is 0, X is the head, and the rest is the suffix
split(Index, [X | Rest], [X | Prefix], Elem, Suffix) :-
    Index > 0,
    NewIndex is Index - 1,
    split(NewIndex, Rest, Prefix, Elem, Suffix).

% k 
replace(List1, Index, Old, New, List2) :-
    length(Prefix, Index),          % Create a prefix of length Index
    append(Prefix, [Old | Suffix], List1),  % Split List1 into Prefix, Old, and Suffix
    append(Prefix, [New | Suffix], List2).  % Replace Old with New to create List2


% 4 Append, The Powerful

% a 
list_append(L1, L2, L3) :-
    append(L1, L2, L3).

% b 
list_member(Elem, List) :-
    append(_, [Elem | _], List).

% c 
list_last(List, Last) :-
    append(_, [Last], List).

% d 
list_nth(N, List, Elem) :-
    length(Prefix, N),    % Create a prefix list of length N
    append(Prefix, [Elem | _], List).

% e 
list_append(ListOfLists, List) :-
    append(ListOfLists, List).

% f 
list_del(List, Elem, Res) :-
    append(Prefix, [Elem | Suffix], List),  % Split List into Prefix, Elem, and Suffix
    append(Prefix, Suffix, Res).  % Append Prefix and Suffix to create Res

% g 
list_before(First, Second, List) :-
    append(_, [First | Rest], List),  % Split List into a prefix and Rest with First
    append(_, [Second | _], Rest).    % Split Rest into a prefix with Second

% h 
list_replace_one(X, Y, List1, List2) :-
    append(Prefix, [X | Rest], List1),  % Split List1 into Prefix, X, and Rest
    append(Prefix, [Y | Rest], List2).  % Replace X with Y to create List2

% i 
list_repeated(X, List) :-
    append(_, [X | Rest], List),  % Split List into a prefix and Rest with the first occurrence of X
    append(_, [X | _], Rest).    % Split Rest into a prefix and a second occurrence of X

% j 
list_slice(List1, Index, Size, List2) :-
    length(Prefix, Index),            % Create a prefix of length Index
    append(Prefix, Slice, List1),     % Split List1 into Prefix and Slice
    length(Slice, Size),              % Ensure Slice has the desired Size
    append(Slice, _, List2).          % Append Slice to create List2

% k 
list_shift_rotate(List1, N, List2) :-
    length(Prefix, N),             % Create a prefix of length N
    append(Prefix, Suffix, List1), % Split List1 into Prefix and Suffix
    append(Suffix, Prefix, List2). % Append Suffix and Prefix to create List2

% 5. Lists of Numbers

% a 
list_to(N, List) :-
    list_to_helper(1, N, List).

list_to_helper(Current, N, [Current | Rest]) :-
    Current =< N,
    Next is Current + 1,
    list_to_helper(Next, N, Rest).
list_to_helper(N, N, []).

% b 
list_from_to(Inf, Sup, List) :-
    list_from_to_helper(Inf, Sup, [], List).

list_from_to_helper(Inf, Sup, Acc, [Inf | Rest]) :-
    Inf =< Sup,
    Next is Inf + 1,
    list_from_to_helper(Next, Sup, [Inf | Acc], Rest).
list_from_to_helper(Sup, Sup, Acc, Acc).

% c 
list_from_to_step(Inf, Sup, Step, List) :-
    list_from_to_step_helper(Inf, Sup, Step, [], List).

list_from_to_step_helper(Inf, Sup, Step, Acc, [Inf | Rest]) :-
    Inf =< Sup,
    Next is Inf + Step,
    list_from_to_step_helper(Next, Sup, Step, [Inf | Acc], Rest).
list_from_to_step_helper(Sup, Sup, _, Acc, Acc).

% d 
% For list_from_to/3:

list_from_to(Inf, Sup, List) :-
    (Inf =< Sup ->
        list_from_to_helper(Inf, Sup, [], List)
    ;
        list_from_to_helper(Sup, Inf, [], RevList),
        reverse(RevList, List)
    ).

list_from_to_helper(Inf, Sup, Acc, [Inf | Rest]) :-
    Inf =< Sup,
    Next is Inf + 1,
    list_from_to_helper(Next, Sup, [Inf | Acc], Rest).
list_from_to_helper(Sup, Sup, Acc, Acc).


% For list_from_to_step/4:

list_from_to_step(Inf, Sup, Step, List) :-
    (Inf =< Sup ->
        list_from_to_step_helper(Inf, Sup, Step, [], List)
    ;
        list_from_to_step_helper(Sup, Inf, Step, [], RevList),
        reverse(RevList, List)
    ).

list_from_to_step_helper(Inf, Sup, Step, Acc, [Inf | Rest]) :-
    Inf =< Sup,
    Next is Inf + Step,
    list_from_to_step_helper(Next, Sup, Step, [Inf | Acc], Rest).
list_from_to_step_helper(Sup, Sup, _, Acc, Acc).


% e 
% Define an isPrime predicate (e.g., from a previous exercise)
isPrime(2).
isPrime(3).
isPrime(P) :-
    integer(P),
    P > 3,
    P mod 2 =\= 0,
    \+ has_factor(P, 3).

% Helper predicate to check if a number has a factor up to Sqrt
has_factor(N, Factor) :-
    Factor * Factor =< N,
    N mod Factor =:= 0.
has_factor(N, Factor) :-
    Factor * Factor =< N,
    NextFactor is Factor + 2,
    has_factor(N, NextFactor).

% Main predicate to generate a list of prime numbers up to N
primes(N, List) :-
    N >= 2,
    include(isPrime, [2 | list(3, N, 2)], List).

% f 
% Define a predicate to calculate the Fibonacci numbers
fibonacci(0, 0).
fibonacci(1, 1).
fibonacci(N, Fib) :-
    N > 1,
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, Fib1),
    fibonacci(N2, Fib2),
    Fib is Fib1 + Fib2.

% Main predicate to generate a list of Fibonacci numbers of order 0 to N
fibs(N, List) :-
    N >= 0,
    numlist(0, N, Indices),
    maplist(fibonacci, Indices, List).


% 6. Run-Length Encding

:- use_module(library(lists)).

% Main predicate for run-length encoding
rle(List1, List2) :-
    group(List1, List2).
