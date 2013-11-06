%define the cities, a simple line of cities for now
%connect(cityA, cityB).
%connect(cityB, cityC).
%connect(cityC, cityD).
%connect(cityD, cityE).

%define the flights, a simple line of flights for now
%flight(start city, end city, start time, flight duration)
flight(cityA, cityB, 0, 1).
flight(cityA,cityD,0,1).
flight(cityB, cityC, 1, 2).
flight(cityC, cityD, 2, 3).
flight(cityD, cityE, 3, 4).
flight(cityE, cityA, 4, 5).

timeCheck(Start,End,Time) :-
	Duration is End - Start,
	TempTime is Time + Duration,
	TempTime =< End,
	Time is TempTime.

fly(From, To, Start, End) :- fly(From,To,Start,End,[], Time).
fly(From,To,_,_,_,_) :- flight(From,To,_,_).

fly(From, To, Start, End, Visited,Time) :-
    flight(From, Through,FlightStart,FlightDuration),
    \+ memberchk(Through,Visited),
	timeCheck(FlightStart,FlightDuration,Time),
    fly(Through,To,Start,End,[Through|Visited],Time),
    From \= To.
