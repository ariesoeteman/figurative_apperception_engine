%%%%%%%%%%%

% Merge manifolds and events into a unified structure

%%%%%%%%%%%


time.

concept_event(E) :- exogenous_event(E).


% Merged event connects intermediate values
has_content(E3, s(O,(C2,C3))) :-
	merged_event(E3, E1, E2), has_content(E1, s(O,(_,C2))), has_content(E2, s(O,(C3,_))).

has_content(E3, s2(O1,O2,(C2,C3))) :-
	merged_event(E3, E1, E2), has_content(E1, s2(O1,O2,(_,C2))), has_content(E2, s2(O1,O2,(C3,_))).


has_content(E3, s2v(C,O,(V2,V3))) :-
	merged_event(E3, E1, E2), has_content(E1, s2v(C,O,(_,V2))), has_content(E2, s2v(C,O,(V3,_))).


% Merged event is 'between' the two events it merges, without any overlap (boundary points)
:- merged_event(E3,E1,_), time_overlap(E3, E1).
:- merged_event(E3,_,E2), time_overlap(E3, E2).

r_strictly_after(E3, E1) :- merged_event(E3, E1, _).
r_strictly_before(E3, E2) :- merged_event(E3, _, E2).

%% If i always add a single element to the right, the check for the 'C' manifold can be omitted

%%%% MERGE GENERAL:

1{merged_event(E1+X,E1,E2) : pos_intuit_event(E1+X)} 1 :-
	merged_manifold(A,B,C), events_same_obj_and_prop(E1,E2), input_size(X),
	last_of_its_kind(B,E1), first_of_its_kind(C,E2), not chain_same_value(E1,E2).

% #show last_of_its_kind/2.
% #show first_of_its_kind/2.
% #show input_size/1.
% #show merged_manifold/3.
% #show events_same_obj_and_prop/2.

last_of_its_kind(M,E1) :- has_event(M,E1), not has_successor(M,E1), 
	not has_more_precise_sim_ending_event(M,E1).

has_successor(M,E1) :- has_event(M,E1), has_event(M, E2),
	events_same_obj_and_prop(E1,E2), r_strictly_before(E1, E2).

has_more_precise_sim_ending_event(M,E1) :- 
	has_event(M,E1), has_event(M,E2), events_same_obj_and_prop(E1,E2), r_before(E1,E2),
	time_covers(E1,E2), not time_covers(E2,E1).


first_of_its_kind(M,E1) :- has_event(M,E1), not has_predecessor(M,E1), 
	not has_more_precise_sim_beginning_event(M,E1).

has_predecessor(M,E1) :- has_event(M,E1), has_event(M, E2),
	events_same_obj_and_prop(E1,E2), r_strictly_after(E1, E2).

has_more_precise_sim_beginning_event(M,E1) :- 
	has_event(M,E1), has_event(M,E2), events_same_obj_and_prop(E1,E2), r_after(E1,E2),
	time_covers(E1,E2), not time_covers(E2,E1).



% % Merge for s
% 1{merged_event(E1+X,E1,E2) : pos_intuit_event(E1+X)} 1 :-
% 	merged_manifold(A,B,C), events_same_obj_and_prop_s(E1,E2), input_size(X),
% 	last_of_its_kind_s(B,E1), first_of_its_kind_s(C,E2), not chain_same_value_s(E1,E2).


% last_of_its_kind_s(M,E1) :- has_event(M,E1), has_content(E1, s(_,_)), not has_s_successor(M,E1), 
% 	not has_s_more_precise_sim_ending_event(M,E1).

% has_s_successor(M,E1) :- has_event(M,E1), has_event(M, E2),
% 	events_same_obj_and_prop_s(E1,E2), r_strictly_before(E1, E2).

% has_s_more_precise_sim_ending_event(M,E1) :- 
% 	has_event(M,E1), has_event(M,E2), events_same_obj_and_prop_s(E1,E2), r_before(E1,E2),
% 	time_covers(E1,E2), not time_covers(E2,E1).


% first_of_its_kind_s(M,E1) :- has_event(M,E1), has_content(E1, s(_,_)), not has_s_predecessor(M,E1), 
% 	not has_s_more_precise_sim_beginning_event(M,E1).

% has_s_predecessor(M,E1) :- has_event(M,E1), has_event(M, E2),
% 	events_same_obj_and_prop_s(E1,E2), r_strictly_after(E1, E2).

% has_s_more_precise_sim_beginning_event(M,E1) :- 
% 	has_event(M,E1), has_event(M,E2), events_same_obj_and_prop_s(E1,E2), r_after(E1,E2),
% 	time_covers(E1,E2), not time_covers(E2,E1).




% %%% MERGE FOR 's2v' type events: change in a numerical value

% 1{merged_event(E1+X,E1,E2) : pos_intuit_event(E1+X)}1 :-
% 	merged_manifold(A,B,C), events_same_obj_and_prop_s2v(E1,E2), input_size(X),
% 	last_of_its_kind_s2v(B,E1), first_of_its_kind_s2v(C,E2), not chain_same_value_s2v(E1,E2).


