male(frank).
male(jay).
male(javier).
male(bo).
male(phil).
male(mitchell).
male(joe).
male(manny).
male(dylan).
male(alex).
male(luke).
male(cameron).
male(pameron).
male(george).
male(rexford).
male(calhoun).

% Female definitions
female(grace).
female(dede).
female(gloria).
female(barb).
female(claire).
female(haley).
female(lily).
female(poppy).

% Parent definitions
parent(grace, phil).
parent(frank, phil).

parent(dede, claire).
parent(jay, claire).

parent(dede, mitchell).
parent(jay, mitchell).

parent(jay, joe).
parent(gloria, joe).

parent(gloria, manny).
parent(javier, manny).

parent(phil, haley).
parent(claire, haley).

parent(phil, alex).
parent(claire, alex).

parent(phil, luke).
parent(claire, luke).

parent(mitchell, lily).
parent(cameron, lily).

parent(mitchell, rexford).
parent(cameron, rexford).

parent(dylan, george).
parent(haley, george).

parent(dylan, poppy).
parent(haley, poppy).

parent(pameron, calhoun).
parent(bo, calhoun).
%1.a
% Definição do predicado children/2
% children(+Person, -Children) retorna uma lista dos filhos de Person.
children(Person, Children) :-
    findall(Child, parent(Person, Child), Children).
%1.b
% Definição do predicado children_of/2
% children_of(+ListOfPeople, -ListOfPairs) retorna uma lista de pares no formato P-C,
% onde P é uma pessoa e C é a lista dos seus filhos.
children_of([], []).
children_of([Person|Rest], [Person-Children|Pairs]) :-
    children(Person, Children),
    children_of(Rest, Pairs).
%1.c
% Definição do predicado family/1
% family(-F) retorna uma lista com todas as pessoas da família.
family(F) :-
    findall(Person, (male(Person); female(Person)), F).
%1.d
% Definição do predicado couple/1
% couple(?C) unifica C com um casal de pessoas (no formato X-Y) que têm pelo menos um filho em comum.
couple(X-Y) :-
    parent(X, Child),
    parent(Y, Child),
    X \= Y.
%1.e
% Definição do predicado couples/1
% couples(-List) retorna uma lista de todos os casais com filhos, evitando duplicatas.
couples(List) :-
    setof(X-Y, (couple(X-Y), X @< Y), List).

%1.f
% Facts indicating the spouse relationship.
spouse(grace, frank).
spouse(frank, grace).

spouse(dede, jay).
spouse(jay, dede).

spouse(jay, gloria).
spouse(gloria, jay).

spouse(phil, claire).
spouse(claire, phil).

spouse(mitchell, cameron).
spouse(cameron, mitchell).

spouse(haley, dylan).
spouse(dylan, haley).

spouse(pameron, bo).
spouse(bo, pameron).

% spouse_children/2 implementation
spouse_children(Person, Spouse/Children) :-
    spouse(Person, Spouse),           % Find the spouse of the person
    findall(Child, (parent(Person, Child), parent(Spouse, Child)), Children).


%1.g
% immediate_family/2 implementation
immediate_family(Person, Parents-SpouseChildren) :-
    findall(Parent, parent(Parent, Person), Parents), % Find parents of Person
    findall(Spouse/Children, spouse_children(Person, Spouse/Children), SpouseChildren).

%1.h
% parents_of_two/1 implementation
parents_of_two(Parents) :-
    findall(Parent, (parent(Parent, Child1), parent(Parent, Child2), Child1 \= Child2), ParentList),
    sort(ParentList, Parents).

% 2
% Facts about teachers and students
teaches(t1, c1).
teaches(t1, c2).
teaches(t2, c3).
teaches(t3, c1).

student(s1, c1).
student(s2, c2).
student(s3, c3).
student(s4, c1).

% teachers/1 implementation
teachers(T) :-
    findall(Teacher, teaches(Teacher, _), TeacherList),
    sort(TeacherList, T).

% students_of/2 implementation
students_of(T, S) :-
    findall(Student, (teaches(T, Course), student(Student, Course)), StudentList),
    sort(StudentList, S).

% teachers_of/2 implementation
teachers_of(S, T) :-
    findall(Teacher, (student(S, Course), teaches(Teacher, Course)), TeacherList),
    sort(TeacherList, T).

% common_courses/3 implementation
common_courses(S1, S2, C) :-
    findall(Course, (student(S1, Course), student(S2, Course)), CourseList),
    sort(CourseList, C).

% more_than_one_course/1 implementation
more_than_one_course(L) :-
    findall(Student, (student(Student, Course1), student(Student, Course2), Course1 \= Course2), StudentList),
    sort(StudentList, L).

