:- [score_Db].


generate_scores(0) :- !.

generate_scores(Amount) :-

    New_amount is Amount - 1,
    
    generate_scores(New_amount),
    
    MetaPredicate=..[score, New_amount, 0],
    
    asserta(MetaPredicate)
. 