% last_of_its_kind_s2v(M, E1) :- has_event(M,E1), has_content(E1,s2v(_,_,_)),
% 	not has_s2v_successor(M,E1), not has_s2v_more_precise_sim_ending_event(M,E1).

% has_s2v_successor(M,E1) :- has_event(M,E1), has_event(M, E2), events_same_obj_and_prop_s2v(E1,E2),
% 	r_strictly_before(E1, E2).

% has_s2v_more_precise_sim_ending_event(M,E1) :- 
% 	has_event(M,E1), has_event(M,E2), events_same_obj_and_prop_s2v(E1,E2), r_before(E1,E2),
% 	time_covers(E1,E2), not time_covers(E2,E1).


% first_of_its_kind_s2v(M, E1) :- has_event(M, E1), has_content(E1,s2v(_,_,_)),
% 	not has_s2v_predecessor(M,E1), not has_s2v_more_precise_sim_beginning_event(M,E1).

% has_s2v_predecessor(M,E1) :- has_event(M,E1), has_event(M, E2), events_same_obj_and_prop_s2v(E1,E2),
% 	r_strictly_after(E1, E2).

% has_s2v_more_precise_sim_beginning_event(M,E1) :- 
% 	has_event(M,E1), has_event(M,E2), events_same_obj_and_prop_s2v(E1,E2), r_after(E1,E2),
% 	time_covers(E1,E2), not time_covers(E2,E1).


% same_or_incompossible(E1,E2) :- has_content(E1, s(O, (C,C))), has_content(E2, s(O, (C,C))), E1 != E2.
% same_or_incompossible(E1,E2) :- has_content(E1, C1), has_content(E2, C2), incompossible(C1,C2).

% same_obj(E1,E2) :- has_content(E1, s(O,_)), has_content(E2, s2(C,O,_)).
% same_obj(E1,E2) :- has_content(E1, s(O,_)), has_content(E2, s(O,_)).


%%% Events in successive affection must either overlap or stand in the same order of succession.
time_overlap(E1,E2) :- 
	merged_manifold(A,B,C), has_event(B,E1),
	has_event(C,E2), not r_before(E1,E2).

%% Events in same sensation must overlap!

time_overlap(E1,E2) :-
	sense_input_event(E1,_,T), sense_input_event(E2,_,T), E1 != E2.


%%% DIT GAAT DUS NIET MEER OP MET SPACE -> JAWEL WANT SAME OBJECT



%% Axioms for overlap for s



% :- incompossible_events(E1,E2), time_overlap(E1,E2), not space.


C2 = C4 :- time_overlap(E1,E2), has_content(E1, s(_,(C1,C2))), has_content(E2, s(_,(C3,C4))), events_same_obj_and_prop_s(E1,E2),
	r_before(E1,E2), r_before(E2,E1).

C1 = C3 :- time_overlap(E1,E2), has_content(E1, s(_,(C1,C2))), has_content(E2, s(_,(C3,C4))), events_same_obj_and_prop_s(E1,E2),
	r_after(E1,E2), r_after(E2,E1).

C2 = C4 :- time_overlap(E1,E2), has_content(E1, s2(_,_,(C1,C2))), has_content(E2, s2(_,_,(C3,C4))), events_same_obj_and_prop_s2(E1,E2),
	r_before(E1,E2), r_before(E2,E1).

C1 = C3 :- time_overlap(E1,E2), has_content(E1, s2(_,_,(C1,C2))), has_content(E2, s2(_,_,(C3,C4))), events_same_obj_and_prop_s2(E1,E2),
	r_after(E1,E2), r_after(E2,E1).


% %%% Axioms for overlap for S2

V3 >= V1 :- has_content(E1, s2v(C,O,(V1,V2))), V1 <= V2, has_content(E2, s2v(C,O,(V3,V4))),
	time_overlap(E1,E2), r_after(E2, E1). 

V4 <= V2 :- has_content(E1, s2v(C,O,(V1,V2))), V1 <= V2, has_content(E2, s2v(C,O,(V3,V4))),
	time_overlap(E1,E2), r_before(E2, E1).


V3 <= V1 :- has_content(E1, s2v(C,O,(V1,V2))), V1 >= V2, has_content(E2, s2v(C,O,(V3,V4))),
	time_overlap(E1,E2), r_after(E2, E1). 

V4 >= V2 :- has_content(E1, s2v(C,O,(V1,V2))), V1 >= V2, has_content(E2, s2v(C,O,(V3,V4))),
	time_overlap(E1,E2), r_before(E2, E1).


:-	time_overlap(E1, E2), has_content(E1, s2v(C,O,(V1,V2))), has_content(E2, s2v(C,O,(V3,V4))),
	V1<V3, V1<V4, V2<V3, V2<V4.

%% Incompatible directions cannot overlap:

:-	time_overlap(E1, E2), has_content(E1, s2v(C,O,(V1,V2))), has_content(E2, s2v(C,O,(V3,V4))),
	V1<V2, V3>V4.




% #show has_content/2.
% #show merged_event/3.
% #show time_cover_event/1.
% #show space_cover_event/2.
% #show synthesis_depth/1.