% strangers/1 implementation
strangers(L) :-
    findall((S1, S2), (student(S1, _), student(S2, _), S1 \= S2, \+ (student(S1, Course), student(S2, Course))), Pairs),
    sort(Pairs, L).

% good_groups/1 implementation
good_groups(L) :-
    findall(Student, (student(Student, Course1), student(Student, Course2), Course1 \= Course2, student(Student, Course3), Course2 \= Course3, Course1 \= Course3), GroupList),
    sort(GroupList, L).

%class(Course, ClassType, DayOfWeek, Time, Duration) 
class(pfl, t, '2 Tue', 15, 2). 
class(pfl, tp, '2 Tue', 10.5, 2). 
class(lbaw, t, '3 Wed', 10.5, 2). 
class(lbaw, tp, '3 Wed', 8.5, 2). 
class(ipc, t, '4 Thu', 14.5, 1.5). 
class(ipc, tp, '4 Thu', 16, 1.5). 
class(fsi, t, '1 Mon', 10.5, 2). 
class(fsi, tp, '5 Fri', 8.5, 2). 
class(rc, t, '5 Fri', 10.5, 2). 
class(rc, tp, '1 Mon', 8.5, 2). 

%3.a
% same_day/2 implementation
same_day(Course1, Course2) :-
    class(Course1, _, Day, _, _),
    class(Course2, _, Day, _, _),
    Course1 \= Course2.


%3.b
% Definição do predicado daily_courses/2
% daily_courses(+Day, -Courses) retorna uma lista com todos os cursos que acontecem no dia especificado.
daily_courses(Day, Courses) :-
    setof(Course, ClassType^Time^Duration^(class(Course, ClassType, Day, Time, Duration)), Courses).

%3.c
% Definição do predicado short_classes/1
% short_classes(-L) retorna uma lista de todas as aulas com duração menor que 2 horas (formato UC-Day/Time).
short_classes(L) :-
    findall(UC-Day/Time, (class(UC, _, Day, Time, Duration), Duration < 2), L).
%3.d
course_classes(Course, Classes) :-
    findall(Day/Time-Type, class(Course, Type, Day, Time, _), Classes).

% courses/1 implementation
courses(L) :-
    findall(Course, class(Course, _, _, _, _), CourseList),
    sort(CourseList, L).

% schedule/0 implementation
schedule :-
    findall((Day, Time, Duration, Course, ClassType),
            class(Course, ClassType, Day, Time, Duration),
            Classes),
    sort(Classes, SortedClasses),
    print_schedule(SortedClasses).

print_schedule([]).
print_schedule([(Day, Time, Duration, Course, ClassType)|Rest]) :-
    translate_day(Day, TranslatedDay),
    format("~w ~w ~w ~w ~w~n", [TranslatedDay, Time, Duration, Course, ClassType]),
    print_schedule(Rest).


% Translation predicate for days
translate_day('1 Mon', 'Mon').
translate_day('2 Tue', 'Tue').
translate_day('3 Wed', 'Wed').
translate_day('4 Thu', 'Thu').
translate_day('5 Fri', 'Fri').

% find_class/0 implementation
find_class :-
    write("Enter day (e.g., '1 Mon'): "),
    read(Day),
    write("Enter time: "),
    read(Time),
    (   class(Course, ClassType, Day, StartTime, Duration),
        EndTime is StartTime + Duration,
        Time >= StartTime, Time =< EndTime
    ->  format("Class ~w (~w) starts at ~w and lasts ~w hours.~n", [Course, ClassType, StartTime, Duration])
    ;   write("No class at this time.~n")
    ).

%flight(origin, destination, company, code, hour, duration) 
flight(porto, lisbon, tap, tp1949, 1615, 60). 
flight(lisbon, madrid, tap, tp1018, 1805, 75). 
flight(lisbon, paris, tap, tp440, 1810, 150). 
flight(lisbon, london, tap, tp1366, 1955, 165). 
flight(london, lisbon, tap, tp1361, 1630, 160). 
flight(porto, madrid, iberia, ib3095, 1640, 80). 
flight(madrid, porto, iberia, ib3094, 1545, 80). 
flight(madrid, lisbon, iberia, ib3106, 1945, 80). 
flight(madrid, paris, iberia, ib3444, 1640, 125). 
flight(madrid, london, iberia, ib3166, 1550, 145). 
flight(london, madrid, iberia, ib3163, 1030, 140). 
flight(porto, frankfurt, lufthansa, lh1177, 1230, 165). 

