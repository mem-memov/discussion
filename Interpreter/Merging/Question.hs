module Interpreter.Merging.Question where

import Language

reply :: Reply -> Reply -> Reply
reply
    answer
    (Question Nothing questionString answersToQuestion)
    = Question (Just answer) questionString answersToQuestion


