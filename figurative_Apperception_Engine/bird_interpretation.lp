%%% Init file
{ init(s(c_high, obj_head)) } .
{ init(s(c_low, obj_head)) } .

{ init(s(c_high, obj_foot)) } .
{ init(s(c_low, obj_foot)) } .

{ init(s(c_wet, obj_head)) } .
{ init(s(c_dry, obj_head)) } .

{ init(s(c_foot, obj_liquid))}.
{ init(s(c_head, obj_liquid))}.


1{ init(s2v(c_temp, obj_head, I)) : number(I)}1.
1{ init(s2v(c_press, obj_head, I)) : number(I)}1.


%%% Interpretation file

1 { rule_var_group(R, VG) : is_var_group(VG) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_body(R, VA) : is_var_atom(VA) } 1 :- is_regsucc_rule(R), use_rule(R).

1 { rule_body(R, VA) : var_content(VA) } 1 :- is_causal_rule(R), use_rule(R).

1 { rule_head_co(R, CO) : head_content(CO) } 1 :- is_fig_rule(R), use_rule(R).


is_causal_rule(r2).

:- not rule_body(r2, s(var_y, (c_head, c_head))).
:- not rule_head_co(r2, s(var_x, (c_high, c_low))).

is_causal_rule(r3).
is_causal_rule(r4).
is_causal_rule(r5).
is_causal_rule(r6).

use_rule(r3).
use_rule(r4).


:- not rule_body(r3, s(var_x, (c_high, c_high))).
:- not rule_head_co(r3, s(var_x, (c_wet, c_dry))).

:- not rule_body(r4, s(var_x, (c_wet, c_dry))).
:- not rule_head_co(r4, s2v(c_temp, var_x, down)).

:- not rule_body(r5, s2v(c_temp, var_x, down)).
:- not rule_head_co(r5, s2v(c_press, var_x, down)).

:- not rule_body(r6, s2v(c_press, var_x, down)).
:- not rule_head_co(r6, s(var_y, (c_foot, c_head))).

is_causal_rule(r7).
is_causal_rule(r8).
is_causal_rule(r9).
is_causal_rule(r10).
is_causal_rule(r11).


:- not rule_body(r7, s(var_x, (c_low, c_low))).
:- not rule_head_co(r7, s(var_x, (c_dry, c_wet))).

:- not rule_body(r8, s(var_x, (c_dry, c_wet))).
:- not rule_head_co(r8, s2v(c_temp, var_x, up)).

:- not rule_body(r9, s2v(c_temp, var_x, up)).
:- not rule_head_co(r9, s2v(c_press, var_x, up)).

:- not rule_body(r10, s2v(c_press, var_x, up)).
:- not rule_head_co(r10, s(var_y, (c_head, c_foot))).

:- not rule_body(r11, s(var_y, (c_foot, c_foot))).
:- not rule_head_co(r11, s(var_x, (c_low, c_high))).



conc_cov(A,B) :- concept_event(A), concept_event(B), A!=B, time_covers(A,B).

{ use_rule(R) } :- is_regsucc_rule(R).
{ use_rule(R) } :- is_causal_rule(R).


#show conc_cov/2.
#show init/1.
#show rule_body/2.
#show rule_head_co/2.

%%% Subs file
contains_var(var_group_x, var_x).
contains_var(var_group_y, var_y).

contains_var(var_group_x_y, var_x).
contains_var(var_group_x_y, var_y).


subs_group(var_group_x, subs_x_1).
subs(subs_x_1, var_x, obj_head).

subs_group(var_group_y, subs_y_1).
subs(subs_y_1, var_y, obj_liquid).

subs_group(var_group_x_y, subs_x_y_1).
subs(subs_x_y_1, var_x, obj_head).
subs(subs_x_y_1, var_y, obj_liquid).


%%%%

is_var_fluent(s(c_high, var_x)).
is_var_fluent(s(c_low, var_x)).

is_var_fluent(s(c_foot, var_y)).
is_var_fluent(s(c_head, var_y)).


is_var_fluent(s(c_wet, var_x)).
is_var_fluent(s(c_dry, var_x)).
is_var_fluent(s2v(c_temp, var_x, 1)).
is_var_fluent(s2v(c_press, var_x, 1)).



%% COSTS
:~ rule_body(R, A). [1 @ 2, R, A]

:~ rule_head_co(R, A). [1 @ 2, R, A]

:~ init(A). [1 @ 2, A]

