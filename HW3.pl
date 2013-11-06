%define the flights, a simple line of flights for now
%flight(start city, end city, start time, flight duration)
flight(cityA, cityB, 0, 1).
flight(cityA,cityD,0,1).
flight(cityB, cityC, 1, 2).
flight(cityC, cityD, 2, 3).
flight(cityD, cityE, 3, 2).
flight(cityE, cityA, 4, 5).

timeCheck(Start,Duration,End,LastDuration) :-
	nth0(0,LastDuration,LD),
	LD + Duration =< End.

fly(From, To, Start, End) :- fly(From,To,Start,End,[],[Start]).
fly(From,To,_,End,_,LastDuration) :-
	flight(From,To,FlightStart,FlightDuration),
	timeCheck(FlightStart,FlightDuration, End,LastDuration).

fly(From, To, Start, End, Visited,LastDuration) :-
    flight(From, Through,FlightStart,FlightDuration),
    \+ memberchk(Through,Visited),
	timeCheck(FlightStart,FlightDuration,End,LastDuration),
    fly(Through,To,Start,End,[Through|Visited],[FlightStart+FlightDuration|LastDuration]),
    From \= To.
