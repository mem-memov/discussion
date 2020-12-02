module Interpreter.Merging where

import Language
-- import qualified Interpreter.Merging.Question as MergingQuestion
-- import qualified Interpreter.Merging.Answer as MergingAnswer

newtype Interpreter a = Interpreter a

interpret :: Interpreter a -> a
interpret (Interpreter a) = a

instance Language Interpreter where
    answer content = Interpreter (Answer content)
    question content = Interpreter (Question content)
    ask (Interpreter answer) (Interpreter question) = Interpreter question
    reply (Interpreter question) (Interpreter answer) = Interpreter answer
