module Main where

import qualified Control.Exception as Exception
import qualified Control.Monad as Monad
import qualified Data.Graph as Graph
import qualified Data.List as List
import qualified Data.Map as Map
import qualified Data.Maybe as Maybe
import qualified Data.Set as Set
import qualified Data.Universe.Helpers as Universe
import qualified System.Environment as Env
import qualified System.Process as Process

import Interpretation
import FigurativeTemplates
--import qualified OcclusionData as OcclusionData
--import qualified WalkerData as WalkerData
--import qualified SokobanData as SokobanData
--import qualified SokobanTypes as SokobanTypes
--import qualified NoisySequenceData as NoisySequenceData
--import qualified HouseData as HouseData
--import qualified HouseTypes as HouseTypes

----------------------------------- main --------------------------------------

main :: IO ()
main = do
    args <- Env.getArgs
    putStrLn $ "Solving " ++ concat (List.intersperse " " args)
    case args of
        ["time", f] -> solve_time f
        ["space", f] -> solve_space f
        -- ["figurative-synthesis"] solve_figurative_synthesis f
        _ -> putStrLn $ "Usage: figsolve time <file>"


-------------------------------------------------------------------------------
-- Misc-specific solving
-------------------------------------------------------------------------------

solve_time :: String -> IO ()
solve_time f = case lookup f figurative_templates of
    Nothing -> error $ "No fig template with this id: " ++ f
    Just (dir, template, input) -> do process_figurative dir template input "time"

solve_space :: String -> IO ()
solve_space f = case lookup f figurative_templates of
    Nothing -> error $ "No fig template with this id: " ++ f
    Just (dir, template, input) -> do process_figurative dir template input "space"

-- solve_misc :: String -> IO ()
-- solve_misc f = case lookup f misc_templates of
--     Nothing -> error $ "No misc template with this id: " ++ f
--     Just (dir, template, input) -> do process_misc dir template input

process_figurative :: String -> Template -> String -> String -> IO ()
process_figurative dir t input_f space_time = do
    (results_f, ls2) <- do_fig_solve dir input_f t space_time
    case ls2 of
        [] -> do
            putStrLn "No solution found."
        _ -> do
            let ans = last_answers ls2
            Monad.forM_ ans (write_latex t)
            let ls3 = map (process_answer_with_template t) ans
            Monad.forM_ ls3 putStrLn


do_fig_solve :: String -> String -> Template -> String -> IO (String, [ClingoOutput])
do_fig_solve dir input_f t space_time = do
    -- Generate ASP files from template
    putStrLn "Generating temporary files..."
    (name, command, results) <- do_fig_template False t dir input_f space_time

    putStrLn "Done with generating temporary files..."
    -- Call ASP solver
    putStrLn "Calling clingo..."    
    Exception.catch (Process.callCommand command) handle_command_exception

    -- Process output
    l <- readFile results
    let ls = lines l
    let ls2 = get_answers ls []    

    -- Clean up
    case flag_delete_temp of
        True -> do
            let c = "rm temp/" ++ name ++ "_*"
            Process.callCommand c
        False -> return ()

    return (results, ls2)

-- Calling the system command raises an exception...
-- but the command executes properly...
-- ...so I just ignore the exception...
handle_command_exception :: Exception.SomeException -> IO ()
handle_command_exception _ = return ()