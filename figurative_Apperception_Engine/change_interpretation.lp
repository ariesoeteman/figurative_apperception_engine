{init(s2v(c_intensity, Cell, 1)); init(s2v(c_intensity, Cell, 0))}1:- 
	is_object(Cell), permanent(isa(t_cell, Cell)).

{init(s2v(c_temp, Cell, I)) : number(I)}1 :- 
	is_object(Cell), permanent(isa(t_sensor,Cell)).

%%%% Interpretation


1 { rule_var_group(R, VG) : is_var_group(VG) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_body(R, VA) : var_content(VA) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_head_co(R, CO) : head_content(CO) } 1 :- is_fig_rule(R), use_rule(R).

is_causal_rule(r1).
{ use_rule(R) } :- is_fig_rule(R).


permanent(isa(t_cell, cell1)).
permanent(isa(t_cell, cell2)).
permanent(isa(t_sensor, obj_sensor)).


%%VARS

var_fluent(s2v(c_intensity, var_s1, 1), var_group_s1).
var_fluent(s2v(c_temp, var_s2, 1), var_group_s2).

var_fluent(s2v(c_intensity, var_s1, 1), var_group_s1_s2).
var_fluent(s2v(c_temp, var_s2, 1), var_group_s1_s2).

%% SUBS

contains_var(var_group_s1, var_s1).

subs_group(var_group_s1, subs_s1_1).
subs(subs_s1_1, var_s1, cell1).

subs_group(var_group_s1, subs_s1_2).
subs(subs_s1_2, var_s1, cell2).

subs_group(var_group_s1, subs_s1_3).
subs(subs_s1_3, var_s1, cell3).


contains_var(var_group_s2, var_s2).

subs_group(var_group_s2, subs_s2_1).
subs(subs_s2_1, var_s2, obj_sensor).


contains_var(var_group_s1_s2, var_s1).
contains_var(var_group_s1_s2, var_s2).

subs_group(var_group_s1_s2, subs_s1_s2_1).
subs(subs_s1_s2_1, var_s1, cell1).
subs(subs_s1_s2_1, var_s2, obj_sensor).


subs_group(var_group_s1_s2, subs_s1_s2_2).
subs(subs_s1_s2_2, var_s1, cell2).
subs(subs_s1_s2_2, var_s2, obj_sensor).

subs_group(var_group_s1_s2, subs_s1_s2_3).
subs(subs_s1_s2_3, var_s1, cell3).
subs(subs_s1_s2_3, var_s2, obj_sensor).


#show rule_body/2.
#show rule_head_co/2.
#show init/1.

dif_before(E1,E2) :- r_before(E1,E2), E1!=E2.
dif_after(E1,E2) :- r_after(E1,E2), E1!=E2.


dif_time_covers(E1,E2) :- time_covers(E1,E2), E1!=E2.

dif_time_overlap(A,B) :- time_overlap(A,B), A!= B.

#show intuit_event/1.
#show init_event/1.
#show concept_event/1.

#show dif_time_covers/2.
#show dif_time_overlap/2.

#show dif_before/2.
#show dif_after/2.

#show has_content/2.

#show has_concept_cover/2.

#show merged_event/3.

#show regular_succession/4.

#show stabilises/3.

#show chain_prev/2.

#show time_cover_event/1.

#show ending_concept_event/1.

#show neighbour/3.