% a) get_all_nodes(-ListOfAirports)
get_all_nodes(ListOfAirports) :-
    setof(Airport, Departure^Arrival^Company^FlightNumber^Time^Duration^(
        flight(Departure, Arrival, Company, FlightNumber, Time, Duration),
        (Airport = Departure ; Airport = Arrival)
    ), ListOfAirports).

% b) most_diversified(-Company)
% Retorna a companhia com mais cidades
most_diversified(Company) :-
    setof(City, OtherCompany^OtherCity^FlightNumber^Time^Duration^(
        flight(City, OtherCity, Company, FlightNumber, Time, Duration) ;
        flight(OtherCity, City, Company, FlightNumber, Time, Duration)
    ), Cities),
    length(Cities, NumCities),
    \+ (setof(OtherCity, FlightNumber^OtherTime^OtherDuration^OtherCompany^(
        flight(OtherCity, City, OtherCompany, FlightNumber, OtherTime, OtherDuration) ;
        flight(City, OtherCity, OtherCompany, FlightNumber, OtherTime, OtherDuration)
    ), OtherCities),
    length(OtherCities, OtherNumCities),
    OtherNumCities > NumCities).


%4.c
% Base case: A direct flight exists between Origin and Destination.
find_flights(Origin, Destination, [Code], [Origin]) :-
    flight(Origin, Destination, _, Code, _, _).

% Recursive case: Find a path with one or more stops.
find_flights(Origin, Destination, [Code|Rest], [Origin|Restcity]) :-
    flight(Origin, Stop, _, Code, _, _),
    Stop \= Destination,
    find_flights(Stop, Destination, Rest, Restcity),
    \+ member(Origin, Restcity). % Avoid cycles by ensuring the flight code is not reused.


 

/*
% Base case: A direct flight exists between Origin and Destination.
find_flights(Origin, Destination, [Code]) :-
    flight(Origin, Destination, _, Code, _, _).

% Recursive case: Find a path with one or more stops.
find_flights(Origin, Destination, [Code|Rest]) :-
    flight(Origin, Stop, _, Code, _, _),
    Stop \= Destination,
    find_flights(Stop, Destination, Rest),
    \+ member(Code, Rest). % Avoid cycles by ensuring the flight code is not reused.

*/


%4.d
reverse(List, Reversed) :-
    reverse_helper(List, [], Reversed).

reverse_helper([], Acc, Acc).
reverse_helper([Head|Tail], Acc, Reversed) :-
    reverse_helper(Tail, [Head|Acc], Reversed).


find_flights_bfs(Origin, Destination, Flights) :-
    bfs([[Origin]], Destination, RevPath),
    reverse(RevPath, Flights).

% Auxiliar: BFS busca o caminho.
bfs([[Destination|Path]|_], Destination, [Destination|Path]).
bfs([[Current|Path]|Rest], Destination, Result) :-
    findall([Next, Current|Path],
            (flight(Current, Next, _, Code, _, _), \+ member(Next, [Current|Path])),
            NewPaths),
    append(Rest, NewPaths, Queue),
    bfs(Queue, Destination, Result).

% e) find_all_flights(+Origin, +Destination, -ListOfFlights)
find_all_flights(Origin, Destination, ListOfFlights) :-
    findall(FlightPath, find_flight_path(Origin, Destination, [], FlightPath), ListOfFlights).

find_flight_path(Origin, Destination, Visited, [FlightCode]) :-
    flight(Origin, Destination, _, FlightCode, _, _),
    \+ member(FlightCode, Visited).
find_flight_path(Origin, Destination, Visited, [FlightCode | Rest]) :-
    flight(Origin, Stop, _, FlightCode, _, _),
    \+ member(FlightCode, Visited),
    find_flight_path(Stop, Destination, [FlightCode | Visited], Rest).

% f) find_flights_least_stops(+Origin, +Destination, -ListOfFlights)
find_flights_least_stops(Origin, Destination, ListOfFlights) :-
    findall(Path, find_flight_path(Origin, Destination, [], Path), AllPaths),
    find_min_length_paths(AllPaths, ListOfFlights).

find_min_length_paths(AllPaths, MinLengthPaths) :-
    maplist(length, AllPaths, Lengths),
    min_list(Lengths, MinLength),
    include(same_length(MinLength), AllPaths, MinLengthPaths).

same_length(Length, List) :- length(List, Length).

% g) find_flights_stops(+Origin, +Destination, +Stops, -ListFlights)
find_flights_stops(Origin, Destination, Stops, ListFlights) :-
    findall(Path, find_flight_with_stops(Origin, Destination, Stops, [], Path), ListFlights).

