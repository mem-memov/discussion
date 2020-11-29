module Interpreter.Merging.Answer where

import Language

replyWith :: Question -> Answer -> Answer
replyWith 
    question@(Question (questiondAnswer, questionString, answersToQuestion))
    (Answer (Nothing, answerString, questionsToAnswer))
    =
    Answer (Just question, answerString, questionsToAnswer)