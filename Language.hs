module Language where

newtype Question = Question (Either IncorrectQuestion CorrectQuestion) deriving (Show)
newtype IncorrectQuestion = IncorrectQuestion String deriving (Show)
newtype CorrectQuestion = CorrectQuestion (Maybe AnswerQuestion) deriving (Show)
data AnswerQuestion = AnswerQuestion QuestionedAnswer PreviousQuestion String AnswersToQuestion deriving (Show)
newtype PreviousQuestion = PreviousQuestion (Maybe Question) deriving (Show)
newtype QuestionedAnswer = QuestionedAnswer (Maybe Answer) deriving (Show)
newtype QuestionsToAnswer = QuestionsToAnswer [Question] deriving (Show)

newtype Answer = Answer (Either IncorrectAnswer CorrectAnswer) deriving (Show)
newtype IncorrectAnswer = IncorrectAnswer String deriving (Show)
newtype CorrectAnswer = CorrectAnswer (Maybe QuestionAnswer) deriving (Show)
data QuestionAnswer = QuestionAnswer AnsweredQuestion PreviousAnswer String QuestionsToAnswer deriving (Show)
newtype AnsweredQuestion = AnsweredQuestion (Maybe Question) deriving (Show)
newtype PreviousAnswer = PreviousAnswer (Maybe Answer) deriving (Show)
newtype AnswersToQuestion = AnswersToQuestion [Answer] deriving (Show)

class Discussion interpreter where
    silentAnswer :: interpreter Answer
    silentQuestion :: interpreter Question
    answer :: String -> interpreter Answer
    question :: String -> interpreter Question
    ask :: interpreter Answer -> interpreter Question -> interpreter Question
    reply :: interpreter Question -> interpreter Answer -> interpreter Answer