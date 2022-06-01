
:- [wall_Db, '../collections/collections_management'].


generate_walls(0) :- 
    
    assert(wall([[blue, yellow, red, black, green],
                 [green, blue, yellow, red, black],
                 [black, green, blue, yellow, red],
                 [red, black, green, blue, yellow],
                 [yellow, red, black, green, blue]])), !
. 

generate_walls(Amount) :-
    
    generate_list(5, 0, Row),
    
    generate_list(5, Row, Wall),
    
    New_amount is Amount - 1,

    MetaPredicate=..[wall,New_amount,Wall],
    
    asserta(MetaPredicate),

    generate_walls(New_amount)
. 
 