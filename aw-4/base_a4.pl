:- dynamic xpositive/2.
:- dynamic xnegative/2. 

 animal_is(cheetah) :-
    it_is(mammal) ,
    it_is(carnivore) ,
    positive(has,tawny_color) ,
    positive(has,black_spots).

 animal_is(tiger) :-
    it_is(mammal) ,
    it_is(carnivore) ,
    positive(has, tawny_color) ,
    positive(has, black_stripes).

 animal_is(giraffe) :-
    it_is(ungilate) ,
    positive(has,long_neck) ,
    positive(has,long_legs) ,
    positive(has,dark_spots).

 animal_is(zebra) :-
    it_is(ungulate) ,
    positive(has,black_stripes).

 animal_is(ostrich) :-
    it_is(bird) ,
    negative(does,fly) ,
    positive(has,long_neck) ,
    positive(has,long_legs) ,
    positive(has,black_and_white_color).

 animal_is(penguin) :-
    negative(does,fly) ,
    positive(does,swim),
    positive(has,black_and_white_color).

 animal_is(albatross) :-
    it_is(bird) ,
    positive(does,fly_well). 


it_is(mammal) :-
    positive(has,hair).

it_is(mammal) :-
    positive(does,give_milk). 

it_is(mammal) :-
    positive(does,give_birth).

it_is(mammal) :-
    negative(does,fly).


it_is(bird) :-
    positive(has,feathers).

it_is(bird) :-
    positive(does,fly) ,
    positive(does,lay_eggs) ,
    positive(has,beak) ,
    negative(does,swim).


it_is(carnivore) :-
    positive(does,eat_meat).

it_is(carnivore) :-
    positive(has,pointed_teeth) ,
    positive(has,claws) ,
    positive(has,forward_eyes).

it_is(ungulate) :-
    it_is(mammal) ,
    positive(has,hooves).

it_is(ungulate) :-
    it_is(mammal) ,
    positive(does,chew_cud). 


positive(X,Y) :- 
    xpositive(X,Y),
    !.

positive(X,Y) :-
    not(xnegative(X,Y)) ,
    ask(X,Y,yes).

negative(X,Y) :-
    xnegative(X,Y),!.

negative(X,Y) :-
    not(xpositive(X,Y)) ,
    ask(X,Y,no). 


ask(X,Y,yes) :-
    write(X),
    write(' it '),
    write(Y), 
    write('\n'),
    read(Reply),
    sub_string(Reply,0,1,_,'y'),
    !,
    remember(X,Y,yes).
   
ask(X,Y,no) :-
    write(X), 
    write(' it '),
    write(Y), 
    write('\n'),
    read(Reply),
    sub_string(Reply,0,1,_, 'n'),
    !,
    remember(X,Y,no).

remember(X,Y,yes) :-
    asserta(xpositive(X,Y)).
    remember(X,Y,no) :-
    asserta(xnegative(X,Y)). 

run :-
    animal_is(X),!,
    write('\nYour animal may be a(n) '),write(X),
    nl,nl,clear_facts.
run :-
    write('\nUnable to determine what'),
    write('your animal is.\n\n'),clear_facts. 
    
clear_facts :-
    retract(xpositive(_,_)),fail.
    clear_facts :-
    retract(xnegative(_,_)),fail.
    clear_facts :-
    write('\n\nPlease press the space bar to exit\n'). 