%define the flights, a simple line of flights for now
%flight(start city, end city, start time, flight duration)
flight(cityA, cityB, 0, 1).
%flight(cityA,cityD,0,1).
flight(cityB, cityC, 2, 2).
flight(cityC, cityD, 4, 3).
flight(cityD, cityE, 7, 20).
flight(cityE, cityA, 9, 5).

timeCheck(Start,Duration,End,LastEnd) :-
	nth0(0,LastEnd,LE),
	LE + Duration =< End,
	Start >= LE.

fly(From, To, Start, End) :- fly(From,To,Start,End,[],[Start]).
fly(From,To,_,End,_,LastEnd) :-
	flight(From,To,FlightStart,FlightDuration),
	timeCheck(FlightStart,FlightDuration, End,LastEnd).

fly(From, To, Start, End, Visited,LastEnd) :-
    flight(From, Through,FlightStart,FlightDuration),
    \+ memberchk(Through,Visited),
	timeCheck(FlightStart,FlightDuration,End,LastEnd),
    fly(Through,To,Start,End,[Through|Visited],[FlightStart+FlightDuration|LastEnd]),
    From \= To.
