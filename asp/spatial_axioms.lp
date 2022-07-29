
%%% RCC STYLE

connected(X,X) :- event(X).
connected(Y,X) :- connected(X,Y).

connected(X,Y) :- space_equal(X,Y).

disconnected(X,Y) :- event(X), event(Y), not connected(X,Y).
:- event(X), event(Y), disconnected(X,Y), connected(X,Y).
disconnected(Y,X) :- disconnected(X,Y).

% Deze line is gek.. dus geskipt nu
part(X,Y) :- event(X), event(Y), connected(Z,Y) : connected(Z,X), event(Z).


%% Minimal transitivity?
part(X,Z) :- part(X,Y), part(Y,Z).

connected(Z,Y) :- part(X,Y), connected(Z,X).

%redundant but maybe faster
part(X,X) :- event(X).


prop_part(X,Y) :- part(X,Y), not part(Y,X).
part(X,Y) :- prop_part(X,Y).
:- prop_part(X,Y), part(Y,X).


space_equal(X,Y) :- part(X,Y), part(Y,X).
part(X,Y) :- space_equal(X,Y) .
space_equal(Y,X) :- space_equal(X,Y).


space_overlap(X,Y) :- part(Z,X), part(Z,Y).

% 1{prod(X,Y,Z) : event(Z)}1 :- space_overlap(X,Y).


% discrete_from(X,Y) :- event(X), event(Y), not space_overlap(X,Y).
% :- discrete_from(X,Y), space_overlap(X,Y).


partial_overlap(X,Y) :- space_overlap(X,Y), not part(X,Y), not part(Y,X).
partial_overlap(Y,X) :- partial_overlap(X,Y).
space_overlap(X,Y) :- partial_overlap(X,Y).



ext_connected(X,Y) :- connected(X,Y), not space_overlap(X,Y).
connected(X,Y) :- ext_connected(X,Y).
:- ext_connected(X,Y), space_overlap(X,Y).



% tang_prop_part(X,Y) :- prop_part(X,Y), ext_connected(X,Z), ext_connected(Y,Z).
% prop_part(X,Y) :- tang_prop_part(X,Y).


% non_tang_prop_part(X,Y) :- prop_part(X,Y), not ext_connected(Z,X) : ext_connected(Z,Y).
% prop_part(X,Y) :- non_tang_prop_part(X,Y).


%% operations: ik kan zeggen: sum moet aan eisen voldoen, of alles dat aan eisen voldoet is sum...

% sum(Y,X,Z) :- sum(X,Y,Z).

% % 1 {connected(V,X) ; connected(V,Y)} :- sum(X,Y,Z), connected(V,Z).
% :- sum(X,Y,Z), connected(V,Z), not connected(V,X), not connected(V,Y).

% connected(V,Z) :- sum(X,Y,Z), connected(V,X).



% prod(Y,X,Z) :- prod(X,Y,Z).
% connected(V,X) :- prod(X,Y,Z), connected(V,Z).
% connected(V,Y) :- prod(X,Y,Z), connected(V,Z).


%% Every spatial region (for which a sum of part is defined....?) is connected

% :- sum(X,Y,Z), not connected(X,Y).
% :- prod(X,Y,Z), not connected(X,Y).


%% Niet nodig denk ik?
% compl(Y,X) :- compl(X,Y).
% connected(Z,Y) :- compl(X,Y), not non_tang_prop_part(Z,X).
% :- compl(X,Y), connected(Z,Y), non_tang_prop_part(Z,X).

% space_overlap(Z,Y) :- compl(X,Y), not part(Z,X).
% :- compl(X,Y), space_overlap(Z,Y), part(Z,X).



%Product, union, differenct, universal...










%%% COMPOSITION TABLE STYLE

% space_equal(X,X) :- event(X).

% 1 {space_equal(X,Y); disc(X,Y); extc(X,Y); space_part_overlap(X,Y); prop_part(X,Y); prop_part(Y,X)} 1 :- event(X), event(Y).



