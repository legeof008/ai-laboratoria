:- dynamic xpositive/2.
:- dynamic xnegative/2.

language_is(c_lang):-
    it_is(compiled),
    it_is(native),
    it_is(structural),
    it_is(declarative),
    it_is(manually_memory_allocated_only).

language_is(cpp_lang):-
    it_is(compiled),
    it_is(native),
    it_is(objectively_oriented),
    it_is(declarative),
    it_is(garbage_collected).

language_is(python):-
    it_is(interpreted),
    it_is(objectively_oriented),
    it_is(declarative),
    it_is(garbage_collected).

language_is(java_lang):-
    it_is(compiled),
    it_is(managed),
    it_is(objectively_oriented),
    it_is(declarative),
    it_is(garbage_collected),
    positive(has,oracle_behind_it).

language_is(rust_lang):-
    it_is(compiled),
    it_is(native),
    it_is(objectively_oriented),
    it_is(imperative).

language_is(js_lang):-
    it_is(compiled),
    it_is(managed),
    it_is(objectively_oriented),
    it_is(imperative),
    positive(has,nothing_to_do_with_suns_java).

language_is(c_plotek_lang):-
    it_is(compiled),
    it_is(managed),
    it_is(objectively_oriented),
    it_is(declarative),
    it_is(garbage_collected),
    positive(has,microsoft_behind_it).

language_is(html):-
    it_is(interpreted),
    it_is(imperative),
    negative(is,turing_complete).

language_is(pascal):-
    it_is(compiled),
    it_is(managed),
    it_is(objectively_oriented),
    it_is(declarative),
    it_is(garbage_collected),
    positive(has, turbo_in_compiler_name).

language_is(haskell):-
    it_is(compiled),
    it_is(native),
    it_is(functional),
    it_is(imperative),
    it_is(garbage_collected).

it_is(compiled) :-
    positive(has,compiler).

it_is(interpreted) :-
    positive(has,interpreter).

it_is(native) :-
    negative(has,runtime).

it_is(managed) :-
    positive(has,runtime).

it_is(garbage_collected) :-
    positive(has,garbage_collector).

it_is(manually_memory_allocated_only) :-
    negative(has,garbage_collector),
    positive(can,allocate_memory_programatically).

it_is(objectively_oriented) :-
    positive(has,objects),
    positive(has,inheritence).

it_is(functional) :-
    positive(hasnt,variables).

it_is(structural) :-
    negative(has,objects).

it_is(declarative) :-
    positive(has,to_declare_steps_of_program).

it_is(imperative) :-
    negative(has,to_declare_steps_of_program),
    positive(has,to_declare_the_end_result).

positive(X,Y) :- 
    xpositive(X,Y),
    !.

positive(X,Y) :-
    not(xnegative(X,Y)),
    ask(X,Y,yes).

negative(X,Y) :-
    xnegative(X,Y),
    !.

negative(X,Y) :-
    not(xpositive(X,Y)),
    ask(X,Y,no). 

ask(X,Y,yes) :-
    write(X),
    write(' it '),
    write(Y), 
    write('\n'),
    read(Reply),
    sub_string(Reply,0,1,_,'y') -> 
    !,
    remember(X,Y,yes); 
    !,
    remember(X,Y,no),false.
    
   
ask(X,Y,no) :-
    write(X), 
    write(' it '),
    write(Y), 
    write('\n'),
    read(Reply),
    sub_string(Reply,0,1,_, 'n') ->
    !,
    remember(X,Y,no);
    !,
    remember(X,Y,yes),false.

remember(X,Y,yes) :-
    asserta(xpositive(X,Y)).

remember(X,Y,no) :-
    asserta(xnegative(X,Y)).

run :-
    language_is(X),!,
    write('\nYour language may be '),write(X),
    nl,nl,clear_facts.
run :-
    write('\nUnable to determine what'),
    write('your language is.\n\n'),clear_facts. 
    
clear_facts :-
    retract(xpositive(_,_)),fail.
    clear_facts :-
    retract(xnegative(_,_)),fail.
    clear_facts :-
    write('\n\nPlease press the space bar to exit\n'). 