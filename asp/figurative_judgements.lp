%%%%%%%%%%%%%%%%%%%%%%

% Develop a trace as event structure from a theory, so that the unified event structure
% W_u is explained.

%%%%%%%%%%%%%%%%%%%%%%

nospace :- not space.
no_time :- not time.


used_regular_succession(R) :- is_regsucc_rule(R), use_rule(R).
used_causal_rule(R) :- is_causal_rule(R), use_rule(R).

causal_head_co(R,CO) :- rule_head_co(R,CO), is_causal_rule(R).
regsucc_head_co(R,CO) :- rule_head_co(R,CO), is_regsucc_rule(R).


concept_event(E) :- exogenous_event(E).

% Generate events for W_T

pos_init_event(Start..End) :- total_intuit(X), max_time(Y), Y != #inf, inits(I),
	Start = X+Y+3, End = X+Y+2+I.

pos_concept_event(Start..End) :- total_intuit(X), max_time(Y), Y != #inf, inits(I), concept_events(C),
	Start = X+Y+2+I+1, End = X+Y+2+I+C.

num_concept_events(C) :- C = #count{E : concept_event(E), pos_concept_event(E)}. 

% Symmetry breaking
:- init_event(E), pos_init_event(E), pos_init_event(E-1), not init_event(E-1).


init_event(E) :- pos_init_event(E), has_content(E,_).
concept_event(E) :- pos_concept_event(E), has_content(E,_).

concept_event(X) :- init_event(X).

% No extensionality
:- has_content(E,C1), has_content(E,C2), C1 != C2.


% Assign contents to events in W_T
1{has_content(E,s2v(Concept, Object, (V,V))) : pos_init_event(E)}1 :- 
		init(s2v(Concept, Object, V)).

1{has_content(E,s2(O1, O2, (Concept,Concept))) : pos_init_event(E)}1 :- 
		init(s2(Concept, O1, O2)).


1{has_content(E,s(Object, (Concept,Concept))) : pos_init_event(E)}1 :- 
		init(s(Concept, Object)).

% Available numbers in the contents

number(0..10).

% Init events start at the beginning of W_T
r_after(Y,X) :- init_event(X), concept_event(Y).


% Ensure that a non-init event is preceded by another event
% that ends where the first starts, this implements the frame axiom.
exists_end_between(E1,E2) :- concept_event(E2),not init_event(E2), concept_event(E1), concept_event(E3),
	future_event(E2,E1), r_strictly_before(E1,E3), not r_after(E3,E2), not time_overlap(E3,E2).

exists_begin_between(E1,E2) :- concept_event(E2), not init_event(E2), concept_event(E1), concept_event(E3),
	future_event(E2,E1), r_strictly_after(E2,E3), not r_before(E3,E1), not time_overlap(E3,E1).

boundary_between(E1,E2) :- concept_event(E2), not init_event(E2), concept_event(E1),
	future_event(E2,E1), not exists_begin_between(E1,E2), not exists_end_between(E1,E2).

chain_prev(E1,E2) :- boundary_between(E1,E2), chain_same_value_s(E1,E2).
chain_prev(E1,E2) :- boundary_between(E1,E2), chain_same_value_s2v(E1,E2).
chain_prev(E1,E2) :- boundary_between(E1,E2), chain_same_value_s2(E1,E2).


:- chain_prev(E1,E2), chain_prev(E1,E3), E2 != E3.
:- chain_prev(E1,E2), chain_prev(E3,E2), E1 != E3.


has_prev(E) :- chain_prev(_,E).

:- concept_event(E2), not init_event(E2), not has_prev(E2).

:- regular_succession(_,_,E1,E2), not boundary_between(E1,E2).
:- stabilises(_,_,E1,E2), not boundary_between(E1,E2).


%% If a concept event is after all events covering intuition events (without overlap)
%% we no longer derive causal or succesive consequences
ending_concept_event(E1) :- concept_event(E1), not is_concept_cover(E1),
	future_event(E1,E2) : intuit_event(E2).

% Generate consequents of causal rules
1 {causes(R,Subs,E1,E2) : pos_concept_event(E2), E1 < E2}1:- 
	concept_event(E1), 
	is_causal_rule(R),
	rule_subs(R,Subs),
	head_object_exists(R,Subs),
	eval_body(R,Subs,E1),
	not ending_concept_event(E1).

% Generate stabilising events
1 {stabilises(s(O,(C1,C2)),E1,E2) : pos_concept_event(E2), E1 < E2}1 :- 
	concept_event(E1), 
	has_content(E1, s(O,(C1,C2))), 
	C1 != C2.

1 {stabilises(s2(O1,O2,(C1,C2)),E1,E2) : pos_concept_event(E2), E1 < E2}1 :- 
	concept_event(E1), 
	has_content(E1, s2(O1,O2,(C1,C2))), 
	C1 != C2.


