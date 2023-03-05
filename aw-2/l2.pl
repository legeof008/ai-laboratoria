ws(bielany,zoliborz,1).
ws(bielany,bemowo,1).
ws(bemowo,zoliborz,1).
ws(bemowo,wola,1).
ws(bemowo,wlochy,1).
ws(wola,zoliborz,1).
ws(wola,wlochy,1).
ws(wola,ochota,1).
ws(wola,srodmiescie,1).
ws(ochota,srodmiescie,1).
ws(ochota,mokotow,1).
ws(ochota,wlochy,1).
ws(wlochy,mokotow,1).
ws(wlochy,ursynow,1).
ws(ursynow,mokotow,1).
ws(ursynow,wilanow,1).
ws(mokotow,wilanow,1).
ws(mokotow,srodmiescie,1).
ws(srodmiescie,zoliborz,1).
ws(bialoleka,bielany,1).
ws(pragaN,zoliborz,1).
ws(bialoleka,pragaN,1).
ws(pragaN,srodmiescie,1).
ws(pragaN,pragaS,1).
ws(pragaS,srodmiescie,1).
ws(pragaS,mokotow,1).
ws(pragaS,wawer,1).
ws(wawer,wilanow,1).

avoid([wlochy]).
go(Here,There) :- route(Here, There,[Here],0). 

neighborroom(X,Y,C):- ws(X,Y,C).
neighborroom(X,Y,C):- ws(Y,X,C).

route(I,I,VisitedRooms,C) :-
    reverse(VisitedRooms,VisitedRoomsRealPath),
    write(VisitedRoomsRealPath),
    nl,
    write(C),
    nl.

route(Room,Way_out,VisitedRooms,Cold) :-
    neighborroom(Room,NextRoom,C),
    avoid(DangerousRooms),
    \+ member(NextRoom,DangerousRooms),
    \+ member(NextRoom,VisitedRooms),
    Cplus is Cold + C,
    route(NextRoom,Way_out,[NextRoom|VisitedRooms],Cplus).

member(X,[X|_]).
member(X,[_|H]) :- member(X,H).