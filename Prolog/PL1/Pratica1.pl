% 1 (youtube: prolog by example)

% Male definitions
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

% 1.b
% yes
% no
% yes
% dede and jay
% joe and manny
% ?- parent(jay, X), parent(X, Y).
% claire and haley
% pais da lily são o michell e cameron. Os pais do mitchell são a ded e o jay, que também são os avós da lily
% no
% os pais do luke são o phil e a claire. Os filhos do luke são a haley e o alex. Os filhos da claire são a haley e o alex são os irmãos do luke

% 1.c

% pai
father(F,C):-
    male(F),
    parent(F,C).

% mãe
mother(M,C):-
    female(M),
    parent(M,C).

% avó ou avô
grandparent(GP,C):-
    parent(GP,P),
    parent(P,C).

% avô
grandfather(GF, C):-
    male(GF),
    grandparent(GF, C).

% avó
grandmother(GM, C):-
    female(GM),
    grandparent(GM, C).

% irmãos
siblings(A, B):-
    parent(P,A),
    parent(P,B),
    A\= B.

% meio-irmão
halfsiblings(A,B):-
    parent(P1,A),
    parent(P1, B),
    parent(P2, A),
    parent(P2, B),
    A \= B,
    P1 \= P2.

% primos
cousins(A, B):-
    parent(PA,A),
    parent(PB,B),
    siblings(PA, PB),
    A \= B.

% tio
uncle(U,N):-
    male(U),
    parent(P,N),
    siblings(U, P).

% tia
aunt(A, N):-
    female(A),
    parent(P,N),
    siblings(A, P).

% descendentes
descendant(D, A):-
    parent(A,D).
descendant(D,A):-
    parent(P,D),
    descendant(P,A).

%antecessor
ancestor(A,D):-
    parent(A,D).
ancestor(A,D):-
    parent(A,P),
    ancestor(P,D).


% 1.d
% Who is a grandmother?
% ?- grandmother(GM, _).
% listar os primos 
% ?- siblings(A, B).


%  1.e
married(jay, gloria, 2008).
married(jay, dede, 1968).
divorced(jay, dede, 2003).


/*currently_married(Person1, Person2):-
    married(Person1, Person2, MarriageYear),
    \+ divorced(Person1, Person2, _).+/


% Check if two people were married in a specific year
/* was_married_in_year(Person1, Person2, Year) :-
    married(Person1, Person2, MarriageYear),
    MarriageYear =< Year,
    (\+ divorced(Person1, Person2, DivorceYear) ; DivorceYear > Year).
 */

% 2

% Professores e os cursos que lecionam
teaches(adalberto, algorithms).
teaches(bernardete, databases).
teaches(capitolino, compilers).
teaches(dalmindo, statistics).
teaches(ermelinda, networks).

% Alunos e os cursos que frequentam
attends(alberto, algorithms).
attends(bruna, algorithms).
attends(cristina, algorithms).
attends(diogo, algorithms).
attends(eduarda, algorithms).

attends(antonio, databases).
attends(bruno, databases).
attends(cristina, databases).
attends(duarte, databases).
attends(eduardo, databases).

attends(alberto, compilers).
attends(bernardo, compilers).
attends(clara, compilers).
attends(diana, compilers).
attends(eurico, compilers).

attends(antonio, statistics).
attends(bruna, statistics).
attends(claudio, statistics).
attends(duarte, statistics).
attends(eva, statistics).

attends(alvaro, networks).
attends(beatriz, networks).
attends(claudio, networks).
attends(diana, networks).
attends(eduardo, networks).

% 2.b
% statistics
% no
% statistics and networks
% no
% no
% no

% 2.c
% i. É X aluno do professor Y?
is_student_of(X,Y):-
    teaches(Y, Course),
    attends(X, Course).

% ii. Quem são os alunos do professor X?
students_of_professor(X, Student):-
    teaches(x, Course),
    attends(Student, Course).

% iii. Quem são os professores do aluno X?
teachers_of_student(X, Teacher):-
    attends(X, Course),
    teaches(Teacher, Course).

% iv. Quem é aluno de ambos os professores X e Y?
student_of_both_professors(Student, prof1, Prof2):-
    teaches(Prof1, Course1),
    teaches(Prof2, Course2),
    attends(Student, Course1),
    attends(student, Course2),
    Prof1 \= Prof2.

