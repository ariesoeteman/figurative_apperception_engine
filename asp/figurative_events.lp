%%%%%%%%%%%%

% Construct events from the input
% the result is used in 'figurative_synthesis' and 'spatial_synthesis'

%%%%%%%%%%%%


% Every event has at most one content
:- has_content(E, C1), has_content(E,C2), C1 != C2.

%%% Generate Times and Events
count_sense(X,T,1):- senses(X,T).
count_sense(X,T,I):- space_senses(X,T,I).

input_size(C) :- C = #count {X,T,I : count_sense(X,T,I)}, senses(_,_).
input_size(C) :- C = #count {X,T,I : count_sense(X,T,I)}, space_senses(_,_,_).

max_time(C) :- C = #max {T : count_sense(_,T,_)}.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Start from event structures instead of numerical succession

% Distill input atoms from event structure
input((C,I)) :- r_before((C,I),_).
input((C,I)) :- r_before(_,(C,I)).
input((C,I)) :- r_after((C,I),_).
input((C,I)) :- r_after(_,(C,I)).
input((C,I)) :- time_overlap((C,I),_).
input((C,I)) :- time_overlap(_,(C,I)).



input_size(C) :- C = #count {X : input(X)}, input(_).


exists_end_between(I1,I2) :- input(I2), input(I2), input(I3), future_event(I2,I1), 
	r_strictly_before(I1,I3), not r_after(I3,I2), not time_overlap(I3,I2).

exists_begin_between(I1,I2) :- input(I1), input(I2), input(I3),
	future_event(I2,I1), r_strictly_after(I2,I3), not r_before(I3,I1), not time_overlap(I3,I1).

arbitrarily_close((I1,I2)) :- input(I1), input(I2), r_before(I1,I2), not time_overlap(I1,I2),
	future_event(I2,I1), not exists_begin_between(I1,I2), not exists_end_between(I1,I2),
	not bound_after_already_exists(I1), not bound_before_already_exists(I2).

bound_after_already_exists(I1) :- arbitrarily_close((I3,I4)), input(I1), I3 != I1, r_before(I1,I3), r_before(I3,I1).
bound_before_already_exists(I2) :- arbitrarily_close((I3,I4)), input(I2), I4 != I2, r_after(I2,I4), r_after(I4,I2).


less((A1,A2), (B1,B2)) :- arbitrarily_close((A1,A2)), arbitrarily_close((B1,B2)), 
	r_before(A1,B1), not r_before(B1,A1).


jump(A,B) :- less(A,B), not less(C,B) : arbitrarily_close(C), less(A,C).


has_earlier(B) :- jump(A,B).
has_later(A) :- jump(A,B).

number_of_jumps(C) :- C = #count{ A,B : jump(A,B)}.

num_bound(A,1) :- arbitrarily_close(A), not has_earlier(A).
num_bound(B, I+1) :- num_bound(A,I), jump(A,B), I <= C, number_of_jumps(C).


interval(B,1) :- num_bound((A1,A2),1), time_overlap(B,A1).
interval(B,1) :- num_bound((A1,A2),1), r_before(B,A1).

at_least_one_boundary :- arbitrarily_close(_).
interval(I,1) :- not at_least_one_boundary, input(I).

interval(B, I+1) :- num_bound((A1,A2),I), not has_later((A1,A2)), input(B), time_overlap(B,A2).
interval(B, I+1) :- num_bound((A1,A2),I), not has_later((A1,A2)), input(B), r_after(B,A2).

interval(C,I) :- jump((A1,A2),(B1,B2)),  num_bound((B1,B2),I), input(C), not r_before(C,A1), not r_after(C,B2).


subjective_time(T) :- interval(_,T).
max_time(C) :- C = #max {T : interval(_,T)}.

exists_in_earlier_interval(X,T2) :- interval(X,T1), interval(X,T2), T1 < T2. 

