
:- ['../utils/utils'].


% Generate a list of `Value` elements with size `Amount`

generate_list(0, _, []) :- !.

generate_list(Amount, Value, [Value | Rest_of_the_list]) :-

    Tmp is Amount - 1,  

    generate_list(Tmp, Value, Rest_of_the_list)
. 


select_a_random_item_of_the_list(List, Lenght, Index, Item) :-

    generated_random(0, Lenght, Index),

    index_in_the_list(List, Index, Item)
.  


index_in_the_list([Item|_], 0, Item).

index_in_the_list([_|Rest_of_the_list], Index, Item) :-

    index_in_the_list(Rest_of_the_list, New_Index, Item),

    Index is New_Index + 1
.  


remove_this_item_from_the_list([_|Rest_of_the_list], 0, 
        Rest_of_the_list).

remove_this_item_from_the_list([First_Item | Rest_of_the_list], 
        Index, [First_Item|Rest_of_the_resulting_list]
    ) :-

    remove_this_item_from_the_list(Rest_of_the_list,New_Index,
        Rest_of_the_resulting_list),

    Index is New_Index + 1
.


length_of_the_list([], 0) :- !.

length_of_the_list([_|Rest_of_the_list], Length) :-

    length_of_the_list(Rest_of_the_list,Decreased_length),
    
    Length is Decreased_length + 1
.  


% Get all `Item` elements of the list and its rest

get_all_items_of_the_list([], _, [], []) :- !. 

get_all_items_of_the_list([Item|Rest_of_the_list], Item, [Item|
        Rest_of_the_items], Resulting_list
    ) :-

    get_all_items_of_the_list(Rest_of_the_list, Item, 
        Rest_of_the_items, Resulting_list), !
.  

get_all_items_of_the_list([X|Rest_of_the_list], Item, Items, [X|
        Rest_of_the_resulting_list]
    ) :-

    get_all_items_of_the_list(Rest_of_the_list, Item, Items, 
        Rest_of_the_resulting_list), !
. 


% Assign a `Value` in that `Index` of the list 

assign_into_list([_|Rest_of_the_list], [Value|Rest_of_the_list], 
    0, Value).

assign_into_list([Item|Rest_of_the_list], [Item|
        Rest_of_the_resulting_list], Index, Value
    ) :- 

    assign_into_list(Rest_of_the_list, Rest_of_the_resulting_list, 
        New_Index, Value),

    Index is New_Index + 1
. 


concat([], X, X). 

concat([X|Rx], Y, [X|Z]) :- concat(Rx, Y, Z).



% Remove repe

removes_matches([], []).

removes_matches(List, Resulting_list) :-

    List = [First_item|_],

    get_all_items_of_the_list(List, First_item, _, Rest),

    removes_matches(Rest, Resulting_rest),

    concat([First_item], Resulting_rest, Resulting_list)
. 


item_belongs_to_list(Item, [Item|_]) :- !.

item_belongs_to_list(Item, [_|Rest_of_the_list]) :-

    item_belongs_to_list(Item, Rest_of_the_list)
. 


remove_empty(List, List) :- 

    not(item_belongs_to_list([], List)), !
. 

remove_empty(List, List_without_empty) :- 

    index_in_the_list(List, Index, []),
    remove_this_item_from_the_list(List, Index, List_without_empty)
. 
