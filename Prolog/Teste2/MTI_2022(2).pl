:- dynamic round/4.

% round(RoundNumber, DanceStyle, Minutes, [Dancer1-Dancer2 | DancerPairs])
% round/4 indica, para cada ronda, o estilo de dança, a sua duração, e os pares de dançarinos participantes.
round(1, waltz, 8, [eugene-fernanda]).
round(2, quickstep, 4, [asdrubal-bruna,cathy-dennis,eugene-fernanda]).
round(3, foxtrot, 6, [bruna-dennis,eugene-fernanda]).
round(4, samba, 4, [cathy-asdrubal,bruna-dennis,eugene-fernanda]).
round(5, rhumba, 5, [bruna-asdrubal,eugene-fernanda]).

% tempo(DanceStyle, Speed).
% tempo/2 indica a velocidade de cada estilo de dança.
tempo(waltz, slow).
tempo(quickstep, fast).
tempo(foxtrot, slow).
tempo(samba, fast).
tempo(rhumba, slow).

style_round_number(Style, Round):-
    round(Round, Style, _Min, _Pairs).

n_dancers(Round, NDancers):-
    round(Round, _Style, _Mins, Pairs),
    length(Pairs, Len),
    NDancers is 2*Len.

danced_in_round(Round, Dancer):-
    round(Round, _Style, _Mins, Pairs),
    member(Dancer-_Pair, Pairs).
danced_in_round(Round, Dancer):-
    round(Round, _Style, _Mins, Pairs),
    member(_Pair-Dancer, Pairs).

n_rounds(Round):-
    round(Round, _Style, _Mins, _Pairs),
    \+( (round(R1,_,_,_), R1 > Round) ).

add_dancer_pair(Round, Dancer1, Dancer2):-
    \+ danced_in_round(Round, Dancer1),
    \+ danced_in_round(Round, Dancer2),
    retract( round(Round, Style, Minutes, Pairs) ),
    assert( round(Round, Style, Minutes, [Dancer1-Dancer2|Pairs]) ).


total_dance_time(Dancer, Time):-
	danceTime(Dancer, [], 0, Time).

danceTime(Dancer, Rounds, Temp, Time):-
	danced_in_round(Round, Dancer),
	\+ member(Round, Rounds),!,
	round(Round, _Style, Mins, _Pairs),
	NTemp is Temp + Mins,
	danceTime(Dancer, [Round|Rounds], NTemp, Time).
danceTime(_Dancer, _Rounds, Time, Time).

print_program:-
	round(Round, Style, Mins, Pairs),
	length(Pairs, NPairs),
	write(Style), 
	write(' ('), write(Mins), 
	write(') - '), write(NPairs),
	nl,
	fail.
print_program.

dancer_n_dances(Dancer, NRounds):-
    bagof(Round, danced_in_round(Round, Dancer), List),
    length(List, NRounds).

most_tireless_dancer(Tireless):-
    setof(Time-Dancer, Round^( 
			danced_in_round(Round, Dancer), 
			total_dance_time(Dancer, Time)
		), List),
    reverse(List, [_Time-Tireless | _]).

predX([],0).
predX([X|Xs],N):-
    X =.. [_|T],
    length(T,2),
    !,
    predX(Xs,N1),
    N is N1 + 1.
predX([_|Xs],N):-
    predX(Xs,N).

:- op(580, xfy, and).


edge(a,b).
edge(a,c).
edge(a,d).
edge(b,e).
edge(b,f).
edge(c,b).
edge(c,d).
edge(c,e).
edge(d,a).
edge(d,e).
edge(d,f).
edge(e,f).

shortest_safe_path(Ni, Nf, PNs, Path):-
    \+member(Ni, PNs),
    \+member(Nf, PNs),
    bfs([[Ni]], Nf, PNs, PathInv),
    reverse(PathInv, Path).

bfs( [ [Nf|T]|_], Nf, _, [Nf|T]).
bfs( [ [Na|T]|Ns], Nf, PNs, Sol):-
    findall(
        [Nb,Na|T],
        (edge(Na,Nb), \+member(Nb, [Na|T]), \+member(Nb, PNs)),
        Ns1),
    append(Ns, Ns1, Ns2),
    bfs(Ns2, Nf, PNs, Sol).

all_shortest_safe_paths(Ni, Nf, PNs, L):-
    shortest_safe_path(Ni, Nf, PNs, AShortestPath),
    !,
    length(AShortestPath, N),
    length(Path, N),
    findall(Path, shortest_safe_path(Ni, Nf, PNs, Path), L).

