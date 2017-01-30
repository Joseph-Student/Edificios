
%[[1,2], N [2,1], S [1,2], E-O [2,1]] O-E
/*edificio([H|T],[C|R]).*/

% Este predicado verifica si la solucion dada es la correcta.
% Va a recibir 2 matrices (M1,M2), M1 son las vistas y M2 es la posible solucion.
/*checkSolution(M1,M2).*/

% Verifica una vista con solucion solucion.
checkView([],[]).
checkView([V|Vs],[S|Ss]):- viewEdifice(0,S,N), V == N, checkView(Vs,Ss). 

% Predicado que devuelve cuantos edificios segun una perspectiva.
% Recibe el edificio anterior(Y), una perspectiva(P) y devuelve el numero de edificios que se ven(N).
viewEdifice(_,[],0).
%viewEdifice(Y,[X|Xs],N):- X < Y, viewEdifice(Y,Xs,R), N is R.
viewEdifice(Y,[X|Xs],N):- X > Y, viewEdifice(X,Xs,R), N is R + 1,!; viewEdifice(Y,Xs,N).

% Invierte una lista.
invertir([X],[X]).
invertir([X|M],Z):- invertir(M,S), concatenar(S,[X],Z),!.

% concatena dos listas.
concatenar([],L,L).
concatenar([X|M],L,[X|Z]):- concatenar(M,L,Z).

% Obtiene la primera columna de una matriz.
column([],[]).
column([X|Xs],[Y|Ys]):- head(X,Y), column(Xs,Ys).

% Obtiene una matriz con todas las columnas.
getColumns([[]|_],[]).
getColumns([X|Xs],[Y|Ys]):- column([X|Xs],Y), sacaPriMatriz([X|Xs],R), getColumns(R,Ys),!.

% Saca el primer elemento de una lista.
sacaPri([],[]).
sacaPri([_|M],M).

% Saca todos los primeros elemntos de una matriz.
sacaPriMatriz([],[]).
sacaPriMatriz([X|Xs],[Y|Ys]):- sacaPri(X,Y), sacaPriMatriz(Xs,Ys).

% Obtiene la cabeza de una lista.
head([X|_],X).

/**
 * Predicado para aplicar 2 reglas
 * 1.- los edificios que se ven no puede ser mayor a la vista dada.
 * 2.- en la columna no puede haber un edificio del mismo tamaño.
 * Recibira la vista de una fila(V) y su respectiva columna(C).
 **/
/*rule(V,C).*/

