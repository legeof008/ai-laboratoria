:-dynamic osoba/2.
wykPrg:-
% Tu wszystko zgadza się do punktu 2 w pdfie
    write('1 - biezacy stan bazy danych'), nl,
    write('2 - dopisanie nowego komputera'), nl,
    write('3 - usuniecie komputera'), nl,
    write('4 - obliczenie sredniej ceny'), nl,
% Te rzeczy kompletnie się nie zbiegają
    write('5 - uzupelnienie bazy o dane zapisane w pliku'), nl,
    write('6 - zapisanie bazy w pliku'), nl,
    write('0 - koniec programu'), nl, nl,
    read(I),
    I > 0,
    opcja(I),
    wykPrg.

wykPrg.

opcja(1) :- 
    wyswietl.

opcja(2) :- 
    write('Podaj imie:'), 
    read(Imie),
    write('Podaj wiek:'), 
    read(Wiek), 
    nl,
    assert(osoba(Imie, Wiek)).

opcja(3) :- 
    write('Podaj imie usuwanej osoby:'), 
    read(Imie),
    retract(osoba(Imie,_)),! ;
    write('Brak takiej osoby').

opcja(4) :- 
    sredniWiek.
opcja(5) :- 
    write('Podaj nazwe pliku:'), 
    read(Nazwa),
    exists_file(Nazwa), 
    !, 
    consult(Nazwa);
    write('Brak pliku o podanej nazwie'), 
    nl.

opcja(6) :- 
    write('Podaj nazwe pliku:'), 
    read(Nazwa),
    open(Nazwa, write, X), 
    zapis(X), 
    close(X).

opcja(_) :- 
    write('Zly numer opcji'), 
    nl.

wyswietl :- 
    write('elementy bazy:'), 
    nl,
    osoba(Imie, Wiek),
    write(Imie), 
    write(' '), 
    write(Wiek), 
    nl, 
    fail.

wyswietl :- 
    nl.

sredniWiek :- 
    findall(Wiek, osoba(_,Wiek), Lista),
    suma(Lista, Suma, LiczbaOsob),
    SredniWiek is Suma / LiczbaOsob,
    write('Sredni wiek:'), 
    write(SredniWiek), 
    nl, 
    nl.

zapis(X) :- 
    osoba(Imie, Wiek),
    write(X, 'osoba('),
    write(X, Imie),
    write(X, ','), 
    write(X, Wiek),
    write(X, ').'), 
    nl(X), 
    fail.

zapis(_) :- 
    nl.

suma([],0,0).

suma([G|Og], Suma, N) :- 
    suma(Og, S1, N1),
    Suma is G + S1,
    N is N1+1.

%osoba(andrzej, 25).
%osoba(agnieszka, 5). 
%osoba(ewa, 30). 