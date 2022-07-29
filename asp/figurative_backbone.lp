
rule_subs(R, Subs) :-
    rule_var_group(R, VG),
    subs_group(VG, Subs).

has_subs(VG) :- subs_group(VG, _).

head_object_exists(R, Subs) :- 
    rule_head_co(R, s(V,_)),
    subs(Subs, V, Obj),
    object_exists(Obj).

head_object_exists(R, Subs) :- 
    rule_head_co(R, s2v(_,V,_)),
    subs(Subs, V, Obj),
    object_exists(Obj).

head_object_exists(R, Subs) :- 
    rule_head_co(R, s2(V1,V2,_)),
    subs(Subs, V1, Obj1),
    object_exists(Obj1),
    subs(Subs, V2, Obj2),
    object_exists(Obj2).


object_exists(O) :-
    concept_event(E), has_content(E, s(O,_)).

object_exists(O) :-
    concept_event(E), has_content(E, s2(O,_,_)).

object_exists(O) :-
    concept_event(E), has_content(E, s2(_,O,_)).

object_exists(O) :-
    concept_event(E), has_content(E, s2v(_,O,_)).


eval_body(R, Subs, E) :-    
    rule_subs(R, Subs),
    concept_event(E),
    eval_content(VC, Subs, E) : rule_body(R, VC).


holds_at_event(s(C,O),E):-
    has_content(E, s(O,(C,C))).

holds_at_event(s2(C,O1,O2),E):-
    has_content(E, s2(O1,O2,(C,C))).


ground_atom(s(C, V), s(C, Obj), Subs) :-
    is_var_fluent(s(C, V)),
    subs(Subs, V, Obj).

ground_atom(s2(C, V1,V2), s2(C, O1,O2), Subs) :-
    is_var_fluent(s2(C, V1, V2)),
    subs(Subs, V1, O1),
    subs(Subs, V2, O2).



eval_content(VC,Subs,E) :-
    ground_content(VC, GC, Subs),
    holds_at_event(GC, E).


holds_at_event(GC,E):-
    has_content(E,GC).

eval_content(VC, Subs, E) :-
    ground_content(VC, s(O,(C1,C1)), Subs),
    permanent(s(C1, O)),
    is_concept_event(E).

eval_content(VC, Subs, E) :-
    ground_content(VC, s2(O1,O2,(C1,C1)), Subs),
    permanent(s2(C1, O1, O2)),
    is_concept_event(E).


ground_content(s(V,(C1,C2)), s(Obj, (C1,C2)), Subs) :-
    is_content(s(Obj, (C1,C2))),
    subs(Subs, V, Obj).

ground_content(s2(V1,V2,(C1,C2)), s2(O1, O2, (C1,C2)), Subs) :-
    is_content(s2(O1,O2, (C1,C2))),
    subs(Subs, V1, O1),
    subs(Subs, V2, O2).


ground_content(s2v(Conc,V,(Val1,Val2)), s2v(Conc, Obj, (Val1,Val2)), Subs) :-
    is_content(s2v(Conc,Obj, (Val1,Val2))),
    subs(Subs, V, Obj).


eval_content(VC,Subs,E) :-
    ground_dir_content(VC, GC, Subs),
    dir_holds_at_event(GC, E).

ground_dir_content(s2v(C,V,Dir), s2v(C,Obj,Dir), Subs) :-
    var_dir_content(s2v(C,V,Dir)), subs(Subs, V, Obj).


dir_holds_at_event(s2v(C,Obj,up), E) :-
    has_content(E, s2v(C,Obj,(V1,V2))), V1 < V2.

dir_holds_at_event(s2v(C,Obj,down), E) :-
    has_content(E, s2v(C,Obj,(V1,V2))), V1 > V2.


is_ground_atom(s(C,Obj)) :-
    ground_atom(_, s(C,Obj), _).


is_ground_atom(s2(C,O1,O2)) :-
    ground_atom(_, s2(C,O1,O2), _).

% is_content(s(Obj,(C,C))) :-
%     is_ground_atom(s(C,Obj)).

% is_content(s(Obj,(C1,C2))) :-
%     is_ground_atom(s(C1,Obj)),
%     is_ground_atom(s(C2,Obj)),
%     incompossible(s(C1,Obj),s(C2,Obj)).


%% Content from ground atoms, incompossible properties
%% And 'changing' input-events

is_content(s(Obj,(C1,C1))) :-
    is_ground_atom(s(C1,Obj)).

is_content(s(Obj,(C1,C2))) :-
    is_ground_atom(s(C1,Obj)),
    same_property(C1,C2).

is_content(s2(O1,O2,(C,C))) :-
    is_ground_atom(s2(C,O1,O2)).


is_content(s2(O1,O2,(C1,C2))) :-
    is_ground_atom(s2(C1, O1, O2)),
    same_property(C1,C2).

%%%%%%%%%% Var fluents, atoms, permanents etc.

