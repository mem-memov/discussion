module Interpreter.Merging.Answer where

import Language

replyWith :: Question -> Answer -> Answer
replyWith 
    (Question (questiondAnswer, questionString, questionAnswers))
    (Answer (Nothing, answerString, questionsToAnswer))
    = let
        answer = Answer (Nothing, answerString, questionsToAnswer)
        question = Question (questiondAnswer, questionString, questionAnswers)
    
    Answer (Just question, answerString, questionsToAnswer)