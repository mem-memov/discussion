module Language where

newtype Question a = Question a
newtype Answer a = Answer a

class Language interpreter where
    answer :: a -> interpreter (Answer a)
    question :: a -> interpreter (Question a)
    ask :: interpreter (Answer a) -> interpreter (Question a) -> interpreter (Question a)
    reply :: interpreter (Question a) -> interpreter (Answer a) -> interpreter (Answer a)