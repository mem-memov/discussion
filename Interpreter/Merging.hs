module Interpreter.Merging.Interpreter where

import Language
import qualified Interpreter.Merging.Factory as Factory

newtype MergingInterpreter a = MergingInterpreter a

evaluate :: MergingInterpreter a -> a
evaluate (MergingInterpreter a) = a

instance Discussion MergingInterpreter where

    silentAnswer = MergingInterpreter (Factory.createSilentAnswer)
    silentQuestion = MergingInterpreter (Factory.createSilentQuestion)
        
    answer "" = MergingInterpreter (Factory.complainAboutNoTextInAnswer)
    answer string = MergingInterpreter (Factory.createAnswer string)

    question "" = MergingInterpreter (Factory.complainAboutNoTextInQuestion)
    question string = MergingInterpreter (Factory.createQuestion string)

    ask (MergingInterpreter answer) (MergingInterpreter question) = MergingInterpreter (askQuestion answer question)
    reply (MergingInterpreter question) (MergingInterpreter answer) = MergingInterpreter (replyWithAnswer question answer)

askQuestion :: Answer -> Question -> Question
askQuestion a q = q

replyWithAnswer :: Question -> Answer -> Answer
replyWithAnswer q a = a

-- mergeQuestion :: Answer -> Question -> Question
-- mergeQuestion a q = q