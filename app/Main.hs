module Main where

import Lib

main :: IO ()
main = load "test.yaml" >>= print
