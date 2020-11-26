module MergingInterpreter where

import Discussion

newtype MergingInterpreter a = MergingInterpreter a

evaluate :: MergingInterpreter a -> a
evaluate (MergingInterpreter a) = a

instance Discussion MergingInterpreter where

    silentAnswer = MergingInterpreter (createSilentAnswer)
    silentQuestion = MergingInterpreter (createSilentQuestion)
        
    answer "" = MergingInterpreter (complainAboutNoTextInAnswer)
    answer string = MergingInterpreter (createAnswer string)

    question "" = MergingInterpreter (complainAboutNoTextInQuestion)
    question string = MergingInterpreter (createQuestion string)

    ask (MergingInterpreter answer) (MergingInterpreter question) = MergingInterpreter (askQuestion answer question)
    reply (MergingInterpreter question) (MergingInterpreter answer) = MergingInterpreter (replyWithAnswer question answer)


createSilentAnswer :: Answer
createSilentAnswer = 
    Answer
        (Right 
            (CorrectAnswer
                Nothing
            )
        )
        
createSilentQuestion :: Question
createSilentQuestion = 
    Question
        (Right 
            (CorrectQuestion
                Nothing
            )
        )
    
complainAboutNoTextInAnswer :: Answer
complainAboutNoTextInAnswer =
    Answer
        (Left
            (IncorrectAnswer
                "No answer text provided."
            )
        )

complainAboutNoTextInQuestion :: Question
complainAboutNoTextInQuestion =
    Question
        (Left
            (IncorrectQuestion
                "No question text provided."
            )
        )

createAnswer :: String -> Answer
createAnswer string =
    Answer
        (Right 
            (CorrectAnswer
                (Just
                    (QuestionAnswer 
                        (AnsweredQuestion Nothing) 
                        (PreviousAnswer Nothing) 
                        string 
                        (QuestionsToAnswer [])
                    )
                )
            )
        )
        
createQuestion :: String -> Question
createQuestion string =
    Question
        (Right 
            (CorrectQuestion
                (Just
                    (AnswerQuestion 
                        (QuestionedAnswer Nothing) 
                        (PreviousQuestion Nothing) 
                        string 
                        (AnswersToQuestion [])
                    )
                )
            )
        )

askQuestion :: Answer -> Question -> Question
askQuestion a q = q

replyWithAnswer :: Question -> Answer -> Answer
replyWithAnswer q a = a

-- mergeQuestion :: Answer -> Question -> Question
-- mergeQuestion a q = q