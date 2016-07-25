{-# LANGUAGE OverloadedLists #-}

module LibSpec where

import Test.Hspec
import Data.HashMap.Strict
import Data.Yaml

import Lib

spec :: Spec
spec =
  describe "Yaml fun" $
    it "can load from file" $ do
      result <- load "test/test.yaml"
      result `shouldBe` [Stack { _name = "test"
                               , _template = "stackA.json"
                               , _parameters = [
                                      ("1", [("Foo", "baz")])
                                    , ("2", [("Foo", "bar")])
                              ]}
                          ]
