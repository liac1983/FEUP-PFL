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

% 1.c
father(F,C):-
    male(F),
    parent(F,C).

grandparent(GP, C):-
    parent(GP, P),
    parent(P,C).

gtandmother(GM, C):-
    female(GM),
    grandparent(GM, C).

% irmãos 
siblings(A,B):-
    parent(P,A),
    parent(P,B),
    A \= B.

cousins(A, B):-
    parent(PA, A),
    parent(PB, B),
    siblings(PA, PB),
    A \= B.

% tio 
uncle(U, N):-
    male(U),
    parent(P,N),
    siblings(U, P).

descendent(D, A):-
    parent(A, D).
descendent(D,A):-
    parent(P, D),
    descendent(P,A).

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

% 2.c
is_student_of(X,y):-
    teaches(Y, Course),
    attends(X, Course).

student_of_both_professors(Student, Prof1, Prof2):-
    teaches(Prof1, Course1),
    teaches(Prof2, Course2),
    attends(Student, Course1),
    attends(Student, Course2),
    Prof1 \= Prof2.

colleagues(X,Y):-   
    attends(X, Course),
    attends(Y, Course),
    X \= Y.

student_in_multiple_courses(Student):-
    attends(Student, Course1),
    attends(Student, Course2),
    Course1 \= Course2.

% 3
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

team_wins(Team, Race) :-
    team(Pilot, Team),
    won(Pilot, Race).

pilot_with_multiple_wins(Pilot):-
    won(Pilot, Circuit1),
    won(Pilot, Circuit2),
    Circuit1 \= Circuit2.

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

direct_supervisor(X; Y):-   
    job(jobX, X),
    job(JobY, Y),
    supervised_by(jobY, jobX).

% X e Y são supervisionados por pessoas com o mesmo cargo
same_supervisor_job(X, Y):-
    job(jobX, X),
    job(jobY, Y),
    supervised_by(JobX, SupervisorJob),
    supervised_by(JobY, SupervisorJob),
    Job1 \= Job2.

% X é responsável por supervisionar mais de um cargo
supervises_multiple_jobs(X):-
    job(SupervisorJob, X),
    supervised_by(Job1, SupervisorJob),
    supervised_by(Job2, SupervisorJob),
    Job1 \= Job2.

% X é supervisor do supervisor de Y
supervisor_of_supervisor(X, Y):-    
    job(SupervisorJobX, X),
    job(jobY, Y),
    supervised_by(JobY, SupervisorJobY),
    supervised_by(SupervisorJobY, SupervisorJobX).

