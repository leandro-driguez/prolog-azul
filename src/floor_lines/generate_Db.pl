
:- [floor_line_Db].


generate_floor_lines(0) :- 

    % array donde esta precalculado las perdidas en dependencia
    % de la cantidad de tiles que se tengan 

    assert(floor_line([ -1, -2, -4, -6, -8, -11, -14])), !
               % -1, -1, -2, -2, -2, -3,  -3
. 

generate_floor_lines(Amount) :-
    
    New_amount is Amount - 1,
    
    MetaPredicate=..[floor_line, New_amount, 0],
    asserta(MetaPredicate),

    generate_floor_lines(New_amount)
. 
