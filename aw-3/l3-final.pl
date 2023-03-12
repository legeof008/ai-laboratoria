:-dynamic computer/5.

displayMenu:-
% Tu wszystko zgadza się do punktu 2 w pdfie
    write('1 - biezacy stan bazy danych'), nl,
    write('2 - dopisanie nowego komputera'), nl,
    write('3 - usuniecie komputera'), nl,
    write('4 - obliczenie sredniej ceny'), nl,
% Te rzeczy kompletnie się nie zbiegają
    write('5 - wyszukanie procesorów po nazwie'), nl,
    write('6 - wyszukanie procesorów po cenie nizszej niz podana'), nl,
    write('Liczba spoza indeksu - koniec programu'), nl, 
    nl,
    read(I),
    I > 0,
    menuOption(I),
    displayMenu.

displayMenu.

menuOption(1):-
    displayDB.

menuOption(2) :- 
    write('Podaj nazwe procesora:'), 
    read(ProcessorName),
    write('Podaj typ procesora:'), 
    read(ProcessorType), 
    write('Podaj taktowanie zegara (w GHz):'), 
    read(ClockFrequency), 
    write('Podaj rozmiar HDD:'), 
    read(HddSize), 
    write('Podaj cenę tej konfiguracji:'), 
    read(Price), 
    nl,
    assert(computer(ProcessorName, ProcessorType, ClockFrequency, HddSize, Price)).

menuOption(3) :- 
    write('Podaj nazwe procesora do usuniecia:'), 
    read(ProcessorName),
    retract(computer(ProcessorName,_)),
    ! ;
    write('Brak takiego procesora ...').

menuOption(4) :- 
    averagePrice.

menuOption(5) :-
    write('Podaj nazwe procesora do wyszukania'),
    read(ProcessorName),
    findall(computer(ProcessorName,ProcessorType,ClockFrequency,HddSize,Price), 
            computer(ProcessorName,
                        ProcessorType,
                        ClockFrequency,
                        HddSize,
                        Price),
            List),
    nl,
    length(List, ListLen),
    write('Takich elementow jest '),
    write(ListLen),
    nl,nl,
    displayComputerFromList(List,ListLen),
    nl.

menuOption(6) :-
    write('Podaj prog cenowy do wyszukania ponizej'),
    read(PriceCap),
    findall(computer(ProcessorName,ProcessorType,ClockFrequency,HddSize,Price), 
            (computer(ProcessorName,
                        ProcessorType,
                        ClockFrequency,
                        HddSize,
                        Price), Price < PriceCap),
            List),
    nl,nl,
    length(List, ListLen),
    write('Takich elementow jest '),
    write(ListLen),
    nl,nl,
    displayComputerFromList(List,ListLen),
    nl.

displayDB :- 
    write('Elementy bazy:'), 
    nl,
    computer(ProcessorName, ProcessorType, ClockFrequency, HddSize, Price),
    write(ProcessorName), 
    write(' '), 
    write(ProcessorType),
    write(' '),
    write(ClockFrequency), 
    write(' '), 
    write(HddSize), 
    write(' '), 
    write(Price),  
    nl, 
    fail.

displayDB :- 
    nl.

averagePrice :-
    findall(Price, computer(_,_,_,_,Price), List),
    sum(List, Sum, NumberOfDbEntries),
    AveragePrice is Sum / NumberOfDbEntries,
    write('Srednia cena zestawow:'),
    write(AveragePrice),
    nl,nl.

sum([],0,0).

sum([G|Og], Suma, N) :- 
    sum(Og, S1, N1),
    Suma is G + S1,
    N is N1+1.

displayComputerFromList([],0).
    
displayComputerFromList([Head|Tail],ListEntryIndexNext):-
    displayComputerFromList(Tail,ListEntryIndex),
    write(Head),
    nl,
    ListEntryIndexNext is ListEntryIndex + 1.


computer(debil,cc,cd,sad,4).
computer(debil,cadc,cdawdd,sawdad,3).
computer(debidl,cc,cd,sad,2).