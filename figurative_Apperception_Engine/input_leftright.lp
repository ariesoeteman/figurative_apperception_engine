space_senses(sv(c_intensity, 0), 1,1).
space_senses(sv(c_intensity, 0), 1,2).

move(right, (1,2)).

space_senses(sv(c_intensity,0), 2, 1).
space_senses(sv(c_intensity,1), 2, 1).

move(right, (2,3)).

space_senses(sv(c_intensity,0), 3, 1).
space_senses(sv(c_intensity,1), 3, 1).

move(left, (3,4)).

space_senses(sv(c_intensity,0), 4, 1).
space_senses(sv(c_intensity,1), 4, 1).

move(left, (4,5)).

space_senses(sv(c_intensity,0), 5, 1).
space_senses(sv(c_intensity,0), 5, 2).

move(right, (5,6)).


incompossible(sv(c_intensity,1), sv(c_intensity,0)).
inits(2).
concept_events(0).
is_object(cell1; cell2; cell3).


#show pos_init_event/1.
#show init/1.

dif_before(A,B) :- r_before(A,B), A != B.
dif_after(A,B) :- r_after(A,B), A != B.
dif_time_covers(A,B) :- time_covers(A,B), A!= B.

#show dif_after/2.
#show dif_before/2.
#show dif_time_covers/2.

% :- not no_torus.
% no_torus :- atomic_space(A), not neighbour(A,_,2).

