# figurative_apperception_engine

This folder contains raw code for the figurative apperception engine. It may be used for grading, but it has not been properly structured or clean yet. This will be done in the near future

The important files are figurative_events.lp, figurative_synthesis.lp, figurative_judgements.lp, temporal_axioms.lp, figurative_backbone.lp, figurative_constraints.lp. 

If one also wants to apply spatial synthesis, then spatial_synthesis.lp and spatial_axioms.lp must also be used.

The input files start with 'input_', and often come with interpretation files that have the same name, but instead end with '_interpretation'

example commands:

clingo figurative_events.lp  temporal_axioms.lp input_speeding.lp figurative_backbone.lp figurative_synthesis.lp speeding_interpretation.lp figurative_constraints.lp figurative_judgements.lp 

clingo figurative_events.lp  temporal_axioms.lp  figurative_backbone.lp figurative_synthesis.lp figurative_constraints.lp figurative_judgements.lp input_2.lp figurative_interpretation_2.lp

clingo input_leftright_6.lp temporal_axioms.lp spatial_synthesis.lp spatial_axioms.lp figurative_backbone.lp figurative_constraints.lp figurative_events.lp figurative_synthesis.lp figurative_judgements.lp

At the moment it is not guaranteed that all other inputs are solved by the system as intended.
