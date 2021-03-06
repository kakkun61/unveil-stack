module Main where

import StackWrapper

import qualified GhcLib as G

import System.Environment
import System.Process

main :: IO ()
main =
  run $ G.run "ghc" $ do
    args <- getArgs
    compilerExe <- head . lines <$> readProcess "stack" ["path", "--compiler-exe"] ""
    globalPackageDB <- head . lines <$> readProcess "stack" ["path", "--global-pkg-db"] ""
    snapshotPackageDB <- head . lines <$> readProcess "stack" ["path", "--snapshot-pkg-db"] ""
    localPackageDB <- head . lines <$> readProcess "stack" ["path", "--local-pkg-db"] ""
    callProcess compilerExe ("-package-db":globalPackageDB:"-package-db":snapshotPackageDB:"-package-db":localPackageDB:args)
