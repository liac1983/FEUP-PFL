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

% a
% i. O Sisnando chefia analistas? Se sim, qual o seu cargo?
% ii. O cargo de tecnico e chefiado por que cargo? E a que entidade responde o seu superior?
% iii. Quem e chefiado pelo supervisor e qual o seu cargo?
% iv. Qual e o cargo dos chefiados pelo diretor excetuado a felismina?

% b
% i. X=supervisor
% ii. X=engenheiro, Y=supervisor
% iii. J=analista, P=leonilde
% iv. P=supervisor_chefe

% c
chefe(X, Y) :- cargo(Cx, X), cargo(Cy, Y), chefiado_por(Cx, Cy).
responsavel_por(X, Y) :- chefiado_por(Y, X).