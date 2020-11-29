module Interpreter.Merging.Answer where

import Language

replyWith :: Question -> Answer -> Answer
replyWith 
    (Question (Nothing, content, []))
    answer@(_)
    = answer
