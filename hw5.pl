:- use_module(library(clpfd)).
:-use_module(library(dif)).

tree(nil).
tree(b(L,_,R)):-
	tree(L),
	tree(R).
	
mirror(nil, nil).
mirror(b(V, Q, Z), R) :- tree(b(V, Q, Z)), mirror(Z, A),
    mirror(V, B), R = (b(A, Q, B)).
mirror(L, b(V, Q, Z)) :- tree(b(V, Q, Z)),  mirror(Z, A),
    mirror(V, B), L = (b(A, Q, B)).

echo([],[]).
echo([X|P],[X,X|H]) :-
    echo(P,H).

unecho([], []).
unecho([A], [A]) :- !.
unecho([G, N|Y], R) :- R = [G|X],
    (   dif(G, N) ->  unecho([N|Y], X) ;
    	unecho(Y, X)
    ).



slist( []) .
slist( [_]) .
slist( [X,Y|Z] ) :- X =< Y , slist( [Y|Z] ) .

sselect(X, [], [X]). 
sselect(X, [Y | Other], [X,Y | Other]) :- X @< Y.
sselect(X, [Y | Other1], [Y | Other2]) :- sselect(X, Other1, Other2).
