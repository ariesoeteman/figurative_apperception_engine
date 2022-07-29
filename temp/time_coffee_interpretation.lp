% Auto-generated from GenInterpretation

%------------------------------------------------------------------------------
% Elements
%------------------------------------------------------------------------------

is_concept(c_on).
is_concept(c_off).
is_concept(c_basin).
is_concept(c_vape).
is_concept(c_filter).
is_concept(c_coffee).
is_type(t_resource).
is_type(t_machine).

%------------------------------------------------------------------------------
% Typing
%------------------------------------------------------------------------------

permanent(isa(t_resource, obj_water)).
permanent(isa(t_machine, obj_maker)).


%------------------------------------------------------------------------------
% Update rules
%------------------------------------------------------------------------------

1 { rule_var_group(R, VG) : is_var_group(VG) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_body(R, VA) : var_content(VA) } 1 :- is_fig_rule(R), use_rule(R).

1 { rule_head_co(R, CO) : head_content(CO) } 1 :- is_fig_rule(R), use_rule(R).

is_regsucc_rule(r1).
is_causal_rule(r2).
is_causal_rule(r3).
is_causal_rule(r4).
is_causal_rule(r5).
is_causal_rule(r6).
{ use_rule(R) } :- is_regsucc_rule(R).
{ use_rule(R) } :- is_causal_rule(R).

%------------------------------------------------------------------------------
% Stats
%------------------------------------------------------------------------------

num_objects(2).
num_variables(2).
