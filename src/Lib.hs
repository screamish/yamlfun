{-# LANGUAGE FlexibleInstances #-}

module Lib where

import           Data.Either.Combinators (fromRight')
import           Data.Aeson.Types (typeMismatch)
import qualified Data.Map.Strict as SM
import qualified Data.HashMap.Strict as SHM
import           Data.Text
import           Data.Yaml

data Stack = Stack {
    _name :: Text
  , _template :: Text
  , _parameters :: SHM.HashMap Text (SHM.HashMap Text Text)
} deriving (Show, Eq)

newtype Stacks = Stacks { _stacks :: SHM.HashMap Text Stack }
  deriving (Show, Eq)

instance FromJSON [Stack] where
  parseJSON (Object m) = traverse parseStack $ SHM.toList m
    where parseStack (name, Object v) =
            Stack name <$> v .: "template"
                       <*> v .: "parameters"

  parseJSON invalid = typeMismatch "Stack" invalid

-- instance FromJSON Stacks where
--   parseJSON (Object m) = Stacks <$> traverse parseJSON m


load :: FilePath -> IO [Stack]
load path = do
  result <- decodeFileEither path
  return $ case result of
    Right r -> r
    Left err -> error $ show err
