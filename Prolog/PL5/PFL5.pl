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


% 1.a
children(Person, children) :-
    findall(Child, parent(Person, Child), Children).

% 1.b
% Retorna uma lista com os pares pai e numero de filhos
children_of([], []).
children_of([Person|Rest], [Person-Children|Pairs]):-
    children(Person, Children),
    children_of(Rest, Pairs).

% 1.c
% Retorna uma lista com as pessoas da familia
family(F):-
    findall(Person, (male(Person); female(Person)), F).

% 1.d
% Retorna os casais
couple(X-Y):-   
    parent(X, Child),
    parent(Y, Child),
    X \= Y.

% igual à anterior sem duplicatas
couples(List):- 
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

% Retorna o casal e os filhos
spouse_children(Person, Spouse/Children) :-
    spouse(Person, Spouse),
    findall(Child, (parent(Person, Child), parent(Spouse, Child)), Children).

% Retorna uma lista com os pais e os filhos da pessoa
parents_of_two(Parents):-
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

teachers(T):-
    findall(Teacher, teaches(Teacher, _), TeacherList),
    sort(TeacherList, T).

students_of(S, T):-
    findall(Student, (teaches(T, Course), student(Student, Course)), StudentList),
    sort(Studentlist, S).

common_courses(S1, S2, C):-
    findall(Course, (student(S1, Course), student(S2, Course)), CourseList),
    sort(CourseList, C).

more_than_one_course(L):-
    findall(Student, (student(Student, Course1), student(Student, Course2), Course1 \= Course2), StudentList),
    sort(StudentList, L).

strangers(L):-
    findall((S1, S2), (student(s1, _), student(S2, _), S1 \= S2, \+ (student(S1, Course), student(S2, Course))), Pairs),
    sort(Pairs, L).

% lista de estudants que participam em mais do que um curso ao mesmo tempo
good_groups(L):-
    findall(student, (student(Student, Course1), student(Student, Course2), Course1 \= Course2, student(Student, Course3), Course2 \= Course3, COurse1 \= Course3), GroupList),
    sort(GroupList, L).

% 3

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


same_day(Course1, Course2) :-
    class(Course1, _, Day, _, _),
    class(Course2, _, Day, _, _),
    Course1 \= Course2.

daily_courses(Day, Courses):-
    setof(Course, ClassType ^ Time ^ Duration(class(Course, ClassType, Day, Time, Duration)), Courses).

% Class que duram menos de 2 horas 
short_classes(L):-
    findall(UC-Day/Time, (class(UC, _, Day, Time, Duration), Duration < 2), L).

course_classes(Course, Classes):-
    findall(Day/Time-Type, class(Course, Type, Day, Time, _), Classes).

courses(L):-
    findall(Course, class(Course, _, _, _,_), CourseList),
    sort(CourseList, L).

% 4
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

get_all_nodes(ListOfAirports) :-
    setof(Airport, Departure^Arrival^Company^FlightNumber^Time^Duration^(
        flight(Departure, Arrival, Company, FlightNumber, Time, Duration),
        (Airport = Departure ; Airport = Arrival)
    ), ListOfAirports).

find_flights(Origin, Destination, [Code], [Origin]) :-
    flight(Origin, Destination, _, Code, _, _).

find_flights(Origin, Destination, [Code|Rest], [Origin|Restcity]):-
    flight(Origin, Stop,_, Code, _, _),
    Stop \= Destination,
    find_flights(Stop, Destination, rest, Restcity),
    \+ member(Origin, restcity).

% find_flights with bfs
% reverse(List, Reversed)
% Reverte uma lista fornecida, retornando o resultado em Reversed.
% Utiliza um acumulador para manter a eficiência.
reverse(List, Reversed) :-
    reverse_helper(List, [], Reversed). % Chama o auxiliar com um acumulador vazio.

% reverse_helper(List, Acc, Reversed)
% Auxiliar que faz a reversão de uma lista utilizando um acumulador.
% Caso base: quando a lista original está vazia, o acumulador contém a lista invertida.
reverse_helper([], Acc, Acc).

% Caso recursivo: remove o primeiro elemento da lista original (Head),
% adiciona-o ao acumulador e continua com o restante da lista (Tail).
reverse_helper([Head|Tail], Acc, Reversed) :-
    reverse_helper(Tail, [Head|Acc], Reversed).

% find_flights_bfs(Origin, Destination, Flights)
% Encontra um caminho de voos entre a origem e o destino usando BFS.
% Flights retorna a lista de cidades no caminho, na ordem correta.
find_flights_bfs(Origin, Destination, Flights) :-
    bfs([[Origin]], Destination, RevPath), % Realiza BFS, retornando o caminho reverso (RevPath).
    reverse(RevPath, Flights).             % Inverte o caminho para obter a ordem correta.

% bfs([[Destination|Path]|_], Destination, [Destination|Path])
% Caso base: se o primeiro caminho na fila começa com o destino (Destination),
% retorna o caminho completo (Destination|Path) como resultado.
bfs([[Destination|Path]|_], Destination, [Destination|Path]).

