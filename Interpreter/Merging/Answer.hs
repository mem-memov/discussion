module Interpreter.Merging.Answer where

import Language

reply :: Reply -> Reply -> Reply
reply 
    (Question questiondAnswer questionString answersToQuestion)
    (Answer Nothing answerString questionsToAnswer)
    = let
        answer = Answer (Just question) answerString questionsToAnswer
        question = Question questiondAnswer questionString (answer : answersToQuestion)
    in answer