space.

%% Sensed events are 'atomic' spaces
atomic_space(E) :- sense_input_event(E,_,_).


sub_atomic_space(-E) :- atomic_space(E).
event(E) :- sub_atomic_space(E).


has_event(M,-E) :- has_event(M,E), atomic_space(E).

prop_part(-E, E) :- atomic_space(E).
connected(-E, E) :- atomic_space(E).


%Sub-atomic space is 'non-tangenial' core
:- sub_atomic_space(A), connected(E, A),
	not sub_atomic_space(E), not part(-A,E).


space_equal(E1,E2) :- atomic_space(E1), atomic_space(E2), space_overlap(E1,E2).
space_equal(A1,A2) :- sub_atomic_space(A1), sub_atomic_space(A2), connected(A1,A2).


element(E) :- atomic_space(E).
element(E) :- sub_atomic_space(E).

%For speedup
space_equal(-A1,-A2) :- 
	space_equal(A1,A2), atomic_space(A1), atomic_space(A2).

space_equal(-A1,-A2) :- sub_atomic_space(A1), sub_atomic_space(A2), 
	connected(A1,A2).

%% 2D

neighbour_number(0..7).

even(0;2;4;6).
odd(1;3;5;7).

nextto(I, I+1) :- neighbour_number(I), neighbour_number(I+1).
nextto(7,0).
nextto(I,I) :- neighbour_number(I).
nextto(I1,I2) :- nextto(I2,I1).
nextto(0,2).
nextto(2,4).
nextto(4,6).
nextto(6,0).

space_designator(E1) :- atomic_space(E1), E1 <= E2 : space_equal(E1,E2).

1{neighbour(E1,E2,I) : neighbour_number(I)}1 :-
	atomic_space(E1), atomic_space(E2), connected(E1, E2), not space_equal(E1,E2), space_designator(E1), space_designator(E2).

:- neighbour(A,N1,I), neighbour(A,N2,I), N1 != N2.

:- neighbour(A, N1, I1), neighbour(A, N2, I2), nextto(I1,I2), not connected(N1, N2).
:- neighbour(A, N1, I1), neighbour(A, N2, I2), not nextto(I1,I2), connected(N1, N2).


%% Nog testen

:- locally_grid, neighbour(A,N1,I1), even(I1), neighbour(A,N2,I2), I2 = (I1+2)\8, neighbour(N1,Third,_), neighbour(N2,Third,_),
	A != Third, not neighbour(A,Third,I1+1).

%% HIERMEE WERKEN KLEINE VOORBEELDEN NIET MEER ZOALS FIGURE 6.3
:- locally_grid, neighbour(A,N1,I1), even(I1), neighbour(A,N2,I2), I2 = (I1+4)\8, neighbour(N1,Third,_), neighbour(N2,Third,_),
	A != Third, not neighbour(A, Third, I3), not neighbour(A, Third, I4), I3 = (I1+2)\8, I4 = (I1+6)\8. 

saturated(A) :- space_designator(A), 
	neighbour(A,_,I): neighbour_number(I).

locally_grid :- saturated(A) : space_designator(A).

neighbour(E2,E1,I2) :- neighbour(E1,E2,I1), I2 = (I1+4)\8.

% No inside corners
:- neighbour(E, _, I), odd(I), J = (I+1)\8, not neighbour(E,_,J).
:- neighbour(E, _, I), odd(I), J = (I-1)\8, not neighbour(E,_,J).

:- neighbour(E, _, I), even(I), J = (I+2)\8, neighbour(E,_,J), 
	L = (I+1)\8, not neighbour(E,_,L).


{connected(E1,E2)} :- element(E1), element(E2).



conn_path(A,B,M):- atomic_space(A), space_equal(A,B), has_event(M,A).

