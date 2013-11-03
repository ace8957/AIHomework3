%define the cities, a simple line of cities for now
connect(cityA, cityB).
connect(cityB, cityC).
connect(cityC, cityD).
connect(cityD, cityE).

%define the flights, a simple line of flights for now
flight(cityA, cityB, 0, 1).
flight(cityA, cityD, 0, 1).
flight(cityB, cityC, 1, 2).
flight(cityC, cityD, 2, 3).
flight(cityD, cityE, 3, 4).
flight(cityE, cityA, 4, 5).

%define the fly function
%fly(A,B,start,end) :-
%   connect(a, Connections). 
%fly(A) :-
%    connect(A,B),
%    connect(B, cityE).

%fly(A,B, Result) :-
%    r = connect(A,X),
%    (r = true ->
%        Result = true
%    ;
%        fly(X,B,Result)).

fly(From, To) :- fly(From,To,[]).
fly(From,To,_) :- connect(From,To).

fly(From, To, Visited) :-
    connect(From, Through),
    \+ memberchk(Through,Visited),
    fly(Through,To, [Through|Visited]),
    From \= To.
