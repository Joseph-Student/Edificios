
%[[1,2], N [2,1], S [1,2], E-O [2,1]] O-E
/*edificio([H|T],[C|R]).*/

% Este predicado verifica si la solucion dada es la correcta.
% Va a recibir 2 matrices (M1,M2), M1 son las vistas y M2 es la posible solucion.
checkSolution([N,S,E|Vs],M):- checkView(E,M), invertirMatriz(M,Oe), head(Vs,O), checkView(O,Oe),
							getColumns(M,Nr), checkView(N,Nr), invertirMatriz(Nr,Sr), checkView(S,Sr).

% Verifica las vista con su solucion.
checkViews([],[]).
checkViews([V|Vs],[S|Ss]):- checkView(V,S), checkViews(Vs,Ss).

% Verifica una vista con su respectiva fila de solucion
checkView(_,[]).
checkView(N,F):- viewEdifice(0,F,V), V == N.

% Predicado que devuelve cuantos edificios segun una perspectiva.
% Recibe el edificio anterior(Y), una perspectiva(P) y devuelve el numero de edificios que se ven(N).
viewEdifice(_,[],0).
%viewEdifice(Y,[X|Xs],N):- X < Y, viewEdifice(Y,Xs,R), N is R.
viewEdifice(Y,[X|Xs],N):- X > Y, viewEdifice(X,Xs,R), N is R + 1, !; viewEdifice(Y,Xs,N).

% Invierte una matriz
invertirMatriz([],[]).
invertirMatriz([X|Xs],[Y|Ys]):- invertir(X,Y), invertirMatriz(Xs,Ys).

% Invierte una lista.
invertir([X],[X]).
invertir([X|M],Z):- invertir(M,S), concatenar(S,[X],Z),!.

% concatena dos listas.
concatenar([],L,L).
concatenar([X|M],L,[X|Z]):- concatenar(M,L,Z).

% Obtiene la N columna de una matriz.
column([X|_],0,X):-!.
column([_|Xs],N,Ys):- M is N - 1, column(Xs,M,Ys),!.

% Obtine la primera columna de una matriz.
columns([],_,[]).
columns([X|Xs],N,[Y|Ys]):- column(X,N,Y), columns(Xs,N,Ys),!.

% Obtiene una matriz con todas las columnas.
getColumns([[]|_],[]).
getColumns(X,[Y|Ys]):- columns(X,0,Y), sacaPriMatriz(X,R), getColumns(R,Ys),!.

% Saca el primer elemento de una lista.
sacaPri([],[]).
sacaPri([_|M],M).

% Saca todos los primeros elemntos de una matriz.
sacaPriMatriz([],[]).
sacaPriMatriz([X|Xs],[Y|Ys]):- sacaPri(X,Y), sacaPriMatriz(Xs,Ys).

% Obtiene la cabeza de una lista.
head([X|_],X).

% Devuelve el tamaño de una lista
sizeList([],0).
sizeList([_|Xs],N):- sizeList(Xs,N1), N is N1 + 1.

% Tamaño de pisos de los edificios.
value(1).
value(2).
value(3).
value(4).
value(5).
value(6).
value(7).
value(8).
value(9).
value(10).

% Verifica si es una matriz.
list([X|_]):- value(M), X == M,!.


% Agrega el valor a la solucion.
addValue([],_,Num,[[Num]]).
addValue([H|T],Size,Num,L):- sizeList(H,Y), Y == Size, addValue(T,Size,Num,Z), (list(Z), concatenar([H],[Z],L); concatenar([H],Z,L)),!.
addValue([H|_],Size,Num,[L]):- sizeList(H,Y), Y < Size, concatenar(H,[Num],L).


% Si todos los elementos de la lista son diferentes entre si.
diferente(_,[]).
diferente(N,[H|T]):- N \== H, diferente(N,T),!.

/**
 * Predicado para aplicar 2 reglas
 * 1.- los edificios que se ven no puede ser mayor a la vista dada.
 * 2.- en la columna no puede haber un edificio del mismo tamaño.
 * Recibira la vista de una fila(V) y su respectiva columna(C).
 **/

%rule(V,F,C,N):- value(N), ponervalor(), diferente(F), diferente(C).

% Comprueba que el valor dado se puede colocar.
comprobarValor(V,F,C,N):- diferente(N,F), diferente(N,C), append(F,[N],L), viewEdifice(0,L,T), T =< V.


%resolver([V1,Vs],S):- 