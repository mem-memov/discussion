module Language where

data Question = 
    NoQuestion
    | CorrectQuestion 
        QuestionedAnswer 
        PreviousQuestion 
        String 
        AnswersToQuestion
    | IncorrectQuestion String
    deriving (Show)
newtype PreviousQuestion = 
    PreviousQuestion Question 
    deriving (Show)
newtype QuestionedAnswer = 
    QuestionedAnswer Answer
    deriving (Show)
newtype AnswersToQuestion = 
    AnswersToQuestion [Answer] 
    deriving (Show)

data Answer = 
    NoAnswer
    | CorrectAnswer 
        AnsweredQuestion 
        PreviousAnswer 
        String 
        QuestionsToAnswer
    | IncorrectAnswer String
    deriving (Show)
newtype AnsweredQuestion = 
    AnsweredQuestion Question
    deriving (Show)
newtype PreviousAnswer = 
    PreviousAnswer Answer 
    deriving (Show)
newtype QuestionsToAnswer = 
    QuestionsToAnswer [Question] 
    deriving (Show)


class Language interpreter where
    noAnswer :: interpreter Answer
    noQuestion :: interpreter Question
    newAnswer :: String -> interpreter Answer
    newQuestion :: String -> interpreter Question
    ask :: interpreter Answer -> interpreter Question -> interpreter Question
    reply :: interpreter Question -> interpreter Answer -> interpreter Answer