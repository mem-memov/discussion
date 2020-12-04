module Interpreter.Merging where

import Language
-- import qualified Interpreter.Merging.Question as MergingQuestion
-- import qualified Interpreter.Merging.Answer as MergingAnswer

newtype Interpreter a = Interpreter a

interpret :: Interpreter a -> a
interpret (Interpreter a) = a

instance Language Interpreter where
    question 
        words 
        = Interpreter
            (Question
                (QuestionedAnswer Nothing)
                (QuestionWords words)
                (AnswerToQuestion Nothing)
            )
    answer 
        words 
        = Interpreter 
            (Answer 
                (AnsweredQuestion Nothing)
                (AnswerWords words)
                (AnswerReferences [])
                (QuestionsToAnswer [])
            )
    ask 
        (Interpreter
            answe@(Answer 
                (AnsweredQuestion answeredQuestion)
                (AnswerWords answerWords)
                (AnswerReferences answerReferences)
                (QuestionsToAnswer questionsToAnswer)
            )
        ) 
        (Interpreter 
            question@(Question
                (QuestionedAnswer questionedAnswer)
                (QuestionWords questionWords)
                (AnswerToQuestion answerToQuestion)
            )
        ) 
        = Interpreter question
    reply (Interpreter question) (Interpreter answer) = Interpreter answer