find_flight_with_stops(Origin, Destination, [], Visited, [FlightCode]) :-
    flight(Origin, Destination, _, FlightCode, _, _),
    \+ member(FlightCode, Visited).
find_flight_with_stops(Origin, Destination, [Stop | RemainingStops], Visited, [FlightCode | Rest]) :-
    flight(Origin, Stop, _, FlightCode, _, _),
    \+ member(FlightCode, Visited),
    find_flight_with_stops(Stop, Destination, RemainingStops, [FlightCode | Visited], Rest).

% h) find_circular_trip(+MaxSize, +Origin, -Cycle)
find_circular_trip(MaxSize, Origin, Cycle) :-
    find_flight_path_with_limit(Origin, Origin, MaxSize, [], Cycle).

find_flight_path_with_limit(Origin, Destination, MaxSize, Visited, [FlightCode]) :-
    MaxSize > 0,
    flight(Origin, Destination, _, FlightCode, _, _),
    \+ member(FlightCode, Visited).
find_flight_path_with_limit(Origin, Destination, MaxSize, Visited, [FlightCode | Rest]) :-
    MaxSize > 1,
    flight(Origin, Stop, _, FlightCode, _, _),
    \+ member(FlightCode, Visited),
    NewMaxSize is MaxSize - 1,
    find_flight_path_with_limit(Stop, Destination, NewMaxSize, [FlightCode | Visited], Rest).

% i) find_circular_trips(+MaxSize, +Origin, -Cycles)
find_circular_trips(MaxSize, Origin, Cycles) :-
    findall(Cycle, find_circular_trip(MaxSize, Origin, Cycle), Cycles).

% j) strongly_connected(+ListOfNodes)
strongly_connected(ListOfNodes) :-
    forall(member(Node1, ListOfNodes), (
        forall(member(Node2, ListOfNodes), (
            Node1 \= Node2 ->
            find_flight_path(Node1, Node2, [], _) ; true
        ))
    )).

% k) strongly_connected_components(-Components)
strongly_connected_components(Components) :-
    findall(Node, (
        flight(Node, _, _, _, _, _) ;
        flight(_, Node, _, _, _, _)
    ), AllNodes),
    setof(Component, (
        subset(Component, AllNodes),
        strongly_connected(Component)
    ), Components).

% l) bridges(-ListOfBridges)
bridges(ListOfBridges) :-
    findall(flight(Origin, Destination, Company, FlightCode, Time, Duration), 
        flight(Origin, Destination, Company, FlightCode, Time, Duration), 
        AllFlights),
    include(is_bridge, AllFlights, ListOfBridges).

is_bridge(flight(Origin, Destination, _, FlightCode, _, _)) :-
    \+ (flight_path_cycle(Origin, Destination, FlightCode)).

flight_path_cycle(Origin, Destination, ExcludeFlight) :-
    find_flight_path(Origin, Destination, [ExcludeFlight], Path),
    member(ExcludeFlight, Path).

% 5
% Não percebo
% unifiable(+L1, +Term, -L2)
unifiable(L1, Term, L2) :-
    include(can_unify(Term), L1, L2).

% Helper predicate to check if two terms can unify without instantiating them
can_unify(Term, Element) :-
    \+ \+ (Term = Element), % Temporarily unify and revert
    \+ (Term = Element).   % Ensure no permanent unification occurs



% 6
% missionaries_and_cannibals(-Moves)
missionaries_and_cannibals(Moves) :-
    initial_state(InitialState),
    final_state(FinalState),
    solve(InitialState, FinalState, [], Moves).

% Initial and final states
initial_state(state(3, 3, left)).
final_state(state(0, 0, right)).

% Solve the problem by finding a sequence of moves
solve(State, State, Moves, Moves).
solve(CurrentState, FinalState, Visited, Moves) :-
    move(CurrentState, NextState),
    \+ member(NextState, Visited),  % Avoid cycles
    is_safe(NextState),
    solve(NextState, FinalState, [NextState | Visited], Moves).

% Possible boat moves
move(state(ML, CL, left), state(NewML, NewCL, right)) :-
    boat(MoveM, MoveC),
    ML >= MoveM,
    CL >= MoveC,
    NewML is ML - MoveM,
    NewCL is CL - MoveC.
move(state(ML, CL, right), state(NewML, NewCL, left)) :-
    boat(MoveM, MoveC),
    MR is 3 - ML,
    CR is 3 - CL,
    MR >= MoveM,
    CR >= MoveC,
    NewML is ML + MoveM,
    NewCL is CL + MoveC.

