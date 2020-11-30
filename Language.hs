module Language where

data Reply = Question (Maybe Reply) String [Reply] | Answer (Maybe Reply) String [Reply]

class Language interpreter where
    answer :: String -> interpreter Reply
    question :: String -> interpreter Reply
    reply :: interpreter Reply -> interpreter Reply -> interpreter Reply