newtype PreviousAnswer = PreviousAnswer (Maybe Answer) deriving (Show)
newtype PreviousQuestion = PreviousQuestion (Maybe Question) deriving (Show)
newtype QuestionedAnswer = QuestionedAnswer (Maybe Answer) deriving (Show)
newtype AnsweredQuestion = AnsweredQuestion (Maybe Question) deriving (Show)
newtype AnswersToQuestion = AnswersToQuestion [Answer] deriving (Show)
newtype QuestionsToAnswer = QuestionsToAnswer [Question] deriving (Show)
data Answer = Answer AnsweredQuestion PreviousAnswer String QuestionsToAnswer deriving (Show)
data Question = Question QuestionedAnswer PreviousQuestion String AnswersToQuestion deriving (Show)

class Knowledge interpreter where
    answer :: String -> interpreter Answer
    question :: String -> interpreter Question
    ask :: interpreter QuestionedAnswer -> interpreter Question -> interpreter Question
    -- reply :: interpreter AnsweredQuestion -> interpreter Answer -> interpreter Answer

newtype Sense a = Sense {unSense :: a}

-- type constraint needed?
evaluate :: Sense a -> a
evaluate = unSense

instance Knowledge Sense where
    answer string = 
        Sense (
            Answer 
                (AnsweredQuestion Nothing) 
                (PreviousAnswer Nothing) 
                string 
                (QuestionsToAnswer [])
        )
    question string = 
        Sense (
            Question 
                (QuestionedAnswer Nothing)
                (PreviousQuestion Nothing)
                string 
                (AnswersToQuestion [])
        )
    ask
        Sense {unSense = (QuestionedAnswer Nothing)}
        senseQuestion
        = senseQuestion
    ask 
        Sense {unSense = (QuestionedAnswer (Just answer))} 
        Sense {unSense = question} 
        = Sense (mergeQuestion answer question)

mergeQuestion :: Answer -> Question -> Question
mergeQuestion a q = q