% v. Quem é colega de quem?
colleagues(X,Y):-
    attends(X, Course),
    attends(Y, Course),
    X \= Y.

colleagues(X,Y):-
    teaches(X, Course),
    teaches(Y, Course),
    X \= Y.

% vi. Quem são os alunos que frequentam mais de um curso?
student_in_multiple_courses(Student):-
    attends(Student, Course1),
    attends(Student, Course2),
    Course1 \= Course2.

% 3.a
% Pilotos
pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(macleand).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

% Equipes dos pilotos
team(lamb, breitling).
team(besenyei, red_bull).
team(chambliss, red_bull).
team(macleand, mediterranean_racing_team).
team(mangold, cobra).
team(jones, matador).
team(bonhomme, matador).

% Aviões pilotados
aircraft(lamb, mx2).
aircraft(besenyei, edge540).
aircraft(chambliss, edge540).
aircraft(macleand, edge540).
aircraft(mangold, edge540).
aircraft(jones, edge540).
aircraft(bonhomme, edge540).

% Circuitos
circuit(istanbul).
circuit(budapest).
circuit(porto).

% Vitórias
won(jones, porto).
won(mangold, budapest).
won(mangold, istanbul).

% Número de portões em cada circuito
gates(istanbul, 9).
gates(budapest, 6).
gates(porto, 5).

% Uma equipe vence uma corrida se um de seus pilotos vence essa corrida
team_wins(Team, Race) :-
    team(Pilot, Team),
    won(Pilot, Race).


% 3.b
% jones
% matador
% istambul
% lamb

pilot_with_multiple_wins(Pilot):-
    won(Pilot, Circuit1),
    won(Pilot, Circuit2),
    Circuit1 \= Circuit2.

% mangold
% ?- won(Pilot, porto), aircraft(Pilot, Plane).
% jones on edge540

% 4
% Definindo os fatos para cada código e seu significado
error_description(1, 'Integer Overflow').
error_description(2, 'Division by zero').
error_description(3, 'ID Unknown').

% Regra translate/2 para traduzir o código usando os fatos definidos
translate(Code, Meaning):-
    error_description(Code, Meaning).

% 5
job(technician, eleuterio). 
job(technician, juvenaldo). 
job(analyst, leonilde). 
job(analyst, marciliano). 
job(engineer, osvaldo). 
job(engineer, porfirio). 
job(engineer, reginaldo). 
job(supervisor, sisnando). 
job(chief_supervisor, gertrudes). 
job(secretary, felismina). 
job(director, asdrubal). 
supervised_by(technician, engineer). 
supervised_by(engineer, supervisor). 
supervised_by(analyst, supervisor). 
supervised_by(supervisor, chief_supervisor). 
supervised_by(chief_supervisor, director). 
supervised_by(secretary, director).

% 5.b
% Os analistas são supervisionados por alhuém que ocupa o mesmo cargo que Sisnando ?
% Quem é o supervisor dos técnicos, e quem supervisiona essa pessoa?
% Quais cargos são supervisionados por um supervisor, e quem ocupa esses cargos?
% Quem é supervisionado por Asdrúbal, e quem ocupa esses cargos ?


% 5.d
% i. X é supervisor direto de Y?
direct_supervisor(X,Y):-
    job(jobX, X),
    job(jobY, Y),
    supervised_by(jobY, jobX).

% ii. X e Y são supervisionados por pessoas com o mesmo cargo?
same_supervisor_job(X, Y) :-
    job(JobX, X),
    job(JobY, Y),
    supervised_by(JobX, SupervisorJob),
    supervised_by(JobY, SupervisorJob),
    X \= Y.

% iii. X é responsável por supervisionar mais de um cargo?
supervises_multiple_jobs(X) :-
    job(SupervisorJob, X),
    supervised_by(Job1, SupervisorJob),
    supervised_by(Job2, SupervisorJob),
    Job1 \= Job2.

% iv. X é supervisor do supervisor de Y?
supervisor_of_supervisor(X, Y) :-
    job(SupervisorJobX, X),
    job(JobY, Y),
    supervised_by(JobY, SupervisorJobY),
    supervised_by(SupervisorJobY, SupervisorJobX).
    