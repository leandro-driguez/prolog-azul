
:-op(350, xfx, [was_assigned_to, was_increased_in, was_equal_to]).
:-op(100, xf, [is_zero, available, does_not_have_any_tiles_available]).
:-op(150, xfy, [has, does_not_have]).


Value was_assigned_to Variable :-

    assignment(Variable, Value)
.


Variable was_increased_in Add :-

    addition(Variable, Add)
.


Variable is_zero :-

    MetaVariable=..[Variable, Value],

    call(MetaVariable), Value = 0
.


Variable was_equal_to Value :-

    MetaVariable=..[Variable, Value],

    call(MetaVariable)
.


Dictionary has Tiles available :-

    MetaPredicate=..[Dictionary, Tiles, Value],

    call(MetaPredicate),

    Value > 0, !
.


Dictionary does_not_have Tiles available :-

    not(Dictionary has Tiles available)
.


Dictionary does_not_have_any_tiles_available :-

    Dictionary does_not_have _ available
.


transducer(MetaPredicate, Transducer, Args) :-
    
    MetaPredicate_Transducer=..[Transducer,
        MetaPredicate, MetaPredicate_Modificated,Args],

    call(MetaPredicate_Transducer),
    
    assertz(MetaPredicate_Modificated),

    retract(MetaPredicate), !
.


% Type of Transducer

addition_transducer(MetaPredicate, MetaPredicate_Modificated, [Add]) :-

    MetaPredicate=..[Predicate, Variable, Value],

    Addition is Value + Add,

    MetaPredicate_Modificated=..[Predicate, Variable, Addition]
.


assignment(Variable, Value) :-

    Insert=..[Variable, Value],

    Remove=..[Variable,_],

    call(Remove),

    assertz(Insert),

    retract(Remove)
.


addition(Variable, Add) :-

    MetaVariable=..[Variable, Current_Value],

    call(MetaVariable),

    Addition is Current_Value + Add,

    Addition was_assigned_to Variable
.

addition(Predicate, Key, Add) :-
    
    MetaPredicate=..[Predicate,Key,_],

    call(MetaPredicate),

    transducer(MetaPredicate,addition_transducer,[Add])
.


generated_random(L, U, X):-

    random(L, U, X), !
.

generated_random(L, U, X) :-

    generated_random(L, U, X)
.
