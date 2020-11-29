module Language where

data Question = Question (Maybe Answer, String, [Answer]) deriving Show
data Answer = Answer (Maybe Question, String, [Question]) deriving Show

class Language interpreter where
    answer :: String -> interpreter Answer
    question :: String -> interpreter Question
    ask :: interpreter Answer -> interpreter Question -> interpreter Question
    reply :: interpreter Question -> interpreter Answer -> interpreter Answer