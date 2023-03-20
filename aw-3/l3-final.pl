:-dynamic computer/5.

display_menu:-
    write('1 - biezacy stan bazy danych'), nl,
    write('2 - dopisanie nowego komputera'), nl,
    write('3 - usuniecie komputera'), nl,
    write('4 - obliczenie sredniej ceny'), nl,
    write('5 - wyszukanie procesorów po nazwie'), nl,
    write('6 - wyszukanie procesorów po cenie nizszej niz podana'), nl,
    write('7 - uzupelnienie bazy z pliku o podanej nazwie'), nl,
    write('8 - zapisanie bazy w pliku'), nl,
    write('Liczba spoza indeksu - koniec programu'), nl, 
    nl,
    read(I),
    I > 0,
    menu_option(I),
    display_menu.

display_menu.

menu_option(1):-
    display_db.

menu_option(2) :- 
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

menu_option(3) :- 
    write('Podaj nazwe procesora do usuniecia:'), 
    read(ProcessorName),
    retract(computer(ProcessorName,_,_,_,_)),
    ! ;
    write('Brak takiego procesora ...').

menu_option(4) :- 
    average_price.

menu_option(5) :-
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
    display_computer_from_list(List,ListLen),
    nl.

menu_option(6) :-
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
    display_computer_from_list(List,ListLen),
    nl.

menu_option(7) :- 
    write('Podaj nazwe pliku:'), 
    read(FileName),
    exists_file(FileName), 
    !, 
    consult(FileName);
    write('Brak pliku o podanej nazwie'), 
    nl.

menu_option(8) :- 
    write('Podaj nazwe pliku:'), 
    read(FileName),
    open(FileName, write, X), 
    save_to_file(X), 
    close(X).
menu_option(_) :- 
    write('Zly numer opcji'), nl.

display_db :- 
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

display_db :- 
    nl.

average_price :-
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

display_computer_from_list([],0).
    
display_computer_from_list([Head|Tail],ListEntryIndexNext):-
    display_computer_from_list(Tail,ListEntryIndex),
    write(Head),
    nl,
    ListEntryIndexNext is ListEntryIndex + 1.

save_to_file(X) :- 
    computer(ProcessorName, ProcessorType,ClockFrequency,HddSize,Price),
    write(X, 'computer('),
    write(X, ProcessorName),
    write(X, ','), 
    write(X, ProcessorType),
    write(X, ','), 
    write(X, ClockFrequency),
    write(X, ','), 
    write(X, HddSize),
    write(X, ','), 
    write(X, Price), 
    write(X, ').'), 
    nl(X), 
    fail.
    
save_to_file(_) :- 
    nl.
