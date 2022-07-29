

space_senses(sv(c_intensity,0), 1,1).

senses(s2v(c_temp, obj_sensor, 0), 2).

move(right, (1,2)).


space_senses(sv(c_intensity,0), 2,1).

% exogenous(s2v(c_temp, obj_sensor, (5,2)), (2,3)).

move(left, (2,3)).

space_senses(sv(c_intensity,1), 3, 1).


move(right, (3,4)).

space_senses(sv(c_intensity,2), 4, 1).



space_senses(sv(c_intensity,3), 5, 1).


inits(3).
concept_events(5).
is_object(cell1; cell2; cell3).
is_object(obj_sensor).


dif_time_covers(A,B) :- time_covers(A,B), A!=B.
#show dif_time_covers/2.

time_space_overlap(A,B) :- time_overlap(A,B), space_overlap(A,B), A!=B.
#show time_space_overlap/2.

#show is_content/1.

#show merged_event/3.
