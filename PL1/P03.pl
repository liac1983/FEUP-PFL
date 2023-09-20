% Red Bull Air Race

% 3.a 
pilot(lamb).
pilot(besenyei).
pilot(chambliss).
pilot(maclean).
pilot(mangold).
pilot(jones).
pilot(bonhomme).

team(lamb,breitling).
team(besenyei,red_bull).
team(chambliss,red_bull).
team(maclean,mediterranean_racing).
team(mangold,cobra).
team(jones,matador).
team(bonhomme,matador).

aviao(lamb, mx2).
aviao(besenyei, edge540).
aviao(chambliss, edge540).
aviao(maclean, edge540).
aviao(mangold, edge540).
aviao(jones, edge540).
aviao(bonhomme, edge540).

circuit(istambul).
circuit(budapest).
circuit(porto).

winning_pilot(jones, porto).
winning_pilot(mangold, budapest).
winning_pilot(mangold, istambul).

gates(istambul, 9).
gates(budapest, 6).
gates(porto, 5).

% Uma equipa ganha a corrida se 1 dos seus pilotos ganhar a corrida
winning_team(C,E) :- winning_pilot(P,C), team(P, E)