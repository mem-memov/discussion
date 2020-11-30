module Interpreter.Merging where

import Language
import qualified Interpreter.Merging.Question as MergingQuestion
import qualified Interpreter.Merging.Answer as MergingAnswer

newtype Interpreter a = Interpreter a

interpret :: Interpreter a -> a
interpret (Interpreter a) = a

instance Language Interpreter where
    answer content = Interpreter (Answer Nothing content [])
    question content = Interpreter (Question Nothing content [])
    reply (Interpreter answer@(Answer _ _ _)) (Interpreter question@(Question _ _ _)) = Interpreter (MergingQuestion.reply answer question)
    reply (Interpreter question@(Question _ _ _)) (Interpreter answer@(Answer _ _ _)) = Interpreter (MergingAnswer.reply question answer)
