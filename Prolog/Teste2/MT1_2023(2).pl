:-dynamic saga/4, movie/8.

%saga(SagaID, Nome da Saga, Número de Filmes da Saga, Criador)
saga(1, 'Jurassic Park',  6, 'Michael Crichton').
saga(2, 'Indiana Jones',  4, 'George Lucas').
saga(3, 'Star Wars',      9, 'George Lucas').
saga(4, 'Harry Potter',   0, 'J. K. Rowling').
saga(6, 'Jaws',           0, 'Peter Benchley').

%movie(Título do Filme, Ano de Lançamento, SagaID, Duração, Classificação IMDB, Realizador, Compositor, Elenco)
movie('Jurassic Park',                  1993, 1, 127, 8.2, 'Steven Spielberg', 'John Williams',     ['Sam Neill', 'Jeff Goldblum', 'Laura Dern', 'BD Wong']).
movie('The Lost World: Jurassic Park',  1997, 1, 129, 6.5, 'Steven Spielberg', 'John Williams',     ['Jeff Goldblum', 'Julianne Moore', 'Vince Vaughn', 'Richard Schiff']).
movie('Jurassic Park III',              2001, 1,  92, 5.9, 'Joe Johnston',     'Don Davis',         ['Sam Neill', 'William H. Macy', 'Téa Leoni']).
movie('Jurassic World',                 2015, 1, 124, 6.9, 'Colin Trevorrow',  'Michael Giacchino', ['Chris Pratt', 'Bryce Dallas Howard', 'Irrfan Khan', 'BD Wong']).
movie('Jurassic World: Fallen Kingdom', 2018, 1, 128, 6.1, 'J.A. Bayona',      'Michael Giacchino', ['Chris Pratt', 'Bryce Dallas Howard', 'James Cromwell', 'BD Wong']).
movie('Jurassic World: Dominion',       2022, 1, 147, 5.6, 'Colin Trevorrow',  'Michael Giacchino', ['Chris Pratt', 'Bryce Dallas Howard', 'Campbell Scott', 'BD Wong']).

movie('Raiders of the Lost Ark',       1981, 2, 115, 8.4, 'Steven Spielberg', 'John Williams', ['Harrison Ford', 'Karen Allen', 'John Rhys-Davies']).
movie('The Temple of Doom',            1984, 2, 118, 7.5, 'Steven Spielberg', 'John Williams', ['Harrison Ford', 'Kate Capshaw', 'Ke Huy Quan']).
movie('The Last Crusade',              1989, 2, 127, 8.2, 'Steven Spielberg', 'John Williams', ['Harrison Ford', 'Alison Doody', 'Sean Connery']).
movie('Kingdom of the Crystal Skull',  2008, 2, 122, 6.2, 'Steven Spielberg', 'John Williams', ['Harrison Ford', 'Karen Allen', 'Shia LaBeouf']).

movie('The Phantom Menace',       1999, 3, 136, 6.5, 'George Lucas',     'John Williams', ['Ewan McGregor', 'Liam Neeson', 'Natalie Portman', 'Ian McDiarmid']).
movie('Attack of the Clones',     2002, 3, 142, 6.6, 'George Lucas',     'John Williams', ['Ewan McGregor', 'Hayden Christensen', 'Natalie Portman', 'Christopher Lee']).
movie('Revenge of the Sith',      2005, 3, 140, 7.6, 'George Lucas',     'John Williams', ['Ewan McGregor', 'Hayden Christensen', 'Natalie Portman', 'Christopher Lee']).
movie('A New Hope',               1977, 3, 121, 8.6, 'George Lucas',     'John Williams', ['Harrison Ford', 'Mark Hamill', 'Carrie Fisher', 'Alec Guinness']).
movie('The Empire Strikes Back',  1980, 3, 124, 8.7, 'Irvin Kershner',   'John Williams', ['Harrison Ford', 'Mark Hamill', 'Carrie Fisher', 'Billy Dee Williams']).
movie('Return of the Jedi',       1983, 3, 131, 8.3, 'Richard Marquand', 'John Williams', ['Harrison Ford', 'Mark Hamill', 'Carrie Fisher', 'Ian McDiarmid']).
movie('The Force Awakens',        2015, 3, 138, 7.8, 'J. J. Abrams',     'John Williams', ['Daisy Ridley', 'Harrison Ford', 'Mark Hamill', 'Carrie Fisher']).
movie('The Last Jedi',            2017, 3, 152, 6.9, 'Rian Johnson',     'John Williams', ['Daisy Ridley', 'Mark Hamill', 'Carrie Fisher', 'John Boyega']).
movie('The Rise of Skywalker',    2019, 3, 141, 6.4, 'J. J. Abrams',     'John Williams', ['Daisy Ridley', 'Mark Hamill', 'John Boyega', 'Adam Driver']).


