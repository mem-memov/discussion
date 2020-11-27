module Interpreter.Merging where

import Language

newtype Interpreter a = Interpreter a

evaluate :: Interpreter a -> a
evaluate (Interpreter a) = a

instance Language Interpreter where

    noAnswer = Interpreter (NoAnswer)
    noQuestion = Interpreter (NoQuestion)
        
    answer "" = Interpreter (IncorrectAnswer "No answer text provided.")
    answer string = Interpreter 
        (CorrectAnswer 
            (AnsweredQuestion NoQuestion) 
            (PreviousAnswer NoAnswer) 
            string 
            (QuestionsToAnswer [])
        )

    question "" = Interpreter (IncorrectQuestion "No question text provided.")
    question string = Interpreter 
        (CorrectQuestion 
            (QuestionedAnswer NoAnswer) 
            (PreviousQuestion NoQuestion) 
            string 
            (AnswersToQuestion [])
        )

    ask (Interpreter answer) (Interpreter question) = Interpreter (askQuestion answer question)
    reply (Interpreter question) (Interpreter answer) = Interpreter (replyWithAnswer question answer)

askQuestion :: Answer -> Question -> Question
askQuestion NoAnswer correctQuestion@(CorrectQuestion _ _ _ _) = correctQuestion
-- askQuestion
--     questionedAnswer@(CorrectAnswer 
--         (AnsweredQuestion answeredQuestion) 
--         (PreviousAnswer previousAnswer) 
--         answerString 
--         (QuestionsToAnswer questionsToAnswer)
--     )
--     question'@(CorrectQuestion 
--         (QuestionedAnswer NoAnswer) 
--         (PreviousQuestion previousQuestion) 
--         questionString 
--         (AnswersToQuestion answersToQuestion)
--     )
--     = CorrectQuestion
--         (QuestionedAnswer questionedAnswer) 
--         (PreviousQuestion
--             (case questionsToAnswer of 
--                 [] -> NoQuestion
--                 previousQuestion : _ -> previousQuestion
--             )
--         ) 
--         questionString 
--         (AnswersToQuestion answersToQuestion)

replyWithAnswer :: Question -> Answer -> Answer
replyWithAnswer NoQuestion correctAnswer@(CorrectAnswer _ _ _ _) = correctAnswer
replyWithAnswer 
    answeredQuestion@(CorrectQuestion 
        (QuestionedAnswer questionedAnswer) 
        (PreviousQuestion previousQuestion) 
        questionString 
        (AnswersToQuestion answersToQuestion)
    )
    answer'@(CorrectAnswer 
        (AnsweredQuestion NoQuestion) 
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


-- mergeQuestion :: Answer -> Question -> Question
-- mergeQuestion a q = q