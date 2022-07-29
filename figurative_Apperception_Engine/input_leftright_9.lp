space_senses(sv(c_intensity, 0), 1,1).
space_senses(sv(c_intensity, 0), 1,2).

move(right, (1,2)).

space_senses(sv(c_intensity,0), 2, 1).
space_senses(sv(c_intensity,1), 2, 1).

move(right, (2,3)).

space_senses(sv(c_intensity,0), 3, 1).
space_senses(sv(c_intensity,1), 3, 1).

move(right, (3,4)).

space_senses(sv(c_intensity,0), 4, 1).
space_senses(sv(c_intensity,1), 4, 1).

move(right, (4,5)).

space_senses(sv(c_intensity,1), 5, 1).
space_senses(sv(c_intensity,1), 5, 2).

move(left, (5,6)).

space_senses(sv(c_intensity,1), 6, 1).
space_senses(sv(c_intensity,0), 6, 1).

move(right, (6,7)).

space_senses(sv(c_intensity,1), 7, 1).
space_senses(sv(c_intensity,1), 7, 2).

move(left, (7,8)).

space_senses(sv(c_intensity,1), 8, 1).
space_senses(sv(c_intensity,0), 8, 1).

incompossible(sv(c_intensity,1), sv(c_intensity,0)).

is_object(cell1; cell2; cell3; cell4).
inits(4).
concept_events(0).

{init(s2v(c_intensity, X, 1))} :- is_object(X).
{init(s2v(c_intensity, cell1, 0))} :- is_object(X).


#show pos_init_event/1.
#show init/1.
#show neighbour/3.
#show space_equal/2.
#show has_content/2.
#show move_function/3.
#show space_cover_event/2.
#show space_orient/2.

partofcover(A,B):- intuit_event(A), space_cover_event(_B), part(A,B).
#show partofcover/2.


#show overlap_count/2.
#show has_concept_cover/2.