is_var_fluent(S) :- var_fluent(S, _).
% is_var_permanent(S) :- var_permanent(S, _).

is_var_atom(S) :- is_var_fluent(S).
is_var_atom(S) :- is_var_permanent(S).


var_content(s(V,(C,C))) :-
    is_var_atom(s(C,V)).

var_content(s(V,(C1,C2))) :-
    is_var_atom(s(C1,V)),
    is_var_atom(s(C2,V)),
    same_property(C1,C2).

var_content(s2(V1,V2,(C,C))) :-
    is_var_atom(s2(C,V1,V2)).

var_content(s2(V1,V2,(C1,C2))) :-
    is_var_atom(s2(C1, V1, V2)),
    is_var_atom(s2(C2, V1, V2)),
    same_property(C1,C2).



var_content(s2v(C,O,(N,N))) :-
    is_var_fluent(s2v(C, O, V)),
    number(N).


head_content(s(Var,(C1,C1))) :-
    cause_head(s(C1,Var)).

head_content(s(Var,(C1,C2))) :-
    cause_head(s(C1,Var)), 
    cause_head(s(C2,Var)),
    same_property(C1,C2).


head_content(s2(V1,V2,(C1,C1))) :-
    cause_head(s2(C1,V1,V2)).

head_content(s2(V1,V2,(C1,C2))) :-
    cause_head(s2(C1,V1,V2)), 
    cause_head(s2(C2,V1,V2)),
    same_property(C1,C2).


var_content(VC) :- var_dir_content(VC).


var_dir_content(s2v(C, Var, Dir)) :-
    is_var_dir_fluent(s2v(C, Var, Dir)).

is_var_dir_fluent(s2v(C, Var, up)) :- 
    is_var_fluent(s2v(C, Var, _)).

is_var_dir_fluent(s2v(C, Var, down)):- 
    is_var_fluent(s2v(C, Var, _)).


cause_head(s(C, V)) :-
    is_var_fluent(s(C, V)),
    not is_static_concept(C).

cause_head(s2(C, V1,V2)) :-
    is_var_fluent(s2(C, V1,V2)),
    not is_static_concept(C).


cause_head(s2v(C, Var, Dir)) :-
    is_var_dir_fluent(s2v(C, Var, Dir)),
    not is_static_concept(C).

head_content(s2v(C,Var,Dir)) :-
    cause_head(s2v(C,Var,Dir)).

%%%%%%%%%%
%%%%%%%%%% Check which variables occur in a rule
is_var_group(VG) :- 
    subs_group(VG, _).

var_in_rule(V,R):- 
    var_in_rule_head(V,R).

var_in_rule(V,R):- 
    var_in_rule_body(V,R).


var_in_rule_head(V,R) :-
    rule_head_co(R,s(V,_)).

var_in_rule_head(V,R) :-
    rule_head_co(R,s2(V,_,_)).

var_in_rule_head(V,R) :-
    rule_head_co(R,s2(_,V,_)).

var_in_rule_head(V,R) :-
    rule_head_co(R,s2v(_,V,_)).


var_in_rule_body(V,R) :-
    rule_body(R,s(V,_)).

var_in_rule_body(V,R) :-
    rule_body(R,s2(V,_,_)).

var_in_rule_body(V,R) :-
    rule_body(R,s2(_,V,_)).


var_in_rule_body(V,R) :-
    rule_body(R,s2v(_,V,_)).





incompossible_contents(sv(C,(V1,V1)), sv(C,(V2,V2))) :-
    is_content(sv(C,(V1,V1))), is_content(sv(C,(V2,V2))), V1 != V2.

incompossible_contents(s2v(C1,O,(V1,V1)), s2v(C2,O,(V2,V2))) :-
    incompossible(sv(C1,V1), sv(C2,V2)), is_object(O).

incompossible_contents(s2v(C,O,(V1,V1)), s2v(C,O,(V2,V2))) :-
    is_content(s2v(C,O,(V1,V1))), is_content(s2v(C,O,(V2,V2))), V1 != V2.

incompossible_contents(s2v(C1,O,(V1,V1)), s2v(C2,O,(V2,V2))) :-
    incompossible(s2v(C1,O,V1), s2v(C2,O,V2)).


incompossible(X,Y) :- 
    incompossible(Y,X).

% incompossible_events(E1,E2) :-
%     has_content(E1,C1), has_content(E2,C2),
%     incompossible(C1,C2).

% incompossible_events(E1,E2) :-
%     incompossible_events(E2,E1).


incompossible_contents(s(O,(C1,C1)), s(O,(C2,C2))) :- 
    incompossible(s(C1,O), s(C2,O)).

incompossible(s(C1,O), s(C2,O)) :- 
    incompossible(C1,C2), senses(s(C1,_),_), is_object(O).

incompossible(s(C1,O), s(C2,O)) :- 
    incompossible(C1,C2), input((s(C1,_),_)), is_object(O).



