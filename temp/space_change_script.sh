echo "Processing data/space/change.lp."

clingo --warn=no-atom-undefined --quiet=1 --time-limit=172800 data/space/change.lp temp/space_change_init.lp temp/space_change_subs.lp temp/space_change_var_atoms.lp temp/space_change_interpretation.lp asp/figurative_backbone.lp asp/figurative_constraints.lp asp/figurative_events.lp asp/figurative_judgements.lp asp/figurative_synthesis.lp asp/temporal_axioms.lp asp/spatial_axioms.lp asp/spatial_synthesis.lp  > temp/space_change_results.txt