1 {stabilises(s2v(C,O,(V1,V2)),E1,E2) : pos_concept_event(E2), E1<E2}1 :- 
	concept_event(E1), 
	has_content(E1, s2v(C,O,(V1,V2))), 
	V1 != V2.

% Generate consequents of regular successions
1 {regular_succession(R,Subs,E1,E2) : pos_concept_event(E2), E1<E2}1:- 
	concept_event(E1), 
	is_regsucc_rule(R),
	rule_subs(R,Subs),
	head_object_exists(R,Subs),
	eval_body(R,Subs,E1),
	not ending_concept_event(E1).


has_content(E2, s(O,(C2,C2))) :- stabilises(s(O,(_,C2)), _,E2).
has_content(E2, s2(O1,O2,(C2,C2))) :- stabilises(s2(O1,O2,(_,C2)), _,E2).
has_content(E2, s2v(C,O,(V2,V2))) :- stabilises(s2v(C,O,(_,V2)), _,E2).


has_content(E2,GH) :- 
	regular_succession(R,Subs,_,E2),
	rule_head_co(R,VH),
	rule_subs(R,Subs),
	ground_content(VH, GH, Subs).

has_dir_content(E2,s2v(C,Obj,up)) :- 
	regular_succession(R,Subs,E1,E2), rule_head_co(R,s2v(C,Var,up)),
	rule_subs(R,Subs),
	subs(Subs,Var,Obj).

has_dir_content(E2,s2v(C,Obj,down)) :- 
	regular_succession(R,Subs,E1,E2), rule_head_co(R,s2v(C,Var,down)),
	rule_subs(R,Subs),
	subs(Subs,Var,Obj).


has_content(E2,GH) :- 
	causes(R,Subs,_,E2),
	rule_head_co(R,VH),
	rule_subs(R,Subs),
	ground_content(VH, GH, Subs).

has_dir_content(E2,s2v(C,Obj,up)) :- 
	causes(R,Subs,E1,E2), rule_head_co(R,s2v(C,Var,up)),
	rule_subs(R,Subs),
	subs(Subs,Var,Obj).


has_dir_content(E2,s2v(C,Obj,down)) :- 
	causes(R,Subs,E1,E2), rule_head_co(R,s2v(C,Var,down)),
	rule_subs(R,Subs),
	subs(Subs,Var,Obj).

% Cause covers consequence
time_covers(E1,E2) :- causes(_,_,E1,E2).


% Temporal relations for regular successions
r_after(E2,E1) :- regular_succession(_,_,E1,E2).
r_before(E1,E2) :- regular_succession(_,_,E1,E2).

:- regular_succession(_,_,E1,E2), r_after(E1,E2) .
:- regular_succession(_,_,E1,E2), r_before(E2,E1) .

:- regular_succession(_,_,E1,E2), time_overlap(E1,E2).


r_after(E2,E1) :- stabilises(_,E1,E2).
r_before(E1,E2) :- stabilises(_,E1,E2).

:- stabilises(_,E1,E2), r_after(E1,E2).
:- stabilises(_,E1,E2), r_before(E2,E1).

:- stabilises(_,E1,E2), time_overlap(E1,E2).


%Symmetry breaking
E2 = E1 + 1 :- stabilises(_,E1,E2), not exogenous_event(E1), not exogenous_event(E2), not init_event(E1).
E2 = E1 + 1	:- causes(_,_,E1,E2), not exogenous_event(E1), not exogenous_event(E2), not stabilises(_,E1,_), not init_event(E1).
E2 = E1 + 1	:- regular_succession(_,_,E1,E2), not exogenous_event(E1), not exogenous_event(E2), not stabilises(_,E1,_), 
	not causes(_,_,E1,_), not init_event(E1).


%% Gues ranging values for direction contents

1 {from(E, V) : number(V)} 1:-  has_dir_content(E, _).
1 {to(E, V) : number(V)}1 :-  has_dir_content(E, _).

:- has_dir_content(E, s2v(_,_,up)), from(E,V1), to(E,V2), V2 <= V1.
:- has_dir_content(E, s2v(_,_,down)), from(E,V1), to(E,V2), V2 >= V1.


has_content(E,s2v(C,O,(V1,V2))) :- has_dir_content(E, s2v(C,O,_)), from(E,V1), to(E,V2).


%%%%%%Theory sensibility:

:- time_overlap(E1,E2), concept_event(E1), concept_event(E2), has_content(E1, s(_,(C1,C2))),
	has_content(E2, s(_,(C3,C4))), events_same_obj_and_prop_s(E1,E2),
	r_strictly_before(E2,E1), C4 != C1, C4 != C2.

