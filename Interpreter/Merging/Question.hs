module Interpreter.Merging.Question where

import Language

ask :: Answer -> Question -> Question
ask
    answer@(_)
    (Question (Nothing, questionString, answersToQuestion))
    = Question (Just answer, questionString, answersToQuestion)