incompossible_contents(s2(O1,O2,(C1,C1)), s2(O1,O2,(C2,C2))) :- 
    incompossible(s2(C1,O1,O2), s2(C2,O1,O2)).

incompossible(s2(C1,O1,O2), s2(C2,O1,O2)) :- 
    incompossible(C1,C2), senses(s2(C1,_,_),_), is_object(O1), is_object(O2).

incompossible(s2(C1,O1,O2), s2(C2,O1,O2)) :- 
    incompossible(C1,C2), input((s2(C1,_,_),_)), is_object(O1), is_object(O2).


% Incompossible contents
incompossible_events(E1,E2) :-
    has_content(E1,C1), has_content(E2,C2),
    incompossible_contents(C1,C2).


same_property(C1,C1) :- is_var_fluent(s(C1,_)).

same_property(C1,C2) :- is_content(s(_,(C1,C2))).

same_property(C1,C2) :- incompossible(s(C1,O), s(C2,O)).


same_property(C1,C1) :- is_var_fluent(s2(C1,_,_)).

same_property(C1,C2) :- is_content(s2(_,_,(C1,C2))).

same_property(C1,C2) :- incompossible(s2(C1,O1,O2), s2(C2,O1,O2)).


% same_property(C1,C1) :- is_var_fluent(sv(C1,_)).

% same_property(C1,C2) :- is_content(s(_,(C1,C2))).

% same_property(C1,C2) :- incompossible(s(C1,O), s(C2,O)).

events_same_prop_sv(E1,E2) :-
    has_content(E1, sv(C,_)),
    has_content(E2, sv(C,_)).


is_content(C) :- has_content(_,C).

same_obj_and_prop_s(s(O,(C1,C2)), s(O,(C3,C4))) :- 
    is_content(s(O,(C1,C2))), is_content(s(O,(C3,C4))),
    same_property(C1,C3).

events_same_obj_and_prop_s(E1,E2) :- 
    has_content(E1,C1), has_content(E2,C2), 
    same_obj_and_prop_s(C1,C2).


same_obj_and_prop_s2(s2(O1,O2,(C1,C2)), s2(O1,O2,(C3,C4))) :- 
    is_content(s2(O1,O2,(C1,C2))), is_content(s2(O1,O2,(C3,C4))),
    same_property(C1,C3).


events_same_obj_and_prop_s2(E1,E2) :- 
    has_content(E1,C1), has_content(E2,C2), 
    same_obj_and_prop_s2(C1,C2).


events_same_obj_and_prop_s2v(E1,E2) :- 
    has_content(E1, s2v(C,O,_)),
    has_content(E2, s2v(C,O,_)).


events_same_obj_and_prop(E1,E2) :- events_same_obj_and_prop_s(E1,E2).
events_same_obj_and_prop(E1,E2) :- events_same_obj_and_prop_s2(E1,E2).
events_same_obj_and_prop(E1,E2) :- events_same_obj_and_prop_s2v(E1,E2).

% events_same_obj(E1,E2) :-
%     has_content(E1, s(O,_)),
%     has_content(E2, s(O,_)).

% events_same_obj(E1,E2) :-
%     has_content(E1, s(O,_)),
%     has_content(E2, s2v(_,O,_)).

% events_same_obj(E1,E2) :-
%     has_content(E1, s2v(_,O,_)),
%     has_content(E2, s2v(_,O,_)).



chain_same_value_s(E1,E2) :- 
    has_content(E1, s(O,(_,C2))), has_content(E2, s(O,(C2,_))).

chain_same_value_s2(E1,E2) :- 
    has_content(E1, s2(O1,O2,(_,C2))), has_content(E2, s2(O1,O2,(C2,_))).

chain_same_value_s2v(E1,E2) :- 
    has_content(E1, s2v(C, O, (_,V2))), 
    has_content(E2, s2v(C, O, (V2,_))).


chain_same_value(E1,E2) :- chain_same_value_s(E1,E2).
chain_same_value(E1,E2) :- chain_same_value_s2(E1,E2).
chain_same_value(E1,E2) :- chain_same_value_s2v(E1,E2).


has_s_content(E) :- has_content(E, s(_,_)).
has_s2_content(E) :- has_content(E, s2(_,_,_)).
has_s2v_content(E) :- has_content(E, s2v(_,_,_)).




has_object(E,O) :-
    has_content(E, s(O,_)).


has_object(E,O) :-
    has_content(E, s2(O,_,_)).

has_object(E,O) :-
    has_content(E, s2(_,O,_)).

has_object(E,O) :-
    has_content(E, s2v(_,O,_)).

events_same_obj(E1,E2) :-
    has_object(E1,O), has_object(E2,O).
%%%%

is_fig_rule(R) :- is_causal_rule(R).
is_fig_rule(R) :- is_regsucc_rule(R).