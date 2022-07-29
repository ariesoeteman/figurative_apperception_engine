echo "Processing data/space/leftright.lp."

clingo --warn=no-atom-undefined --quiet=1 --time-limit=14400 data/space/leftright.lp temp/space_leftright_init.lp temp/space_leftright_subs.lp temp/space_leftright_var_atoms.lp temp/space_leftright_interpretation.lp asp/figurative_backbone.lp asp/figurative_constraints.lp asp/figurative_events.lp asp/figurative_judgements.lp asp/figurative_synthesis.lp asp/temporal_axioms.lp asp/spatial_axioms.lp asp/spatial_synthesis.lp  > temp/space_leftright_results.txt

