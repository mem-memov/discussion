module Language where

data Reply = Question Discussion String [Discussion] | Answer Discussion String [Discussion]

class Language interpreter where
    answer :: String -> interpreter Discussion
    question :: String -> interpreter Discussion
    reply :: interpreter Reply -> interpreter Reply -> interpreter Reply