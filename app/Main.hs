module Main where

import Data.Text
import Lib
import Text.Nicify

main :: IO ()
main = load "test/test.yaml" >>= putStrLn . nicify . show
