module Interpreter.Merging where

import Language
import qualified Interpreter.Merging.Question as MergingQuestion
import qualified Interpreter.Merging.Answer as MergingAnswer

newtype Interpreter a = Interpreter a

interpret :: Interpreter a -> a
interpret (Interpreter a) = a

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

    ask (Interpreter answer) (Interpreter question) = Interpreter 
        (MergingQuestion.ask answer question)
    
    reply (Interpreter question) (Interpreter answer) = Interpreter 
        (MergingAnswer.replyWith question answer)