% bfs([[Current|Path]|Rest], Destination, Result)
% Caso recursivo: continua expandindo os caminhos até encontrar o destino.
bfs([[Current|Path]|Rest], Destination, Result) :-
    % Encontra todos os próximos passos possíveis a partir do nó atual (Current),
    % garantindo que não sejam revisitados (usando \+ member).
    findall([Next, Current|Path],
            (flight(Current, Next, _, Code, _, _), \+ member(Next, [Current|Path])),
            NewPaths),
    % Adiciona os novos caminhos à fila de exploração (Queue).
    append(Rest, NewPaths, Queue),
    % Continua a busca com a nova fila.
    bfs(Queue, Destination, Result).

% flight(Current, Next, _, Code, _, _)
% Representa voos diretos entre duas cidades (Current -> Next),
% com outros atributos (_ sendo ignorados aqui).
% Por exemplo, flight('Lisbon', 'Madrid', 2.5, 'TP101', 150, 3) indica
% um voo de Lisboa para Madri.

% 5.e
find_all_flights(Origin, Destination, ListOfFlights):-
    findall(FlightPath, find_flight_path(Origin, Destination, [], FlightPath), ListOfFlights).

find_flight_path(Origin, destination, Visited, [FlightCode]):-
    flight(Origin, Destination, _, FlightCode, _, _),
    \+ member(FlightCode, Visited).

find_flight_path(Origin, Destination, Visited, [FlightCode| Rest]):-
    flight(origin, Stop, _, flightcode, _,_),
    \+ member(FlightCode, Visisted),
    find_flight_path(Stop, Destination, [FlightCode|Visited], Rest).


% 5.f
find_flights_least_stops(Origin, Destination, ListOfFlights):-
    findall(path, find_flight_path(Origin, Destination, [], Path), AllPaths),
    find_min_length_paths(AllPaths, ListOfFlights).

find_min_length_paths(AllPaths, MinLengthPaths):-
    maplist(length, AllPaths, Lengths),
    min_list(Lengths, MinLength),
    include(same_length(MinLength), AllPaths, MinLengthPaths).

same_length(Length, List):- length(List, Length).

% 5.g
find_fligths_stops(Origin, destination, Stops, ListFlights):-
    findall(Path, find_flight_with_stops(Origin, Destination, Stops, [], Path), ListFlights).

find_flight_with_stops(Origin, destination, [], visited, [flightCode]):-
    flight(Origin, Destination, _, FlightCode, _, _),
    \+ member(FlightCode, Visited).

find_flight_with_stops(Origin, Destination, [Stop|RemainingStops], Visited, [FlightCode|Rest]):-
    flight(Origin, Stop, _, FlightCode, _, _),
    \+ member(FlightCode, Visited),
    find_flight_with_stops(Stop, Destination, RemainingStops, [FlightCode|Visited], Rest).

% 5.h
find_circular_trip(MaxSize, origin, Cycle):-
    find_flight_path_with_limit(Origin, Origin, MaxSize, [], Cycle).

find_flight_path_with_limit(Origin, Destination, MaxSize, Visited, [FlightCode]):-
    MaxSize > 0,
    flight(Origin, destination, _, FlightCode, _, _),
    \+ member(FlightCode, Visited).

find_flight_path_with_limit(Origin, Destination, MaxSize, Visited, [FlightCode|Rest]):-
    MaxSize > 1,
    flight(Origin, Stop, _, FlightCode, _, _),
    \+ member(FlightCode, Visited),
    NewMaxSize is MaxSize - 1,
    find_flight_path_with_limit(Stop, Destination, NewMaxSize, [FlightCode|Visited], Rest).


% 5.i
find_circular_trips(MaxSize, Origin, Cycles):-
    findall(Cycle, find_circular_trip(MaxSize, origin, Cycle), Cycles).

% 5.j
strongly_connected(ListOfNodes):-
    forall(member(Node1, ListOfNodes), (
        forall(member(Node2, ListOfNodes), (
            Node1 \= Node2 ->
            find_flight_path(Node1, Node2, [], _); true
        ))
    )).

% 5.k
strongly_connected_components(Components):-
    findall(Node, (
        flight(Node,_,_,_,_,_);
        flight(_,Node,_,_,_,_)
    ), AllNodes),
    setof(Components, (
        subset(Component, AllNodes),
        strongly_connected(Component)
    ),Components).

% 5.l
bridges(ListOfBridges):-
    findall(flight(Origin, Destination, Company, FlightCode, Time, Duration),
    flight(Origin, Destination, Company, FlightCode, Time, Duration),
    AllFlights),
    include(is_bridge, ALlFlights, ListOfBridges).

is_bridge(Flight(Origin, Destination,_,FlightCode, _, _)):-
    \+ (flight_path_cycle(Origin, Destination, FlightCode)).

flight_path_cycle(Origin, Destination, ExcludeFlight):-
    find_flight_path(Origin, Destination, [ExcludeFlight], Path),
    member(ExcludeFlight, Path).

