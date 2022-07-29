# figurative_apperception_engine

# The source code for chapters 4 and 6 of my thesis: "Aritificial Understanding"

The code in the 'code' directory is to a large extent copied from https://github.com/RichardEvans/apperception. All other code has been written by me.


## Installation instructions

You need to have installed Haskell and Clingo (version 4.5 or above).

1. To install Haskell:
    * go to https://www.haskell.org/downloads/

2. To install Clingo (version 4.5 or above):
    * go to https://potassco.org/clingo/

## Compilation instructions

Once you have Haskell and Clingo installed, just run (from the root directory):
   * `cd code`
   * `cabal update`
   * `cabal configure`
   * `cabal new-build`
   * `cabal install`
   * `cd ..`

## Examples

Once the system is installed (see above), you are ready to try some examples. Note that only the final theory is provided as output in the terminal. The temporal and spatio-temporal structures are sets of atomic relations in the corresponding *'my_input'_results.txt* file in the temp folder.


To run the examples, **make sure you are in the root directory called figurative_apperception**.


Two sensors, one oscillates between on and off, while the other has the same reading throughout:
   * `~/.cabal/bin/figsolve time simple.lp`

A single sensor oscillating between on and off:
   * `~/.cabal/bin/figsolve time simple_2.lp`

A spatial construction consisting of 25 regions:
   * `~/.cabal/bin/figsolve space space_simple.lp`


Speeding carts and pushed pedals, where the input is a partial event structure:
   * `~/.cabal/bin/figsolve time change.lp`


A coffee maker,note that this example takes about 20 hours to find the right model, and much longer to prove that it is the minimal model:

   * `~/.cabal/bin/figsolve time coffee.lp`


A spatial construction with learned 'left' and 'right' movements:

   * `~/.cabal/bin/figsolve space leftright.lp`


A spatial construction in which a causal rule makes observations 'irreversible', note that this example takes about 24 hours:

   * `~/.cabal/bin/figsolve space change.lp`


## Understanding the output of the solve process

When solve is run, it produces...
* the theory *θ = (φ, I, R)* composed of...
    * the initial conditions (*I*)
    * the rules (*R*)

* the temporal or spatio-temporal trace in the results file
* Movement functions in the results file
