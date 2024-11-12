% Teachers and Students

% 2.a 

teaches(algorithms, adalberto).
teaches(databases, bernardete).
teaches(compilers, capitolino).
teaches(statistics, diogenes).
teaches(networks, ermelinda).

attends(algorithms, alberto).
attends(algorithms, bruna).
attends(algorithms, cristina).
attends(algorithms, diogo).
attends(algorithms, eduarda).

attends(databases,antonio).
attends(databases,bruno).
attends(databases,cristina).
attends(databases,duarte).
attends(databases,eduardo).

attends(compilers,alberto).
attends(compilers,bernardo).
attends(compilers,clara).
attends(compilers,diana).
attends(compilers,eurico).

attends(statistics,antonio).
attends(statistics,bruna).
attends(statistics,claudio).
attends(statistics,duarte).
attends(statistics,eva).

attends(networks,alvaro).
attends(networks,beatriz).
attends(networks,claudio).
attends(networks,diana).
attends(networks,eduardo).

% 1.c

% rules

student(X,Y) :- attends(UC,X), teaches(UC,Y).
professor(X,Y) :- student(Y,X).

colega(X, Y) :- attends(UC, X), attends(UC, Y), (X \= Y).
colega(X, Y) :- teaches(X, _), teaches(Y, _), (X \= Y).