conn_path(A1,A2,M):- atomic_space(A1), atomic_space(A2),
	has_event(M,A1), has_event(M,A2), space_equal(A1,E1),
	space_equal(A2,E2), space_designator(E1), space_designator(E2),
	neighbour(E1,E2,I), even(I).

conn_path(A1,A3,M) :- conn_path(A1,A2,M), conn_path(A2,A3,M).

:- atomic_space(A1), atomic_space(A2), has_event(M,A1), has_event(M,A2), not conn_path(A1,A2,M).


has_atom_part(E) :- atomic_space(Atom), part(Atom,E).

:- event(E), not element(E), not concept_event(E), not has_atom_part(E).


part(B,A) :- merged_event(A,B,C).
part(C,A) :- merged_event(A,B,C).

:- merged_event(A,B,C), atomic_space(D), part(D,A), not space_equal(D,B), not space_equal(D,C).




% 'Space' events are permanent
time_covers(E1,E2) :- space_cover_event(M,E1), time_event(E2),
	E1 != E2.

%% Covers are made up of the connected parts in manifold
part(E2,E1) :- space_cover_event(M,E1), 
	has_event(M,E2),  E1 != E2. 

%% NOTE that cover can also contain other events, for instance if two covers turn out to be identical.



%%% All spaces in one sensed manifold are connected
%%% Spaces cannot overlap if sv same concept
:- sense_input_event(E1,sv(C,_), T), sense_input_event(E2,sv(C,_), T), 
	E1 != E2, space_equal(E1,E2).



%%% Two spaces should be equal if they consider the same object at the same time...
space_equal(E1,E2) :- events_same_obj(E1,E2), time_overlap(E1,E2), concept_event(E1), concept_event(E2).


% Different objects cannot occupy the same space at the same time
:- event(E1), event(E2), has_object(E1,O1), has_object(E2,O2), O1 != O2,
	time_overlap(E1,E2), space_overlap(E1,E2).


%%% Impossible atoms cannot exist in the same space and time
:- incompossible_events(E1,E2),
	space_overlap(E1,E2), time_overlap(E1,E2).



%% Add spatial cover events
space_cover_event((T,0),E+T) :-
	bottom_manifold((T,0)), has_event((T,0),_), time_cover_event(E).

space_cover_event(E) :- space_cover_event(_,E).

%% Cover is precise. If a space connects to the cover, it must connect to one of its parts.
:- has_prop_part(E1), has_prop_part(E2), not atomic_space(E1), not atomic_space(E2),
	connected(E1, E2), not connected(P1,P2) : prop_part(P1,E1), prop_part(P2,E2).


dif_atom_parts(E1,E2) :- space_cover_event(M1,E1), space_cover_event(M2,E2), atomic_space(A1),
	bottom_manifold(M1), bottom_manifold(M2), has_event(M1,A1),
	not space_equal(A1,A2): has_event(M2,A2), atomic_space(A2).

space_equal(E1,E2) :- space_cover_event(M1,E1), space_cover_event(M2,E2), 
	bottom_manifold(M1), bottom_manifold(M2), M1 != M2,
	not dif_atom_parts(E1,E2).

%%%% MOVE

move_function(Move, Cover1, Cover2) :- move(Move, (T1,T2)), 
	space_cover_event((T1,0), Cover1), space_cover_event((T2,0), Cover2).

% Note that this ensures that at least two of the atomic spaces must be connected
% connected(A,B) :- move_function(Move, A, B).
:- move_function(Move, A, B), not connected(A,B).


