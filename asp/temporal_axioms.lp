
%% Events are related by axioms of temporal order:
% 1
time_covers(B, A) :- r_before(A, B), r_after(A, B).

r_before(A, B) :- time_covers(B, A).
r_after(A, B) :- time_covers(B, A).

% 2 Overlap is reflexive and symmetric
time_overlap(E, E) :- time_event(E).
time_overlap(I,I) :- input(I).

time_overlap(A, B) :- time_overlap(B, A).

% 3 Conditions for time_overlap
time_overlap(A, B) :- time_overlap(C, B), r_after(C, A), r_before(B, A).

% 4 Transitivity
r_after(A, C) :- r_after(A, B), r_after(B, C).
r_before(A, C) :- r_before(A, B), r_before(B, C).


% 5 Conditional transitivity for time_overlap
time_overlap(A, B) :- 
time_overlap(A, C), time_overlap(C, B), r_after(C, B), r_after(C, A).

time_overlap(A, B) :- 
time_overlap(A, C), time_overlap(C, B), r_before(C, B), r_before(C, A).

% 6 Linearity
time_event(E) :- intuit_event(E).
time_event(E) :- concept_event(E).

1 {r_before(E1, E2); r_before(E2, E1) } :- time_event(E1), time_event(E2).
1 {r_after(E1, E2); r_after(E2, E1) } :- time_event(E1), time_event(E2).

1 {r_before(I1, I2); r_before(I2, I1) } :- input(I1), input(I2).
1 {r_after(I1, I2); r_after(I2, I1) } :- input(I1), input(I2).


r_strictly_before(A,B) :- r_before(A,B), not r_before(B,A).
r_strictly_after(A,B) :- r_after(A,B), not r_after(B,A).

r_before(A, B) :- r_strictly_before(A,B).
:- r_strictly_before(A,B), r_before(B,A).  

r_after(A, B) :- r_strictly_after(A,B).
:- r_strictly_after(A,B), r_after(B,A).  


%% Nog checken voor bug
{time_overlap(E1,E2)} :- time_event(E1), time_event(E2).
{time_overlap(I1,I2)} :- input(I1), input(I2).


after(E1,E2) :- r_after(E1,E2), E1 != E2.
before(E1,E2) :- r_before(E1,E2), E1 != E2.
dif_time_covers(E1,E2) :- time_covers(E1,E2), E1 != E2.


future_event(E1,E2) :- r_strictly_after(E1,E2), not time_overlap(E1,E2).