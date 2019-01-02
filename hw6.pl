%ALL MODES ATTEMPTED PLEASE GRADE EVERY MODE
%==============================================
:- use_module(library(clpfd)).
:- use_module(library(yall)).

% Meta-Predicates
% ===============

transit(Rel, S, T) :- call(Rel,S,T).
transit(Rel, S, T) :- call(Rel,S,X), transit(Rel,X,T).
transit2(Rel, S, T) :- call(Rel,S,X), (T = X; transit2(Rel,X,T)).
transit3(Rel, S, T) :- (X = S; transit3(Rel,S,X)), call(Rel,X,T).
transit4(Rel, S, T) :- call(Rel, X, T), (S = X; transit4(Rel, S, X)).
flip(Rel, X, Y) :- call(Rel, Y, X).

%length helper function
len([],LenResult):-
	LenResult is 0.
len([_|Y],LenResult):-
	len(Y,L),
	LenResult is L + 1.
%======================
%last helper function

end(X,[X]).
end(X,[_|Z]):- end(X,Z).
%======================
%confirm helper function

confirm(_,[]).
confirm(_,[_]).
confirm(Rel,[Head,Next|Tail]):-
	call(Rel,Head,Next),
	confirm(Rel,[Next|Tail]).

%======================
reverse(List, Rev) :-
        reverse(List, Rev, []).

reverse([], L, L).
reverse([H|T], L, ThusFar) :-
        reverse(T, L, [H|ThusFar]).

append([], X, X).
append([H|T], X, [H|S]) :- append(T, X, S).

member(X, [X|_]).
member(X, [_|Xs]) :- member(X, Xs).

forbidden(_,X,X,T,P) :- not(member(X,T)), reverse([X|T],P).
forbidden(Rel,X,Z,T,P) :- not(member(X,T)), call(Rel,X,Y), forbidden(Rel,Y,Z,[X|T],P).
forbidden(Rel,X,Y,P) :- forbidden(Rel,X,Y,[],P).


path(Rel,Source,Target,[Head,Next|Tail],Length):-
	Head == Source,
	Source = Head,
	end(Target,[Head,Next|Tail]),
	confirm(Rel,[Head,Next|Tail]),
	len([Head,Next|Tail],Result),
	Result == Length.

path(Rel,Source,Target,[Head,Next|Tail],Length):-
	forbidden(Rel,Source,Target,X),
	[Head,Next|Tail] = X,
	Source = Head,
	end(Z,[Head|Tail]),
	Target = Z,
	len([Head,Next|Tail],Result),
	Length = Result,
	confirm(Rel,[Head,Next|Tail]).


% Family Data
% ===========
friend(alice, bob).
friend(bob, carol).
friend(carol, daniel).
friend(carol, eve).

friends(A,B) :- friend(A,B); friend(B,A).

% Shape Data
% ===========

is_a(parallelogram, quadrilateral).
	is_a(trapezoid, quadrilateral).
	is_a(rhombus, parallelogram).
	is_a(rectangle, parallelogram).
	is_a(square, rhombus).
	is_a(square, rectangle).