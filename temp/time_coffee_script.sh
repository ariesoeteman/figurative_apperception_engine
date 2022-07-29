echo "Processing data/time/coffee.lp."

clingo --warn=no-atom-undefined --quiet=1 --time-limit=172800 data/time/coffee.lp temp/time_coffee_init.lp temp/time_coffee_subs.lp temp/time_coffee_var_atoms.lp temp/time_coffee_interpretation.lp asp/figurative_backbone.lp asp/figurative_constraints.lp asp/figurative_events.lp asp/figurative_judgements.lp asp/figurative_synthesis.lp asp/temporal_axioms.lp   > temp/time_coffee_results.txt

