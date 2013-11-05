%define the cities, a simple line of cities for now
%connect(cityA, cityB).
%connect(cityB, cityC).
%connect(cityC, cityD).
%connect(cityD, cityE).

%define the flights, a simple line of flights for now
flight(cityA, cityB, 0, 1).
flight(cityB, cityC, 1, 2).
flight(cityC, cityD, 2, 3).
flight(cityD, cityE, 3, 4).
flight(cityE, cityA, 4, 5).

fly(From, To, Start, End) :- fly(From,To,Start,End,[]).
fly(From,To,_,_,_) :- flight(From,To,_,_).

fly(From, To, Start, End, Visited) :-
    flight(From, Through,_,_),
    \+ memberchk(Through,Visited),
    fly(Through,To,Start,End,[Through|Visited]),
    From \= To.