% Space_equal IFF atomic regions are the same (though there might be more atomic regions in one than in the other
space_equal(Cover1, Cover2) :- not move(_, (T1,T2)), T2 = T1+1,
	space_cover_event((T1,0), Cover1), space_cover_event((T2,0), Cover2).


has_equal_part_in(E1,M2) :- space_cover_event(M1,C1), space_cover_event(M2,C2), M1 != M2, space_equal(C1,C2),
	has_event(M1,E1), has_event(M2,E2), space_equal(E1,E2).

:- space_cover_event(M1,C1), space_cover_event(M2,C2), M1 != M2, space_equal(C1,C2), has_event(M1,E1), atomic_space(E1),
	has_event(M2,E2), atomic_space(E2), not has_equal_part_in(E1,M2), not has_equal_part_in(E2,M1).

% :- space_cover_event(M1,C1), space_cover_event(M2,C2), M1 != M2, space_equal(C1,C2), has_event(M1,E1), atomic_space(E1),
% 	not space_equal(E1,E2) : has_event(M2,E2), atomic_space(E2).


%% Learn 'identity' functions
% :- space_cover_event(M1,C1), space_cover_event(M2,C2), M1!=M2, space_equal(C1,C2),
% equal_paths((M1,M2),(M3,M4)), space_cover_event(M3,C3), space_cover_event(M4,C4),
% not space_equal(C3,C4). 

% :- identity((M1,M2)), M1!=M2, equal_paths((M1,M2),(M3,M4)), space_cover_event(M3,C3), space_cover_event(M4,C4),
% not space_equal(C3,C4). 

%% Space_equal -> Identity -> Identity of equal paths

identity((C1,C2)) :- space_cover_event(M1,C1), space_cover_event(M2,C2),
	space_equal(C1,C2), M1 != M2.

:- identity((M1,M2)), equal_paths((M1,M2),(M3,M4)),
	not identity((M3,M4)). 

%Wordt al gedaan vanuit 'space_equal' covers
% {space_equal(E1,E2)} :- not move(_, (T1,T2)), T2 = T1+1,
% 	has_event((T1,0), E1), has_event((T2,0), E2), atomic_space(E1), atomic_space(E2).


%%%% LEARN IDENTITY FUNCTIONS
%%% Ik kan ook nog met inverse moves gaan werken....
%% If 'space_equal' exists between covers, for instance if there is no move between two successive covers
%% then we don't take this into account in the first step of path-construction
%% since transitivity of space_equal already derives identity in this case

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Werkend deel

% path((T1,T2)):- move(F,(T1,T2)).
% path((T1,T3)) :- path((T1,T2)), move(F, (T2,T3)).
% path((T1,T2+1)) :- path((T1,T2)), subjective_time(T2+1), not move(_,(T2,T2+1)).


% path(T1,T2) :- subjective_time(T1), subjective_time(T2), T1<T2.


equal_paths((S1,E1),(S2,E2)) :- move(F, (S1, E1)), move(F, (S2,E2)).

equal_paths((S1,NE1),(S2,NE2)):- equal_paths((S1,E1),(S2,E2)), move(F, (E1, NE1)), move(F, (E2, NE2)).

equal_paths((S1,E1+1),(S2,E2)):- equal_paths((S1,E1),(S2,E2)),
	subjective_time(E1+1), not move(_,E1,E1+1).

% equal_paths((S1,E1),(S2,E2+1)):- equal_paths((S1,E1),(S2,E2)), 
% 	subjective_time(E2+1), not move(_,E2,E2+1).

% Single moves cannot go to identical space
% This is already enforced since move is asymmetrical
% But explicit statement of this achieves speedup
% {identity(I)} :- path(I), not move(_,I).
% identity(J):- identity(I), equal_paths(I,J).

% :- identity(I), move(_,I).

% :- identity(I), equal_paths(I,J), not identity(J).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% {inverse(F,G)}:- move(F,_), move(G,_), F != G.
% inverse(G,F) :- inverse(F,G).

% identity((S1,E2)):- inverse(F,G), move(F,(S1,E1)), move(G,(E1,E2)).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55 not needed if no identity
% space_equal(Cover1,Cover2)	:-
% 	identity((Start,End)), space_cover_event((Start,0),Cover1),
% 	space_cover_event((End,0),Cover2).




% Handig voor bijvoorbeeld reflexive identity, of identity between manifolds waartussen niet gemoved wordt
% identity(Start,End) :-
% 	space_cover_event((Start,0),Cover1), Start < End,
% 	space_cover_event((End,0),Cover2), space_equal(Cover1,Cover2).
%%%%%%%%%%%%


move_function(Move, S1, S3) :- move_function(Move, S1, S2), space_equal(S2,S3), space_cover_event(S3).
move_function(Move, S3, S2) :- move_function(Move, S1, S2), space_equal(S1,S3), space_cover_event(S2).

space_equal(S2,S3) :- move_function(Move, S1, S2), move_function(Move, S1, S3).
space_equal(S1,S3) :- move_function(Move, S1, S2), move_function(Move, S3, S2).

% If we view move as traversal on 2D plane, then it is an isomorphism
connected(S2,S4) :- move_function(Move, S1, S2), move_function(Move, S3, S4),
					connected(S1,S3).

connected(S1,S3) :- move_function(Move, S1, S2), move_function(Move, S3, S4),
					connected(S2,S4).

%%%%%%%%%%%%%%%%%%%%%%%%% Check overlap consistency over all paths
%%%%%%%%%%%%%%%%%%%%%%%%% Very slow

% move_comp((M1,M2),S1,S3) :- move_function(M1, S1,S2), 
% 	move_function(M2,S2,S3).

% move_comp((M1,M2),S1,S3) :- move_comp(M1, S1,S2), S1 != S2,
% 	move_function(M2,S2,S3).

% move_comp(M1,S1,S2+1) :- move_comp(M1, S1,S2), S1 != S2,
% 	not move_function(_,S2,S2+1), subjective_time(S2+1).

% comp_overlap_count(Move, C) :- 
% 	move_comp(Move, S1, S2), 
% 	C = #count{A : space_designator(A), part(A, S1), part(A,S2)}.

% :- comp_overlap_count(Move, C1), comp_overlap_count(Move, C2), C1 != C2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%55


:- move_function(Move,S1,S1).
% :- move_function(Move,S1,S2), move_function(Move, S2,S1).


%% Movement is always 'the same' in terms of overlapping regions
overlap_count(Move, C) :- 
	move_function(Move, S1, S2), 
	C = #count{A : space_designator(A), part(A, S1), part(A,S2)}.

:- overlap_count(Move, C1), overlap_count(Move, C2), C1 != C2.



%% Movement is always 'the same' in terms of spatial orientation
space_orient(Move,I):- move_function(Move, S1, S2), part(A1,S1), part(A2,S2), space_designator(A1), space_designator(A2),
	neighbour(A1,A2,I).

:- space_orient(Move,I), move_function(Move, S1,S2), 
	not neighbour(A1,A2,I) : part(A1,S1), part(A2,S2), space_designator(A1), space_designator(A2).



% %Movement is a (partial) injective function. Dit is hetzelfde als de conditie op extensies van identity-paths...
% % Als Begin en eind van identity path (dus equal spaces) worden verlengd met een move, moeten de twee bereikte spaces ook equal zijn.
% % Als Begin en eind van identity path (dus equal spaces) worden bereikt met een move, moeten de twee bron spaces ook equal zijn.
% % Dat doet identity al... maar dit werkt in het geval dat 'equal' zonder identity wordt derived.
% :- move_function(Move, S1, S2), move_function(Move, S1, S3), not space_equal(S2,S3).
% :- move_function(Move, S1, S2), move_function(Move, S3, S2), not space_equal(S1,S3).



%%%%%%%%%%
% #show neighbour/3.
% #show space_equal/2.
% #show has_content/2.
% #show move_function/3.
% #show space_cover_event/2.
% #show space_orient/2.

% partofcover(A,B):- intuit_event(A), space_cover_event(B), part(A,B).
% #show partofcover/2.

% #show overlap_count/2.

%%%%%%%