event_input_sensed_atoms_at_time(T,C) :- subjective_time(T), 
	C = #count {X : interval(X,T), not exists_in_earlier_interval(X,T)}.

event_input_sensed_upto(1,0).

event_input_sensed_upto(T+1, C+X) :- event_input_sensed_upto(T,C),
	event_input_sensed_atoms_at_time(T,X), subjective_time(T+1).


input_event(E, Content, T, I) : pos_intuit_event(E), E > X, E <= X+Y :- 
	interval((Content,I),T), not exists_in_earlier_interval((Content,I),T),
	event_input_sensed_upto(T,X), event_input_sensed_atoms_at_time(T,Y).


:- input_event(E, Content, T, I1), input_event(E, Content, T, I2), I1 != I2.

input_event(E, Content, T2, I)	:- 
	input_event(E, Content, T1, I), exists_in_earlier_interval((Content,I), T2).


has_content(E, sv(C,(V,V))) :- input_event(E, sv(C,V),_, _).
has_content(E, s(O,(C,C))) :- input_event(E, s(C,O), _, _).
has_content(E, s2(O1,O2,(C,C))) :- input_event(E, s2(C,O1,O2), _, _).
has_content(E, s2v(C,O,(V,V))) :- input_event(E, s2v(C,O,V), _, _).


has_event((T,0), E) :- input_event(E,_,T,_).

