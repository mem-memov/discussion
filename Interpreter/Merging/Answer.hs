module Interpreter.Merging.Answer where

import Language

replyWith :: Question -> Answer -> Answer
replyWith NoQuestion correctAnswer@(CorrectAnswer _ _ _ _) = correctAnswer
replyWith 
    question@(CorrectQuestion 
        (QuestionedAnswer questionedAnswer) 
        (PreviousQuestion previousQuestion) 
        questionString 
        (AnswersToQuestion answersToQuestion)
    )
    answer@(CorrectAnswer 
        (AnsweredQuestion answeredQuestion) 
        (PreviousAnswer previousAnswer) 
        answerString 
        (QuestionsToAnswer questionsToAnswer)
    )
    = CorrectAnswer
        (AnsweredQuestion answeredQuestion)
        (PreviousAnswer 
            (case answersToQuestion of 
                [] -> NoAnswer
                previousAnswer : _ -> previousAnswer
            )
        ) 
        answerString
        (QuestionsToAnswer questionsToAnswer)