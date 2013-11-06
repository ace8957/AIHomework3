%define the flights, a simple line of flights for now
%flight(start city, end city, start time, flight duration)
flight(cityA, cityB, 0, 1).
flight(cityA,cityD,0,1).
flight(cityB, cityC, 1, 2).
flight(cityC, cityD, 2, 3).
flight(cityD, cityE, 3, 7).
flight(cityE, cityA, 4, 5).

timeCheck(Start,Duration,End,Time) :-
	Start + Duration =< End.

fly(From, To, Start, End) :- fly(From,To,Start,End,[], Time).
fly(From,To,_,End,_,Time) :-
	flight(From,To,FlightStart,FlightDuration),
	timeCheck(FlightStart,FlightDuration, End, Time).

fly(From, To, Start, End, Visited,Time) :-
    flight(From, Through,FlightStart,FlightDuration),
    \+ memberchk(Through,Visited),
	timeCheck(FlightStart,FlightDuration,End,Time),
    fly(Through,To,Start,End,[Through|Visited],Time),
    From \= To.
