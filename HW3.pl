%Adam Wilford
%7 November, 2013
%Flight Timetable checking.
%User's guide:
%Interact with the program by making queries of the following form:
%	fly(from, to, start, end).
%	These queries will check to see if a flight or series of flights is
%	available which will allow the user to travel from the "from" city
%	to the "to" city during the time range defined by start and end.
%Notes on input:
%	The names of the 5 cities are cityA, cityB, cityC, cityD, and cityE.
%	Time inputs must be integers in the range 0-23
%Note: as specified in the project requirements, this program does not support
%	time spans of greater than one day. That is, handling of flights or
%	iterneraries which span midnight (hour 0) are not supported.

%Enter facts in the knowledge base.
%Note that times must be integers between 0 and 23 as currently defined.
%flight(start city, end city, start time, flight duration)

%flights out of cityA
flight(cityA, cityB, 0, 1).
flight(cityA, cityC, 1, 1).
flight(cityA, cityD, 0, 3).
flight(cityA, cityB, 4, 1).
flight(cityA, cityB, 12, 4).

%flights out of cityB
flight(cityB, cityA, 0, 1).
flight(cityB, cityA, 11, 1).
flight(cityB, cityC, 13, 3).
flight(cityB, cityD, 7, 4).
flight(cityB, cityE, 8, 3).

%flights out of cityC
flight(cityC, cityA, 15, 1).
flight(cityC, cityE, 9, 2).
flight(cityC, cityB, 11, 4).
flight(cityC, cityD, 12, 6).
flight(cityC, cityE, 16, 1).

%flights out of cityD
flight(cityD, cityA, 0, 1).
flight(cityD, cityE, 1, 2).
flight(cityD, cityC, 2, 3).
flight(cityD, cityC, 8, 8).
flight(cityD, cityE, 9, 5).

%flights out of cityE
flight(cityE, cityA, 11, 1).
flight(cityE, cityB, 12, 2).
flight(cityE, cityC, 14, 7).
flight(cityE, cityD, 1, 3).
flight(cityE, cityD, 3, 4).

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
%Note also that this function assumes that the user will want to takeoff and arrive
%	at their destination on the same day. Thus, it does not support midnight rollover.
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