% Define boat capacity
boat(1, 0).  % One missionary
boat(0, 1).  % One cannibal
boat(1, 1).  % One missionary and one cannibal
boat(2, 0).  % Two missionaries
boat(0, 2).  % Two cannibals

% Check if a state is safe
is_safe(state(ML, CL, _)) :-
    (ML >= CL ; ML == 0),  % Left bank safe
    MR is 3 - ML,
    CR is 3 - CL,
    (MR >= CR ; MR == 0).  % Right bank safe


% 7
% steps(+Steps, -N, -L)
steps(Steps, N, L) :-
    findall(Possibility, climb(Steps, Possibility), L),
    length(L, N).

% climb(+Steps, -Possibility)
climb(0, []). % Base case: 0 steps remaining, no more moves needed
climb(Steps, [1 | Rest]) :- % Take 1 step and continue
    Steps > 0,
    RemainingSteps is Steps - 1,
    climb(RemainingSteps, Rest).
climb(Steps, [2 | Rest]) :- % Take 2 steps and continue
    Steps > 1,
    RemainingSteps is Steps - 2,
    climb(RemainingSteps, Rest).

% 8 
:- use_module(library(clpfd)).

% sliding_puzzle(+Initial, -Moves)
sliding_puzzle(Initial, Moves) :-
    goal_state(Goal),
    solve_dfs(Initial, Goal, [], MovesDFS),
    solve_bfs(Initial, Goal, MovesBFS),
    compare_solutions(MovesDFS, MovesBFS, Moves).

% Define the goal state (solved puzzle)
goal_state([[1, 2, 3],
            [4, 5, 6],
            [7, 8, 0]]).

% Solving using Depth-First Search (DFS)
solve_dfs(State, Goal, Visited, Moves) :-
    dfs(State, Goal, Visited, [], Moves).

dfs(State, State, _, Moves, Moves).
dfs(State, Goal, Visited, CurrentMoves, Moves) :-
    valid_move(State, NextState, Move),
    \+ member(NextState, Visited),
    dfs(NextState, Goal, [NextState | Visited], [Move | CurrentMoves], Moves).

% Solving using Breadth-First Search (BFS)
solve_bfs(Initial, Goal, Moves) :-
    bfs([[Initial, []]], Goal, Moves).

bfs([[State, Moves] | _], Goal, Moves) :-
    State = Goal.
bfs([[State, Moves] | Rest], Goal, FinalMoves) :-
    findall([NextState, [Move | Moves]], (
        valid_move(State, NextState, Move),
        \+ member([NextState, _], Rest)
    ), NextStates),
    append(Rest, NextStates, Queue),
    bfs(Queue, Goal, FinalMoves).

% Valid moves: Move up, down, left, or right
valid_move(State, NextState, Move) :-
    empty_position(State, Row, Col),
    move(Row, Col, NewRow, NewCol, Move),
    swap(State, Row, Col, NewRow, NewCol, NextState).

% Possible moves
move(Row, Col, NewRow, Col, up)    :- NewRow #= Row - 1.
move(Row, Col, NewRow, Col, down)  :- NewRow #= Row + 1.
move(Row, Col, Row, NewCol, left)  :- NewCol #= Col - 1.
move(Row, Col, Row, NewCol, right) :- NewCol #= Col + 1.

% Find the position of the empty cell (0)
empty_position(State, Row, Col) :-
    nth0(Row, State, RowList),
    nth0(Col, RowList, 0).

% Swap two cells in the puzzle
swap(State, Row, Col, NewRow, NewCol, NextState) :-
    nth0(Row, State, RowList),
    nth0(NewRow, State, NewRowList),
    nth0(Col, RowList, Value),
    nth0(NewCol, NewRowList, Target),
    replace(RowList, Col, Target, NewRowList1),
    replace(NewRowList, NewCol, Value, NewRowList2),
    replace(State, Row, NewRowList1, TempState),
    replace(TempState, NewRow, NewRowList2, NextState).

% Replace an element in a list
replace([_|T], 0, Elem, [Elem|T]).
replace([H|T], Index, Elem, [H|R]) :-
    Index > 0,
    NewIndex is Index - 1,
    replace(T, NewIndex, Elem, R).

% Compare solutions obtained by DFS and BFS
compare_solutions(MovesDFS, MovesBFS, Moves) :-
    length(MovesDFS, LenDFS),
    length(MovesBFS, LenBFS),
    format("DFS solution length: ~w~n", [LenDFS]),
    format("BFS solution length: ~w~n", [LenBFS]),
    (LenDFS =< LenBFS -> Moves = MovesDFS ; Moves = MovesBFS).


