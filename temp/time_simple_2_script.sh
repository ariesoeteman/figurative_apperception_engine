echo "Processing data/time/simple_2.lp."

clingo --warn=no-atom-undefined --quiet=1 --time-limit=172800 data/time/simple_2.lp temp/time_simple_2_init.lp temp/time_simple_2_subs.lp temp/time_simple_2_var_atoms.lp temp/time_simple_2_interpretation.lp asp/figurative_backbone.lp asp/figurative_constraints.lp asp/figurative_events.lp asp/figurative_judgements.lp asp/figurative_synthesis.lp asp/temporal_axioms.lp   > temp/time_simple_2_results.txt