r_before(E1,E2) :- input_event(E1, C1, T1, I1), input_event(E2, C2, T2, I2),  r_before((C1,I1), (C2,I2)).
r_after(E1,E2) :- input_event(E1, C1, T1, I1), input_event(E2, C2, T2, I2),  r_after((C1,I1), (C2,I2)).
time_overlap(E1,E2) :- input_event(E1, C1, T1, I1), input_event(E2, C2, T2, I2),  time_overlap((C1,I1), (C2,I2)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



subjective_time(1).
subjective_time(I+1) :- subjective_time(I), max_time(X), I < X.

pos_intuit_event(1..2*X) :- input_size(X).


intuit_event(E) :- has_event(M,E), pos_intuit_event(E).


total_intuit(2*X) :- input_size(X).

%%%%%%%%%%%% COVERS

time_cover_event(X+1) :- total_intuit(X).

% Spacetime is 'eternal' and 'everywhere'
time_covers(T,E) :- time_cover_event(T), intuit_event(E).


%% Space cover events do not have a content but cover all other events in manifold
has_event(M,E) :- space_cover_event(M,E).

space_cover_event(E) :- space_cover_event(_,E).

event(T) :- time_cover_event(T).
event(E) :- space_cover_event(E).
event(E) :- intuit_event(E).


% Spacetime is placed in the top manifold
space_cover_event(M,T) :- 
	manifold(M), has_event(M,_), not merged_manifold(_,M,_),
	not merged_manifold(_,_,M), time_cover_event(T).


%% Symmetry breaking
:- intuit_event(E), input_size(X), E <= X, pos_intuit_event(E), pos_intuit_event(E-1), not intuit_event(E-1).


synthesis_depth(1..X-1) :- max_time(X), X != #inf.

manifold((A,0)) :- subjective_time(A).
manifold((1,B)) :- synthesis_depth(B).

bottom_manifold((A,0)) :- manifold((A,0)).


%%%%%%%%%%%%%%%%%%% Generate input events

sensed_atoms_at_time(T,C) :- subjective_time(T), 
	C = #count {X,I : count_sense(X,T,I)}.

sensed_upto(1,0).

sensed_upto(T+1, C+X) :- sensed_upto(T,C), sensed_atoms_at_time(T,X), subjective_time(T+1).

sense_input_event(E, Content, T) : pos_intuit_event(E), E > X, E <= X+Y :- 
	senses(Content,T), sensed_upto(T,X), sensed_atoms_at_time(T,Y).


senses(s(C1,O), T1) :- exogenous(s(O,(C1,_)), (T1,_)).
senses(s(C2,O), T2) :- exogenous(s(O,(_,C2)), (_,T2)).

exogenous_event(E) :-
	exogenous(s(O,(C1,C2)),(T1,T2)),  sense_input_event(E1, s(C1,O),T1),
	sense_input_event(E2, s(C2,O), T2), merged_event(E,E1,E2).


senses(sv(C,V1), T1) :- exogenous(sv(C,(V1,_)), (T1,_)).
senses(sv(C,V2), T2) :- exogenous(sv(C,(_,V2)), (_,T2)).

exogenous_event(E) :-
	exogenous(sv(C,(V1,V2)),(T1,T2)),  sense_input_event(E1, sv(C,V1),T1),
	sense_input_event(E2, sv(C,V2), T2), merged_event(E,E1,E2).


senses(s2(O1,O2,C1), T1) :- exogenous(s2(O1,O2,(C1,_)), (T1,_)).
senses(s2(O1,O2,C2), T2) :- exogenous(s2(O1,O2,(_,C2)), (_,T2)).

exogenous_event(E) :-
	exogenous(s2(O1,O2,(C1,C2)),(T1,T2)),  sense_input_event(E1, s2(O1,O2,C1),T1),
	sense_input_event(E2, s2(O1,O2,C2), T2), merged_event(E,E1,E2).


senses(s2v(C,O,V1), T1) :- exogenous(s2v(C,O,(V1,_)), (T1,_)).
senses(s2v(C,O,V2), T2) :- exogenous(s2v(C,O,(_,V2)), (_,T2)).

exogenous_event(E) :-
	exogenous(s2v(C,O,(V1,V2)),(T1,T2)),  sense_input_event(E1, s2v(C,O,V1),T1),
	sense_input_event(E2, s2v(C,O,V2), T2), merged_event(E,E1,E2).


% For space: different intuitions with the same content can then
% occur at the same time, but still be distinguished.
sense_input_event(E, Content, T, I) : pos_intuit_event(E), E > X, E <= X+Y :- 
	space_senses(Content,T,I), sensed_upto(T,X), sensed_atoms_at_time(T,Y).


:- sense_input_event(E, C, T, I1), sense_input_event(E,C,T,I2), I1 != I2.

sense_input_event(E,C,T) :- sense_input_event(E,C,T,_).


has_event((T,0), E) :- sense_input_event(E, _, T).

has_content(E, sv(C,(V,V))) :- sense_input_event(E, sv(C,V),_).
has_content(E, s(O,(C,C))) :- sense_input_event(E, s(C,O), _).
has_content(E, s2(O1,O2,(C,C))) :- sense_input_event(E, s2(C,O1,O2), _).
has_content(E, s2v(C,O,(V,V))) :- sense_input_event(E, s2v(C,O,V), _).


%%% ALLOW FOR MERGING

%% Merged manifold contains the events of its children and merged events
% merged_manifold((S1, Depth+1), (S1, Depth), (S1+1, Depth)):- manifold((S1, Depth)), manifold((S1+1, Depth)), manifold((S1, Depth+1)).

merged_manifold((1, D), (1, D-1), (D+1,0)):- 
	manifold((1, D-1)), manifold((D+1,0)), synthesis_depth(D).


% merged_manifold((S1, Depth+1), (S1, Depth), (S1+1, Depth)):- manifold((S1, Depth)), manifold((S1+1, Depth)), manifold((S1, Depth+1)).

has_event(A,Event) :- merged_manifold(A,B,_), has_event(B,Event).
has_event(A,Event) :- merged_manifold(A,_,C), has_event(C,Event).

has_event(A,E3) :- merged_manifold(A,B,C), has_event(B,E1), has_event(C,E2), merged_event(E3,E1,E2).


:- incompossible_events(E1,E2), time_overlap(E1,E2), not space.

% #show incompossible_events/2.
% #show incompossible_contents/2.
% #show sense_input_event/3.
% #show has_content/2.
% #show exogenous_event/1.
% #show intuit_event/1.