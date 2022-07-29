%------------------------------------------------------------------------------
% Verify judgements.
% Every variable group referenced in a judgement must have a corresponding subs
%------------------------------------------------------------------------------
:- violation(_).

violation(var_group(R, VG)) :-
    rule_var_group(R, VG),
    not has_subs(VG).

% has_subs(VG) :- subs_group(VG, _).

% Every variable that appears in a rule must be contained in the rule's group.
violation(undefined_var(R, V)) :-  
    var_in_rule(V, R), 
    rule_var_group(R, VG), 
    not contains_var(VG, V).


violation(unused(R, V)) :-  
    not var_in_rule(V, R), 
    rule_var_group(R, VG), 
    contains_var(VG, V).

%% COSTS
% :~ rule_body(R, A). [1 @ 2, R, A]

% :~ rule_head_co(R, A). [1 @ 2, R, A]

:~ use_rule(R). [2 @ 2, R]


:~ init(A). [1 @ 2, A]
