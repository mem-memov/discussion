module Discussion where

class Questioning questioningInterpreter where
class Answering answeringInterpreter where

data Question = NoQuestion | Question Words
instance Questioning Question where

data Answer = Answer Words
instance Answering Answer where

data Words = NoWords | Words String

class Discussing discussingInterpreter where
    ask :: 
        (Answering answeringInterpreter
        , Questioning questioningInterpreter)
        => discussingInterpreter answeringInterpreter
        -> discussingInterpreter questioningInterpreter
        -> discussingInterpreter questioningInterpreter
    reply :: 
        (Answering answeringInterpreter
        , Questioning questioningInterpreter)
        => discussingInterpreter questioningInterpreter
        -> discussingInterpreter answeringInterpreter
        -> discussingInterpreter answeringInterpreter

newtype Discussion a = Discussion a

instance Discussing Discussion where
    ask a q = q
    reply q a = a

createQuestion words = Discussion (Question (Words words))
createAnswer words = Discussion (Answer (Words words))
