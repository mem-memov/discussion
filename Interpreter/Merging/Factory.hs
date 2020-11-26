module Interpreter.Merging.Factory where

import Language

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