module Interpreter.Merging.Question where

import Language

ask :: Answer -> Question -> Question
ask
    (Answer (Nothing, content, []))
    question@(_)
    = question