same_year(Movie1, Movie2):-
	movie(Movie1, Year, _S1, _D1, _I1, _Di1, _C1, _Cs1),
	movie(Movie2, Year, _S2, _D2, _I2, _Di2, _C2, _Cs2),
	Movie1 \= Movie2.

movie_from_saga(Movie, Saga):-
	saga(SagaID, Saga, _N, _Creator),
	movie(Movie, _Y, SagaID, _Dur, _I, _D, _C, _Cs).

saga_longest_movie(Saga, Movie):-
	saga(SagaID, Saga, _N, _Creator),
	movie(Movie, _Y1, SagaID, Dur, _IM1, _Dir1, _Comp1, _Cast1),
	\+(( movie(_M2, _Y2, SagaID, D2, _IM2, _Dir2, _Comp2, _Cast2), D2 > Dur )).


add_movie_to_saga(Saga, Movie, Year, Duration, Score, Director, Composer, Cast):-
	saga(SagaID, Saga, _N, _C),
	movie(Movie, Year, SagaID, Duration, Score, Director, Composer, Cast), !, fail.
add_movie_to_saga(Saga, Movie, Year, Duration, Score, Director, Composer, Cast):-
	retract( saga(SagaID, Saga, OldN, Creator) ),
	NewN is OldN + 1,
	assertz( saga(SagaID, Saga, NewN, Creator) ),
	assertz( movie(Movie, Year, SagaID, Duration, Score, Director, Composer, Cast) ).


movies_from_saga(Saga, Movies):-
	saga(SagaID, Saga, _N, _C),
	movies_from_saga(SagaID, [], Movies).
movies_from_saga(SagaID, Movies, Final):-
	movie(Movie, Year, SagaID, _Dur, _Score, _Dir, _Comp, _Cast),
	\+ member(Year-Movie, Movies), !,
	movies_from_saga(SagaID, [Year-Movie|Movies], Final).
movies_from_saga(_SagaID, AllMovies, Movies):-
	sort(AllMovies, SortedMovies),
	remove_year(SortedMovies, Movies).

remove_year([], []).
remove_year([_Y-Movie | T], [Movie | T2]):-
	remove_year(T, T2).

saga_cast(Saga, Cast):-
	saga(SagaID, Saga, _N, _Cr),
	findall(Actor, ( movie(_T, _Y, SagaID, _Dur, _Sc, _Dir, _Comp, Cast), member(Actor, Cast) ), List),
	sort(List, Cast).

sample_cast(Saga, SampleCast):-
	saga_cast(Saga, Cast),
	sample(Cast, SampleCast).

sample([], []).
sample([E], [E]).
sample([A,_B|T], [A|T2]):-
	sample(T, T2).

composer_rating(Composer, AvgScore):-
	findall(Score, movie(_M, _Y, _SID, _D, Score, _Dir, Composer, _Cs), Scores),
	length(Scores, Len),
	sumlist(Scores, Sum),
	AvgScore is Sum / Len.

most_successful_composer(Composer1, Composer2, Composer1):-
	composer_rating(Composer1, S1),
	composer_rating(Composer2, S2),
	S1 >= S2.
most_successful_composer(Composer1, Composer2, Composer2):-
	composer_rating(Composer1, S1),
	composer_rating(Composer2, S2),
	S2 >= S1.

Composer composed_for Movie:- 
	movie(Movie, _Year, _Saga, _Dur, _Score, _Dir, Composer, _Cast).

connected(Person1, Person2):-
    connected2(Person1, Person2),
    Person1 \= Person2.
connected(Person1, Person2):-
    connected2(Person2, Person1),
    Person1 \= Person2.
    
connected2(Person1, Person2):-
    movie(_T, _Y, _S, _D, _Sc, Person1, Person2, _).
connected2(Person1, Person2):-
    movie(_T, _Y, _S, _D, _Sc, Person1, _C, Cast),
    member(Person2, Cast).
connected2(Person1, Person2):-
    movie(_T, _Y, _S, _D, _Sc, _Dir, Person1, Cast),
    member(Person2, Cast).
connected2(Person1, Person2):-
    movie(_T, _Y, _S, _D, _Sc, _Dir, _Comp, Cast),
    member(Person1, Cast),
    member(Person2, Cast).

connected_degree(Person1, Person2, Degree):-
	connected_degree_bfs([ [Person1] ], Person2, Degree).

connected_degree_bfs([ [Person1|R] | _], Person1, Degree):- !,
	length(R, Degree).
connected_degree_bfs([ [Person1|R] | T ], Person2, Degree):-
	setof(Next, ( connected(Person1, Next),
		      \+ (member(Next, [Person1|R])) ), List),
	append_all(List, [Person1|R], ToSee),
	append(T, ToSee, NextList),
	connected_degree_bfs(NextList, Person2, Degree).

append_all([], _List, []).
append_all([H|T], List, [ [H|List] |NT]):-
	append_all(T, List, NT).


