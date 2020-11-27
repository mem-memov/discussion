module Interpreter.Merging.Question where

import Language

ask :: Answer -> Question -> Question
ask NoAnswer correctQuestion@(CorrectQuestion _ _ _ _) = correctQuestion
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

