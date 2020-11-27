module Language where

data Question = 
    NoQuestion
    | CorrectQuestion 
        QuestionedAnswers 
        PreviousQuestion 
        String 
        AnswersToQuestion
    | IncorrectQuestion String
    deriving (Show)
newtype PreviousQuestion = 
    PreviousQuestion Question 
    deriving (Show)
newtype QuestionedAnswers = 
    QuestionedAnswers [Answer]
    deriving (Show)
newtype AnswersToQuestion = 
    AnswersToQuestion [Answer] 
    deriving (Show)

data Answer = 
    NoAnswer
    | CorrectAnswer 
        AnsweredQuestions 
        PreviousAnswer 
        String 
        QuestionsToAnswer
    | IncorrectAnswer String
    deriving (Show)
newtype AnsweredQuestions = 
    AnsweredQuestions [Question] 
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