module Language where

data Reply = ReplyAnswer Answer | ReplyQuestion Question

data Question = 
    Question
        QuestionedAnswer
        QuestionWords
        AnswerToQuestion

newtype QuestionedAnswer = QuestionedAnswer (Maybe Answer)
newtype QuestionWords = QuestionWords String
newtype AnswerToQuestion = AnswerToQuestion (Maybe Answer)

data Answer = 
    Answer 
        AnsweredQuestion 
        AnswerWords 
        AnswerReferences
        QuestionsToAnswer

newtype AnsweredQuestion = AnsweredQuestion (Maybe Question)
newtype AnswerWords = AnswerWords String
newtype AnswerReferences = AnswerReferences ([Reply])
newtype QuestionsToAnswer = QuestionsToAnswer ([Question])

class Language interpreter where
    question :: String -> interpreter Question
    answer :: String -> interpreter Answer
    ask :: interpreter Answer -> interpreter Question -> interpreter Question
    reply :: interpreter Question -> interpreter Answer -> interpreter Answer