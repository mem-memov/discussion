module Discussion where

data Problem = 
    NoProblem
    | Problem
        IncompleteSolution
        QuestionWords
        ResolvingSolution
newtype QuestionWords = QuestionWords String
newtype IncompleteSolution = IncompleteSolution Solution
newtype ResolvingSolution = ResolvingSolution Solution

data Question = Question QuestionWords

data Solution = 
    NoSolution
    | Solution 
        SolvedProblem
        AnswerWords
        SolutionReferences
        ProblemsOfSolution
newtype AnswerWords = AnswerWords String
newtype SolvedProblem = SolvedProblem Problem
newtype SolutionReferences = SolutionReferences [Reference]
newtype ProblemsOfSolution = ProblemsOfSolution [Problem]

data Answer = 
    Answer 
        AnswerWords 
        AnswerPaths
newtype AnswerPaths = AnswerPaths [AnswerPath]
newtype AnswerPath = AnswerPath [String]

data Reference = ReferencedSolution Solution | ReferencedProblem Problem

createQuestion :: String -> Question
createQuestion
    words
    = Question
        (QuestionWords words)

createProblem :: String -> Problem
createProblem 
    words 
    = Problem
        (IncompleteSolution NoSolution)
        (QuestionWords words)
        (ResolvingSolution NoSolution)

createAnswer :: String -> [[String]] -> Answer
createAnswer
    words
    paths
    = Answer
        (AnswerWords words)
        (AnswerPaths (map AnswerPath paths))

createSolution :: String -> Solution
createSolution
    words
    = Solution
        (SolvedProblem NoProblem)
        (AnswerWords words)
        (SolutionReferences [])
        (ProblemsOfSolution [])

askQuestion :: Solution -> Question -> Problem
askQuestion
    (Solution 
        solvedProblem
        answerWords
        solutionReferences
        (ProblemsOfSolution problemsOfSolution)
    )
    (Question questionWords)
    = let
        incompleteSolution
            = Solution 
                solvedProblem
                answerWords
                solutionReferences
                (ProblemsOfSolution (problemOfSolution : problemsOfSolution))
        problemOfSolution 
            = Problem 
                (IncompleteSolution incompleteSolution)
                questionWords
                (ResolvingSolution NoSolution)
    in problemOfSolution

replyWithAnswer :: Problem -> Answer -> Solution
replyWithAnswer
    (Problem
        incompleteSolution
        questionWords
        (ResolvingSolution NoSolution)
    )
    (Answer
        answerWords 
        answerPaths
    )
    = let
        solvedProblem 
            = Problem
                incompleteSolution
                questionWords
                (ResolvingSolution resolvingSolution)
        resolvingSolution 
            = Solution
                (SolvedProblem solvedProblem)
                answerWords
                (SolutionReferences [])
                (ProblemsOfSolution [])
    in resolvingSolution