:- time_overlap(E1,E2), concept_event(E1), concept_event(E2), has_content(E1, s(_,(C1,C2))), 
	has_content(E2, s(_,(C3,C4))), events_same_obj_and_prop_s(E1,E2),
	r_strictly_after(E2,E1), C3 != C1, C3 != C2.


:- time_overlap(E1,E2), concept_event(E1), concept_event(E2), has_content(E1, s2(_,_,(C1,C2))),
	has_content(E2, s2(_,_,(C3,C4))), events_same_obj_and_prop_s2(E1,E2),
	r_strictly_before(E2,E1), C4 != C1, C4 != C2.

:- time_overlap(E1,E2), concept_event(E1), concept_event(E2), has_content(E1, s2(_,_,(C1,C2))), 
	has_content(E2, s2(_,_,(C3,C4))), events_same_obj_and_prop_s2(E1,E2),
	r_strictly_after(E2,E1), C3 != C1, C3 != C2.


:- causes(_,_,E1,E2), has_dir_content(E2, s2v(C,O,D1)), r_before(E3,E2), has_dir_content(E3, s2v(C,O,D2)),
	D1 != D2, time_overlap(E1,E3), nospace.

% :- causes(_,_,E1,E2), has_dir_content(E2, s2v(C,O,D1)), r_before(E3,E2), has_dir_content(E3, s2v(C,O,D2)),
% 	D1 != D2, time_overlap(E1,E3), chain_prev(E4,E3), time_overlap(E1,E4), nospace.

% echte_smeerlap(E1,E4,E3,E2) :- causes(_,_,E1,E2), has_dir_content(E2, s2v(C,O,D1)), r_before(E3,E2), has_dir_content(E3, s2v(C,O,D2)),
% 	D1 != D2, time_overlap(E1,E3), chain_prev(E4,E3), time_overlap(E1,E4), nospace.


:- causes(_,_,E1,E2), has_content(E1, s2(obj_agent,obj_cart_a,(c_push,c_push))),
has_dir_content(E2, s2v(C,O,D1)), r_before(E3,E2), has_dir_content(E3, s2v(C,O,D2)),
	D1 != D2, time_overlap(E1,E3), nospace.


:- causes(R,_,E1,E2), concept_event(E3), events_same_obj_and_prop_s(E2,E3),
 	E2 != E3, r_before(E3,E2), time_covers(E1,E3), nospace.

:- causes(R,_,E1,E2), concept_event(E3), events_same_obj_and_prop_s2(E2,E3),
 	E2 != E3, r_before(E3,E2), time_covers(E1,E3), nospace.


:- causes(_,_,_,E2), has_content(E2, s(_,(C,C))).
:- causes(_,_,_,E2), has_content(E2, s2(_,_,(C,C))).
:- causes(_,_,_,E2), has_content(E2, s2v(_,_,(V,V))).

% :- causes(_,_,E1,E2), causes(_,_,E1,E3), E2 != E3.
% :- causes(_,_,E1,E2), causes(_,_,E3,E2), E1 != E3.

% :- regular_succession(_,_,E1,E2), regular_succession(_,_,E1,E3), E2 != E3.
% :- regular_succession(_,_,E1,E2), regular_succession(_,_,E3,E2), E1 != E3.

% :- causes(_,_,E1,_), regular_succession(_,_,E1,_).
% :- causes(_,_,_,E2), regular_succession(_,_,_,E2).

%%%% DEZE HAAL IK WEG... DIT SLAAT EIGENLIJK NERGENS OP.. maar werkt koffie nu nog wel?
:- is_causal_rule(R1), is_causal_rule(R2), rule_body(R1,B), rule_body(R2,B), R1 != R2.

:- has_s2v_content(E), regular_succession(_,_,_,E).


% All intuition events must be covered by 
% corresponding conceptual events: 'trace covering'

:- intuit_event(E), has_content(E,_), not exogenous_event(E),
	 not has_concept_cover(E).


nospace_overlap(A,E) :- atomic_space(A), concept_event(E),
	incompossible_events(A,E), time_overlap(A,E).

{part(A,E)} :- concept_event(E), atomic_space(A),
	not nospace_overlap(A,E).

has_concept_cover(E) :- has_concept_cover(E,_).
is_concept_cover(E) :- has_concept_cover(_,E), event(E).
is_concept_cover(E1) :- has_concept_cover(_,(E1,_)).
is_concept_cover(E2) :- has_concept_cover(_,(_,E2)).



%% Cover only covers (path) connected parts in space

conn_path(A,B,C):- atomic_space(A), is_concept_cover(C),
	part(A,C), space_equal(A,B).

