module Main where

import StackWrapper

import System.Process
import System.Environment

main :: IO ()
main =
  run $ do
    name <- getProgName
    args <- getArgs
    callProcess "stack" ("exec":"--":name:args)
