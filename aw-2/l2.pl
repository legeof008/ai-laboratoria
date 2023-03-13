ws(bielany,zoliborz,1).
ws(bielany,bemowo,2).
ws(bemowo,zoliborz,4).
ws(bemowo,wola,2).
ws(bemowo,wlochy,4).
ws(wola,zoliborz,2).
ws(wola,wlochy,5).
ws(wola,ochota,1).
ws(wola,srodmiescie,2).
ws(ochota,srodmiescie,2).
ws(ochota,mokotow,2).
ws(ochota,wlochy,5).
ws(wlochy,mokotow,4).
ws(wlochy,ursynow,6).
ws(ursynow,mokotow,1).
ws(ursynow,wilanow,6).
ws(mokotow,wilanow,3).
ws(mokotow,srodmiescie,1).
ws(srodmiescie,zoliborz,1).
ws(bialoleka,bielany,2).
ws(pragaN,zoliborz,7).
ws(bialoleka,pragaN,3).
ws(pragaN,srodmiescie,7).
ws(pragaN,pragaS,3).
ws(pragaS,srodmiescie,7).
ws(pragaS,mokotow,7).
ws(pragaS,wawer,8).
ws(wawer,wilanow,10).

avoid([wlochy]).
go(Here,There) :- route(Here, There,[Here],0). 

neighborroom(X,Y,C):- ws(X,Y,C).
neighborroom(X,Y,C):- ws(Y,X,C).

route(I,I,VisitedRooms,C) :-
    member(srodmiescie,VisitedRooms),
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