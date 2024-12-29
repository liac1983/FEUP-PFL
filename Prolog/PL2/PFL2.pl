% 4
factorial(0,1).
factorial(N, F):-
    N > 0,
    N1 is N - 1,
    factorial(N1, F1),
    F is N * F1.

sum_rec(0,0).
sum_rec(N, Sum):-
    N > 0,
    N1 is N-1,
    sum_rec(N1, Sum1),
    Sum is N + Sum1.

pow_rec(_, 0, 1).
pow_rec(X; Y, P):-  
    y > 0,
    Y1 is Y-1,
    pow_rec(X, Y1, P1),
    P is X * P1.

square_rec(N, S):-
    N >= 0,
    square_aux(N, 0, S).

square_aux(0, Acc, Acc).

square_aux(N, Acc, S):-
    N > 0,
    NewAcc is Acc + N + N - 1,
    N1 is N - 1,
    square_aux(N1, NewAcc, S).

fibonacci(0,0).
fibonacci(1,1).
fibonacci(N, F):-
    N > 1, 
    N1 is N - 1,
    N2 is N - 2,
    fibonacci(N1, f1),
    fibonacci(N2, F2),
    F is F1 + F2.

% 4.f
% Base case : If N is 1, no steps sre needed
collatz(1,0).

% Recursive case for even N: Next value is N / 2
collatz(N, S):-
    N > 1, 
    0 is N mod 2,
    N1 is N // 2,
    collatz(N1, S1),
    S is S1 + 1.

% Recursive cas for odd numbers: Next value is 3N+1
collatz(N, S):-
    N > 1,
    1 is N mod 2,
    N1 is 3 * N + 1,
    collatz(N1, S1),
    S is S1 + 1.

is_prime(2).
is_prime(X):-
    X > 2,
    \+ has_divisor(X, 2).

has_divisor(X, Current):-
    Current * Current =< X,
    X mod Current =:= 0. % Is divisible by current number

has_divisor(X, Current):-
    Current * Current =< X,
    Next is Current + 1,
    has_divisor(X, Next).


% 5.a
% Main predicate for factorial with an accumulator
factorial(N, F):-
    factorial_acc(N, 1, F).

factorial_acc(0, Acc, Acc).

factorial_acc(N, Acc, F):-
    N > 0,
    NewAcc is Acc * N,
    N1 is N - 1,
    factorial_acc(N1, NewAcc, F).


% 6 Greatest Common Divisor 
gcd(X, 0, X):-
    X > 0.

gcd(X;Y,G):-
    Y > 0,
    R is X mod Y,
    gcd(Y,R,G).

% 7
ancestor_of(X,Y):-
    parent(X,Y).

acestor_of(X,Y):-
    parent(X,Z),
    ancestor_of(Z,Y).

% 7
marriage_years(X,Y,Years):-
    married(X;Y, YearStart, YearEnd),
    Years is YearEnd - YearStart.

% 7.e
% Determine de oldest person between X and Y
older(X,Y, Older):-
    born(X, DateX),
    born(Y, DateY),
    before(DateX, DateY),
    Older = X.

older(X,Y,Older):-
    born(X, DateX),
    born(Y, DateY),
    before(DateY, DateX),
    Older = Y.

older(X,Y, _):-
    born(X, Date),
    born(Y, Date),
    Date = Date,
    !,
    fail.

% Encontra a pessoa mais velha na base de dados
odest(X):-
    born(X, DateX),
    \+ (born(Y, DateY),
    before(DateY, DateX)).

% 8
circuit(abu_dhabi, 15).
circuit(chiba, 18).
circuit(budapest, 22).
circuit(ascot, 20).

% Encontra o circuito com o maior numero de gates
most_gates(X):-
    circuit(X, GatesX),
    \+ (circuit(_, DatesY), GatesY > GatesX).
% Example facts about circuit winners and pilots.
% winner(Circuit, Pilot): Pilot who won the given Circuit.
winner(abu_dhabi, martin_sonka).
winner(chiba, yoshihide_muroya).
winner(budapest, pete_mcleod).

pilot(martin_sonka, red_bull_team).
pilot(yoshihide_muroya, red_bull_team).
pilot(pete_mcleod, team_breitling).
pilot(kirby_chambliss, team_breitling).
pilot(michael_goulian, team_challenger).

% Encontra o piloto da equipa que ganhou o circuito dado 
is_from_winning_team(P,C):-
    winner(C, Winner),
    pilot(Winner, Team),
    pilot(P, Team),
    P \= Winner.

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

% Sucesso se a posição de X for superior à de Y
superior(X, Y):-
    supervises(X, Y).

superior(X, Y):-
    supervises(X, Z),
    superior(Z, Y).






