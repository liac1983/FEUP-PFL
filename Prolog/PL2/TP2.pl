% 1.a 

r(a,b).
r(a,d).
r(b,a).
r(a,c).

s(b,c).
s(b,d).
s(c,c).
s(d,e).

% 2.a

pairs(X,Y) :- d(X), q(Y).
pairs(X,X) :- u(X).
u(1).
d(2).
d(4).
p(4).
q(16).

% 3.c

a(a1,1).
a(A2,2).
a(a3,N).

b(1,b1).
b(2,B2).
b(N,b3).

c(X,Y) :- a(X,Z), b(Z,Y).

d(X,Y) :- a(X,Z), b(Y,Z).
d(X,Y) :- a(Z,X), b(Z,Y).

% 4.a

%factorial(+N, -F)
factorial(0,1).
factorial(1,1).
factorial(N,F) :- 
    N > 1,
    N1 is N-1,
    factorial(N1,F1),
    F is F1*N.

% 4.b

%sum_rec(+N,-Sum)
sum_rec(0,0).
sum_rec(N,Sum) :-
    N > 0,
    N1 is N-1,
    sum_rec(N1,Sum1),
    Sum is Sum1 + N.

% 4.c

% pow_rec(+N,+Y,-P)
pow_rec(_, 0, 1).  % X^0 is always 1

pow_rec(X, Y, P) :-
    Y > 0,           % Ensure Y is a positive integer
    Y1 is Y - 1,     % Decrease Y by 1
    pow_rec(X, Y1, P1),  % Recursive call with Y1
    P is X * P1.     % Calculate X^Y by multiplying X with X^(Y-1)


% 4.d 

% square_rec(+N,-S)

square_rec(N, S) :-
    square_helper(N, N, S).

square_helper(0, _, 0).  % The square of 0 is 0

square_helper(N, M, S) :-
    N > 0,
    N1 is N - 1,
    square_helper(N1, M, S1),
    S is S1 + M.


% 4.e 

% fibonacci(+N,-F)

fibonacci(0, 0).  % The Fibonacci number at position 0 is 0
fibonacci(1, 1).  % The Fibonacci number at position 1 is 1

fibonacci(N, F) :-
    N > 1,          % Ensure N is greater than 1
    N1 is N - 1,    % Calculate N-1
    N2 is N - 2,    % Calculate N-2
    fibonacci(N1, F1),  % Recursive call for N-1
    fibonacci(N2, F2),  % Recursive call for N-2
    F is F1 + F2.       % Fibonacci(N) = Fibonacci(N-1) + Fibonacci(N-2)

% 4.F

%collatz(+N,-S)
collatz(1, 0).  % Base case: N is already 1, no steps required

collatz(2, 1).  % Special case: When N is 2, it takes 1 step to reach 1.

collatz(N, S) :-
    N > 2,
    N mod 2 =:= 0,  % N is even
    N1 is N // 2,  % Use integer division
    collatz(N1, S1),
    S is S1 + 1.   % Increment the step count

collatz(N, S) :-
    N > 1,
    N mod 2 =:= 1,  % N is odd
    N1 is 3 * N + 1,
    collatz(N1, S1),
    S is S1 + 1.   % Increment the step count


% 4.g 

% is_prime(+X)
is_prime(1) :- !.
is_prime(2) :- !.
is_prime(3) :- !.
is_prime(X) :-
    X > 3,
    X mod 2 =\= 0,  % Check if X is odd
    not_divisible(X, 3).

not_divisible(X, Divisor) :-
    Divisor * Divisor > X,  % If Divisor squared is greater than X, X is prime
    !.
not_divisible(X, Divisor) :-
    X mod Divisor =:= 0,
    !,
    fail.
not_divisible(X, Divisor) :-
    NextDivisor is Divisor + 2,  % Check odd divisors only
    not_divisible(X, NextDivisor).

