module Interpreter.Merging.Answer where

import Language

replyWith :: Question -> Answer -> Answer
replyWith NoQuestion correctAnswer@(CorrectAnswer _ _ _ _) = correctAnswer
replyWith 
    answeredQuestion@(CorrectQuestion 
        (QuestionedAnswers questionedAnswers) 
        (PreviousQuestion previousQuestion) 
        questionString 
        (AnswersToQuestion answersToQuestion)
    )
    answer'@(CorrectAnswer 
        (AnsweredQuestions answeredQuestions) 
        (PreviousAnswer previousAnswer) 
        answerString 
        (QuestionsToAnswer questionsToAnswer)
    )
    = CorrectAnswer
        (AnsweredQuestions answeredQuestions)
        (PreviousAnswer 
            (case answersToQuestion of 
                [] -> NoAnswer
                previousAnswer : _ -> previousAnswer
            )
        ) 
        answerString
        (QuestionsToAnswer questionsToAnswer)