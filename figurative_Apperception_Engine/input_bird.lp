senses(s(c_high, obj_head), 1).
% senses(s(c_low, obj_foot), 1).
senses(s(c_wet, obj_head), 1).
senses(s2v(c_temp, obj_head, 5),1).
senses(s2v(c_press, obj_head, 10),1).


senses(s(c_high, obj_head), 2).
senses(s2v(c_temp, obj_head, 3), 2).


senses(s(c_high, obj_head), 3).
senses(s(c_dry, obj_head), 3).
senses(s2v(c_temp, obj_head, 1), 3).


% senses(s(c_high, obj_head), 4).
senses(s2v(c_press, obj_head, 1), 4).

% senses(s(c_head, obj_liquid), 5).


% senses(s2v(c_press, obj_head, 5),3).

% senses(s(c_foot, obj_liquid),5).

senses(s(c_head, obj_liquid),5).
% senses(s(c_low, obj_head),6).

% senses(s(c_low, obj_head), 3).
% senses(s(c_wet, obj_head), 4).


% init(s(c_high, obj_head)).
% init(s(c_low, obj_foot)).

% init(s(c_wet, obj_head)).




% senses(s(c_dry, obj_head), 2).
% senses(s(c_dry, obj_head), 2).


% senses(s(c_low, obj_foot), 1).

% senses(s(c_dry, obj_head), 2).
% senses(s(c_wet, obj_foot), 2).

% senses(s(c_low, obj_head), 2).
% senses(s(c_high, obj_foot), 2).


% senses(s2(c_temp, obj_head, 5)).
% senses(s(c_wet, obj_head), 1).

% senses(s(c_dry, obj_head), 1).

% senses(s2(c_temp, obj_head, 4)).

% senses(s(c_low, obj_head)).
% senses(s(c_high, obj_foot)).

% senses(s(c_wet, obj_head)).

% senses(s2(c_temp, obj_head, 10)).

% senses(s2(c_dry, obj_head, 10)).


incompossible(s(c_wet, obj_head), s(c_dry, obj_head)).
% incompossible(s(c_wet, obj_foot), s(c_dry, obj_foot)).

incompossible(s(c_high, obj_head), s(c_low, obj_head)).
incompossible(s(c_low, obj_head), s(c_high, obj_head)).

incompossible(s(c_high, obj_head), s(c_high, obj_foot)).
incompossible(s(c_low, obj_head), s(c_low, obj_foot)).


incompossible(s(c_foot, obj_liquid), s(c_head, obj_liquid)).

inits(4).