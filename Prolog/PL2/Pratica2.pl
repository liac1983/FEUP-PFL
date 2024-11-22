% 1

r(a, b). 
r(a, d). 
r(b, a). 
r(a, c). 
s(b, c). 
s(b, d). 
s(c, c). 
s(d, e). 

% 1.a
% X = a, Y = b e Z = c
% Y = c e X = a
% X = a e Y = c

% 1.b) trace.

% 2
pairs(X, Y):- d(X), q(Y). 
pairs(X, X):- u(X). 
u(1). 
d(2). 
d(4). 
q(4). 
q(16). 

% 2.a) 2,4 2,16 4,4 4,16

% 3
a(a1, 1). 
a(A2, 2). 
a(a3, N). 
b(1, b1). 
b(2, B2). 
b(N, b3). 
c(X, Y):- a(X, Z), b(Z, Y). 
d(X, Y):- a(X, Z), b(Y, Z). 
d(X, Y):- a(Z, X), b(Z, Y). 

% 3.c
% A = a3
% A=2
% A = a1
% A = a1,

/* B = b1 ? ;
A = a1,
B = b3 ? ;
true ? ;
B = b3 ? ;
A = a3,
B = b1 ? ;
A = a3 ? ;
A = a3,
B = b3 ? ; */

% 4.a
factorial(0,1).

factorial(N,F):-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.


% 4.b

sum_rec(0,0).

sum_rec(N, Sum):-
    N > 0,
    N1 is N - 1,
    sum_rec(N1, Sum1),
    Sum is N + Sum1.

% 4.c
pow_rec(_, 0,1).

pow_rec(X,Y,P):-
    Y > 0,
    Y1 is Y-1,
    pow_rec(X,Y1,P1),
    P is X * P1.

% 4.d
square_rec(N,S):-
    N >= 0,
    square_aux(N, 0, S).

square_aux(0,Acc,Acc).

square_aux(N, Acc,S):-
    N > 0,
    NewAcc is Acc + N + N -1,
    N1 is N - 1,
    square_aux(N1, NewAcc,S).

% 4.e
fibonacci(0,0).
fibonacci(1,1).

fibonacci(N,F):-
    N > 1,
    N1 is N -1,
    N2 is N- 2,
    fibonacci(N1, F1),
    fibonacci(N2,F2),
    F is F1 + F2.


% 4.f
% Base case: If N is 1, no steps are needed.
collatz(1, 0).

% Recursive case for even N: Next value is N / 2.
collatz(N, S) :-
    N > 1,                     % Ensure N is greater than 1
    0 is N mod 2,              % Check if N is even
    N1 is N // 2,              % Compute N / 2
    collatz(N1, S1),           % Recursively compute steps for N1
    S is S1 + 1.               % Increment the step count

% Recursive case for odd N: Next value is 3N + 1.
collatz(N, S) :-
    N > 1,                     % Ensure N is greater than 1
    1 is N mod 2,              % Check if N is odd
    N1 is 3 * N + 1,           % Compute 3N + 1
    collatz(N1, S1),           % Recursively compute steps for N1
    S is S1 + 1.               % Increment the step count


% 4.g
% Base case: 2 is a prime number.
is_prime(2).

% Recursive case: X is prime if it is greater than 2 and has no divisors other than 1 and itself.
is_prime(X) :-
    X > 2,
    \+ has_divisor(X, 2).

% Helper predicate: Check if X has a divisor starting from Current.
has_divisor(X, Current) :-
    Current * Current =< X,       % Only check divisors up to the square root of X
    X mod Current =:= 0.          % X is divisible by Current
has_divisor(X, Current) :-
    Current * Current =< X,       % Continue checking higher numbers
    Next is Current + 1,          % Increment Current
    has_divisor(X, Next).

% 5.a
% Main predicate for factorial with an accumulator.
factorial(N, F) :-
    factorial_acc(N, 1, F).

% Base case: When N is 0, the factorial is the accumulator.
factorial_acc(0, Acc, Acc).

