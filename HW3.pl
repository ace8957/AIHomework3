%define the flights, a simple line of flights for now
%flight(start city, end city, start time, flight duration)
flight(cityA, cityB, 0, 1).
%flight(cityA,cityD,0,1).
flight(cityB, cityC, 2, 2).
flight(cityC, cityD, 4, 3).
flight(cityD, cityE, 7, 20).
flight(cityE, cityA, 9, 5).

%Check to make sure the time entered is valid.
%The arrival time of the last leg of the flight is stored in the list LastEnd.
%Note that the builtin function nth0() is used to get the 0th element from LastEnd.
%This function will check for the arrival time (Start+Duration) being less than
%	or equal to the final arrival deadline.
%The function will also check to ensure that you are not trying to get on a
%	flight which departs before the previous leg of your flight arrives.
%Note that for the purposes of this assignment, this function does not include
%	any stopover time requirment. Thus, the user is assumed to be able to board
%	a flight which departs at the same time the previous flight lands.
timeCheck(Start,Duration,End,LastEnd) :-
	nth0(0,LastEnd,LE),
	LE + Duration =< End,
	Start >= LE.

%define the original form of the call to fly()
%the user will make this call
fly(From, To, Start, End) :- fly(From,To,Start,End,[],[Start]).

%This defines the base case for fly, note that it is important that
%the time requirements still be met, or the last leg of the flight
%could result in you arriving late at your destination.
fly(From,To,_,End,_,LastEnd) :-
	flight(From,To,FlightStart,FlightDuration),
	timeCheck(FlightStart,FlightDuration, End,LastEnd).

%This is the standard case for fly(). It takes the following terms:
%From - The city to check for flights from
%To - The destination city
%Start - The start time you wish to fly from (entered by user)
%End - The time by which you must arrive at your destination.
%Visited - The list of cities which have been visited. Used to prevent cycles.
%LastEnd - The list containing the arrival time for the last leg of the flight.
fly(From, To, Start, End, Visited,LastEnd) :-
    flight(From, Through,FlightStart,FlightDuration),
    \+ memberchk(Through,Visited),
	timeCheck(FlightStart,FlightDuration,End,LastEnd),
    fly(Through,To,Start,End,[Through|Visited],[FlightStart+FlightDuration|LastEnd]),
    From \= To.