conn_path(A1,A2,C):- atomic_space(A1), atomic_space(A2), is_concept_cover(C),
	part(A1,C), part(A2,C), space_equal(A1,E1),
	space_equal(A2,E2), space_designator(E1), space_designator(E2),
	neighbour(E1,E2,I), even(I).


% Already equivalent to line for manifold-connectedness
conn_path(A1,A3,C) :- conn_path(A1,A2,C), conn_path(A2,A3,C).

:- atomic_space(A1), atomic_space(A2), is_concept_cover(C),
	part(A1,C), part(A2,C), not conn_path(A1,A2,C).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%



int_con_part(IE,CE) :- 
	intuit_event(IE), concept_event(CE), part(IE,CE).

int_con_part(IE,CE) :- 
	intuit_event(IE), concept_event(CE), nospace.

content_covered(IE,CE):- int_con_part(IE,CE),
	intuit_event(IE), concept_event(CE), has_content(IE, sv(C,(V1,V2))), V2 >= V1,
	has_content(CE, s2v(C,O,(V3,V4))), V3<=V1, V4>=V2. 

content_covered(IE,CE) :- int_con_part(IE,CE), intuit_event(IE), concept_event(CE),
	has_content(IE, sv(C,(V1,V2))), V2 <= V1,
	has_content(CE, s2v(C,O,(V3,V4))), V3>=V1, V4<=V2. 

has_concept_cover(IE,CE) :- 
	content_covered(IE,CE), time_covers(CE,IE).

has_concept_cover(IE,CE) :- 
	content_covered(IE,CE), no_time.


content_covered(IE,CE) :- int_con_part(IE,CE),
	has_content(IE, s(O,(C1,C2))),
	has_content(CE, s(O,(C1,C2))).


content_begin_covered(IE,CE) :- int_con_part(IE,CE),
	has_content(IE, s(O,(C1,_))),
	has_content(CE, s(O,(C1,_))).

content_end_covered(IE,CE) :- int_con_part(IE,CE),
	has_content(IE, s(O,(_,C2))),
	has_content(CE, s(O,(_,C2))).


content_begin_covered(IE,CE) :- int_con_part(IE,CE),
	has_content(IE, s2(O1,O2,(C1,_))),
	has_content(CE, s2(O1,O2,(C1,_))).

content_end_covered(IE,CE) :- int_con_part(IE,CE),
	has_content(IE, s2(O1,O2,(_,C2))),
	has_content(CE, s2(O1,O2,(_,C2))).


has_concept_cover(IE, (CB,CE)) :- 
	content_begin_covered(IE,CB), 
	content_end_covered(IE,CE),
	time_overlap(CB,IE), r_after(IE,CB),
	time_overlap(CE,IE), r_before(IE,CE).


content_covered(IE,CE) :- int_con_part(IE,CE),
	has_content(IE, s2v(C,O,(V1,V2))), V2 >= V1,
	has_content(CE, s2v(C,O,(V3,V4))), V3<=V1, V4>=V2.

content_covered(IE,CE) :- int_con_part(IE,CE),
	has_content(IE, s2v(C,O,(V1,V2))), V2 <= V1,
	has_content(CE, s2v(C,O, (V3,V4))),
	V3 >= V1, V4 <= V2.

% Place concept events on timeline with the other events
event(X) :- concept_event(X).


%%%%%%% Extra clauses for model interpretation:

% intuit_extc(X,Y) :- pos_intuit_event(X), pos_intuit_event(Y), X!= Y, ext_connected(X,Y).
% concept_extc(X,Y) :- concept_event(X), concept_event(Y), X!= Y, ext_connected(X,Y).


% #show intuit_extc/2.
% #show concept_extc/2.


% intuit_part(X,Y) :- pos_intuit_event(X), pos_intuit_event(Y), X!= Y, part(X,Y).
% concept_part(X,Y) :- concept_event(X), concept_event(Y), X != Y, part(X,Y).
% #show intuit_part/2.
% #show concept_part/2.


% intuit_space_equal(X,Y) :- pos_intuit_event(X), pos_intuit_event(Y), X!=Y, space_equal(X,Y).
% #show intuit_space_equal/2.


%%%%%%%%%%%%%%%%%%%%%%%%5


% #show has_content/2.
% #show dif_covers/2.
% #show after/2.
% #show regular_succession/4.
% #show is_concept_cover/1.
% #show stabilises/3.

% #show rule_body/2.
% #show rule_head_co/2.
% concept_content(E,C) :- concept_event(E), has_content(E,C).

% #show concept_content/2.

% #show num_concept_events/1.

% #show has_concept_cover/2.
% #show has_content/2.
% #show subs/3.
% #show has_dir_content/2.
% #show eval_body/2.
% #show is_content/1.

% is_content(C) :- has_content(_,C).