% Recursive case: Multiply Acc by N and decrement N.
factorial_acc(N, Acc, F) :-
    N > 0,
    NewAcc is Acc * N,
    N1 is N - 1,
    factorial_acc(N1, NewAcc, F).

% Main predicate for sum_rec with an accumulator.
sum_rec(N, Sum) :-
    sum_rec_acc(N, 0, Sum).

% Base case: When N is 0, the sum is the accumulator.
sum_rec_acc(0, Acc, Acc).

% Recursive case: Add N to the accumulator and decrement N.
sum_rec_acc(N, Acc, Sum) :-
    N > 0,
    NewAcc is Acc + N,
    N1 is N - 1,
    sum_rec_acc(N1, NewAcc, Sum).


% Main predicate for pow_rec with an accumulator.
pow_rec(X, Y, P) :-
    pow_rec_acc(X, Y, 1, P).

% Base case: When Y is 0, the power is the accumulator.
pow_rec_acc(_, 0, Acc, Acc).

% Recursive case: Multiply Acc by X and decrement Y.
pow_rec_acc(X, Y, Acc, P) :-
    Y > 0,
    NewAcc is Acc * X,
    Y1 is Y - 1,
    pow_rec_acc(X, Y1, NewAcc, P).


% Main predicate for square_rec with an accumulator.
square_rec(N, S) :-
    square_rec_acc(N, 0, S).

% Base case: When N is 0, the square is the accumulator.
square_rec_acc(0, Acc, Acc).

% Recursive case: Add (2 * N - 1) to the accumulator and decrement N.
square_rec_acc(N, Acc, S) :-
    N > 0,
    NewAcc is Acc + (2 * N - 1),
    N1 is N - 1,
    square_rec_acc(N1, NewAcc, S).

% Main predicate for fibonacci with two accumulators.
fibonacci(N, F) :-
    fibonacci_acc(N, 0, 1, F).

% Base case: When N is 0, the Fibonacci number is Acc1.
fibonacci_acc(0, Acc1, _, Acc1).

% Recursive case: Shift the accumulators and decrement N.
fibonacci_acc(N, Acc1, Acc2, F) :-
    N > 0,
    NewAcc is Acc1 + Acc2,
    N1 is N - 1,
    fibonacci_acc(N1, Acc2, NewAcc, F).


% 6
gcd(X,0,X):-
    X > 0.

gcd(X,Y,G):-
    Y > 0,
    R is X mod Y,
    gcd(Y, R, G).

% 7.a
ancestor_of(X,Y):-
    parent(X,Y).

ancestor(X,Y):-
    parent(X,Z),
    ancestor_of(Z,Y).

% Facts about family relationships.
parent(john, mary).
parent(mary, susan).
parent(susan, lisa).
parent(alex, john).
parent(alex, peter).
parent(peter, julia).

% 7.b

descendant_of(X,Y):-
    parent(Y,X).

descendant(X,Y):-
    parent(Y,Z),
    descendant_of(X,Z).

% 7.c
% Facts about marriages.
% married(X, Y, YearStart, YearEnd): X and Y were married from YearStart to YearEnd.
married(john, mary, 2000, 2010).
married(alex, susan, 1995, 2005).
married(peter, julia, 2010, 2020).

% marriage_years(?X, ?Y, -Years): Determine the duration of marriage between X and Y.
marriage_years(X, Y, Years) :-
    married(X, Y, YearStart, YearEnd),  % Check that X and Y were married
    Years is YearEnd - YearStart.      % Calculate the duration of marriage


% 7.d
% ?- descendant_of(X, gloria), \+ descendant_of(X, jay).
% ?- ancestor_of(A, haley), ancestor_of(A, lily).
% ?- married(X, dede, _, _), married(X, gloria, _, _).

% 7.e
% older(?X, ?Y, ?Older): Determines the older person between X and Y.
older(X,Y,Older):-
    born(X, DateX),
    born(Y, DateY),
    before(DateX, DateY),
    Older = X.