% % Symmetry

% space_equal(X,Y) :- space_equal(Y,X).
% disc(X,Y) :- disc(Y,X).
% extc(X,Y) :- extc(Y,X).
% space_part_overlap(X,Y) :- space_part_overlap(Y,X).


%Composition for equal

space_equal(X,Z) :- space_equal(X,Y), space_equal(Y,Z).
% disconnected(X,Z) :- space_equal(X,Y), disconnected(Y,Z).
% ext_connected(X,Z) :- space_equal(X,Y), ext_connected(Y,Z).

% space_part_overlap(X,Z) :- space_equal(X,Y), space_part_overlap(Y,Z).

prop_part(X,Z) :- equal(X,Y), prop_part(Y,Z).
prop_part(Z,X) :- equal(X,Y), prop_part(Z,Y).

% % Composition for Disconnected regions

% 1{ disc(X,Z); extc(X,Z); space_part_overlap(X,Z); prop_part(X,Z) } 1 :- disc(X,Y), extc(Y,Z).

% 1{ disc(X,Z); extc(X,Z); space_part_overlap(X,Z); prop_part(X,Z) } 1 :- disc(X,Y), space_part_overlap(Y,Z).

% 1{ disc(X,Z); extc(X,Z); space_part_overlap(X,Z); prop_part(X,Z) } 1 :- disc(X,Y), prop_part(Y,Z).

% disc(X,Z) :- disc(X,Y), prop_part(Z,Y).

% % Redundant
% disc(X,Z) :- disc(X,Y), space_equal(Y,Z).


% % Composition for Partially overlapping regions

% 1{ disc(X,Z); extc(X,Z); space_part_overlap(X,Z); prop_part(Z,X) } 1:- space_part_overlap(X,Y), disc(Y,Z).

% % Only matters for tangent
% % 1{ disc(X,Z), extc(X,Z), space_part_overlap(X,Z), prop_part(Z,X) } 1:- space_part_overlap(X,Y), extc(Y,Z).

% 1{ space_part_overlap(X,Z); prop_part(X,Z) } 1:- space_part_overlap(X,Y), prop_part(Y,Z).

% 1{ disc(X,Z); extc(X,Z); space_part_overlap(X,Z); prop_part(Z,X) } 1 :- space_part_overlap(X,Y), prop_part(Z,Y).

% % Redundant
% space_part_overlap(X,Z) :- space_part_overlap(X,Y), space_equal(Y,Z).



% % Composition for Proper part

disconnected(X,Z) :- prop_part(X,Y), disconnected(Y,Z).

% 1 {disc(X,Z); extc(X,Z)} 1 :- prop_part(X,Y), extc(Y,Z).


% 1 {disc(X,Z); extc(X,Z); space_part_overlap(X,Z); prop_part(X,Z)} 1 :- prop_part(X,Y), space_part_overlap(Y,Z).


% prop_part(X,Z) :- prop_part(X,Y), prop_part(Y,Z).

% % alles kan :- prop_part(X,Y), prop_part(Z,Y).

% % Not redundant!
% prop_part(X,Z) :- prop_part(X,Y), space_equal(Y,Z).



% % Composition for Inverse Proper part

% 1{disc(X,Z); extc(X,Z); space_part_overlap(X,Z); prop_part(Z,X) }1 :- prop_part(Y,X), disc(Y,Z).

% 1{extc(X,Z); space_part_overlap(X,Z); prop_part(Z,X) }1 :- prop_part(Y,X), extc(Y,Z).

% 1{ space_part_overlap(X,Z); prop_part(Z,X) }1 :- prop_part(Y,X), space_part_overlap(Y,Z).

% 1{space_equal(X,Z); extc(X,Z); space_part_overlap(X,Z); prop_part(Z,X) }1 :- prop_part(Y,X), prop_part(Y,Z).

% Not redundant!
% prop_part(Z,X) :- prop_part(Y,X), space_equal(Y,Z).

