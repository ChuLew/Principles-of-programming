%===============
%helper functions
%===============

stateMove([read(A, B)|Xs], [Input|Is], Name, Leftover) :-
   (A = Input, Name = B, Leftover = Is);stateMove(Xs, [Input|Is], Name, Leftover).
stateMove([move(A)|Xs], [Input|Is], Name, Leftover) :-
   (Name = A, Leftover = [Input|Is]); stateMove(Xs, [Input|Is], Name, Leftover).

stateWatch([]).
stateWatch([A|As]) :-
    A = read(_, _),stateWatch(As).

%==========
%end of helper functions
%==========

dfa([]).
dfa([state(_, A, _)|Xs]) :-
   stateWatch(A),
   dfa(Xs).

fa_state(Name, [state(C, M, A)|Xs], R) :-
   ( Name = C -> R = state(C, M, A); fa_state(Name, Xs, R)).

next_state(state(_, A, _), Input, Name, Leftover) :-
   stateMove(A, Input, Name, Leftover).

accepts([State|States], Input) :- accepts(State, [State|States], Input).
accepts(Start, [State|States], [Input|Is]) :-
   next_state(Start, [Input|Is], Name, Leftover),fa_state(Name, [State|States], Result), accepts(Result, [State|States], Leftover).
accepts(state(_, _, yes), _, []).

demo(String) :-
	accepts(
		[ state(even,  [read(0, even), read(1, other)], yes)
	  , state(odd,   [read(0, even), read(1, odd), read(1, other)], no)
 	  , state(other, [move(odd), read(0, even), read(1, other)], no)],
    String
  ).