older(X,Y,Older):-
    born(X,DateX),
    born(Y, DateY),
    before(DateY, DateX),
    Older = Y.

older(X,Y, _):-
    born(X, Date),
    born(Y,Date),
    Date = Date,
    !,
    fail.


% oldest(?X): Finds the oldest person in the knowledge base.
oldest(X):-
    born(X, DateX),
    \+ (born (Y, DateY),
    before(DateY, DateX)).

born(jay, 1946-5-23).
born(claire, 1970-11-13).
born(mitchell, 1973-7-10).
born(alex, 1995-2-5).
born(haley, 1993-12-14).
born(luke, 1999-4-15).

% 8.a
% Example facts about circuits and their number of gates.
circuit(abu_dhabi, 15).
circuit(chiba, 18).
circuit(budapest, 22).
circuit(ascot, 20).

% most_gates(?X): Finds the circuit with the highest number of gates.
most_gates(X) :-
    circuit(X, GatesX),                     % Choose a candidate circuit X
    \+ (circuit(_, GatesY), GatesY > GatesX).  % No other circuit has more gates than X


% 8.b
% least_gates(?X): Finds the circuit with the lowest number of gates.
least_gates(X) :-
    circuit(X, GatesX),                     % Choose a candidate circuit X
    \+ (circuit(_, GatesY), GatesY < GatesX).  % No other circuit has fewer gates than X

% 8.c
% gate_diff(?X): Calculates the difference between the most and least gates.
gate_diff(Diff) :-
    most_gates(MaxCircuit),                   % Find the circuit with the most gates
    circuit(MaxCircuit, MaxGates),            % Retrieve the number of gates for that circuit
    least_gates(MinCircuit),                  % Find the circuit with the least gates
    circuit(MinCircuit, MinGates),            % Retrieve the number of gates for that circuit
    Diff is MaxGates - MinGates.              % Calculate the difference

% 8.d
% Example facts about pilots and their teams.
pilot(martin_sonka, red_bull_team).
pilot(yoshihide_muroya, red_bull_team).
pilot(pete_mcleod, team_breitling).
pilot(kirby_chambliss, team_breitling).
pilot(michael_goulian, team_challenger).

% same_team(?X, ?Y): Succeeds if X and Y race for the same team.
same_team(X, Y) :-
    pilot(X, Team),
    pilot(Y, Team),
    X \= Y.  % Ensure X and Y are not the same person

% 8.e
% Example facts about circuit winners and pilots.
% winner(Circuit, Pilot): Pilot who won the given Circuit.
winner(abu_dhabi, martin_sonka).
winner(chiba, yoshihide_muroya).
winner(budapest, pete_mcleod).

% Example facts about pilots and their teams.
% pilot(Pilot, Team): The team associated with a given Pilot.
pilot(martin_sonka, red_bull_team).
pilot(yoshihide_muroya, red_bull_team).
pilot(pete_mcleod, team_breitling).
pilot(kirby_chambliss, team_breitling).
pilot(michael_goulian, team_challenger).

% is_from_winning_team(?P, ?C): Finds pilots from the team that won the given circuit.
is_from_winning_team(P, C) :-
    winner(C, Winner),                % Find the winner of circuit C
    pilot(Winner, Team),              % Find the team of the winning pilot
    pilot(P, Team),                   % Find pilots from the same team
    P \= Winner.                      % Ensure P is not the winning pilot

% 9
% Example facts about people, their jobs, and their supervisors.
% job(Person, Position): Defines a person's job position.
job(alice, manager).
job(bob, engineer).
job(carol, director).
job(dave, technician).

% supervises(Supervisor, Subordinate): Defines the supervisory relationship.
supervises(carol, alice).
supervises(alice, bob).
supervises(alice, dave).

% superior(+X, +Y): Succeeds if X's position is superior to Y's position.
superior(X, Y) :-
    supervises(X, Y).                    % Direct supervision

superior(X, Y) :-
    supervises(X, Z),                    % Indirect supervision
    superior(Z, Y).                      % Recursively check for superior relationship

