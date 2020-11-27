module Interpreter.Merging.Question where

import Language

ask :: Answer -> Question -> Question
ask NoAnswer correctQuestion@(CorrectQuestion _ _ _ _) = correctQuestion
ask
    questionedAnswer@(CorrectAnswer 
        (AnsweredQuestions answeredQuestions) 
        (PreviousAnswer previousAnswer) 
        answerString 
        (QuestionsToAnswer questionsToAnswer)
    )
    question@(CorrectQuestion 
        (QuestionedAnswers questionedAnswers) 
        (PreviousQuestion previousQuestion) 
        questionString 
        (AnswersToQuestion answersToQuestion)
    )
    = CorrectQuestion
        (QuestionedAnswers (questionedAnswer : questionedAnswers)) 
        (PreviousQuestion
            (case questionsToAnswer of 
                [] -> NoQuestion
                previousQuestion : _ -> previousQuestion
            )
        ) 
        questionString 
        (AnswersToQuestion answersToQuestion)

