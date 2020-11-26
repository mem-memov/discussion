module Interpreter.Merging where

import Language
import qualified Interpreter.Merging.Factory as Factory

newtype Interpreter a = Interpreter a

evaluate :: Interpreter a -> a
evaluate (Interpreter a) = a

instance Language Interpreter where

    silentAnswer = Interpreter (Factory.createSilentAnswer)
    silentQuestion = Interpreter (Factory.createSilentQuestion)
        
    answer "" = Interpreter (Factory.complainAboutNoTextInAnswer)
    answer string = Interpreter (Factory.createAnswer string)

    question "" = Interpreter (Factory.complainAboutNoTextInQuestion)
    question string = Interpreter (Factory.createQuestion string)

    ask (Interpreter answer) (Interpreter question) = Interpreter (askQuestion answer question)
    reply (Interpreter question) (Interpreter answer) = Interpreter (replyWithAnswer question answer)

askQuestion :: Answer -> Question -> Question
askQuestion a q = q

replyWithAnswer :: Question -> Answer -> Answer
replyWithAnswer q a = a

-- mergeQuestion :: Answer -> Question -> Question
-- mergeQuestion a q = q