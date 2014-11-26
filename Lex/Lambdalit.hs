module Lex.Lambdalit where

import Prelude hiding (putStr)
import Data.ByteString.Char8 (putStr)
import Data.ByteString.UTF8 (fromString)
import Data.Char

{- Lambda-Calculus expressions -}
{- Definition of a lambda calculus expression -}
data Expression = Variable Char
                | Lambda   Char Expression
                | Pair     Expression Expression
                deriving (Eq)

{- Showing lambda calculus expressions -}
instance Show Expression where
  show (Variable x) = [x]
  show (Lambda x e) = "(λ" ++ [x] ++ "." ++ show e ++ ")"
  show (Pair e1 e2) = "(" ++ show e1 ++ " " ++ show e2 ++ ")"


{- Variable Substitution -}
subsVar :: Char -> Expression -> Expression -> Expression
subsVar x y (Variable z) = if (z == x) then y else (Variable z)
subsVar x y (Lambda z e) = if (z == x) then (Lambda z e) else (Lambda z (subsVar x y e))
subsVar x y (Pair a b)   = (Pair (subsVar x y a) (subsVar x y b))


{- Beta reduction -}
betaRedU :: Expression -> Expression
betaRedU (Pair (Lambda v e) d) = betaRed (subsVar v d e)
betaRedU (Pair e f) = Pair (betaRed e) (betaRed f)
betaRedU (Lambda x e) = Lambda x (betaRed e)
betaRedU e = e   

betaRed :: Expression -> Expression
betaRed x
  | x == y = x
  | otherwise = betaRed y
  where y = betaRedU x

--------------------------------------------------------------------------------------
{- De Brunijn expressions -}
data ExpBrunijn = Index   Int
                | PairB   ExpBrunijn ExpBrunijn
                | LambdaB ExpBrunijn

showVars :: Char -> ExpBrunijn -> String
showVars a (LambdaB e) = "(λ" ++ [a] ++ "." ++ showVars (succ a) e ++ ")"
showVars a (PairB e f) = "(" ++ (showVars a e) ++ " " ++ (showVars a f) ++ ")"
showVars a (Index n)   = [(chr ((ord a) - n))]

instance Show ExpBrunijn where
  show = showVars 'a'


{- Beta reduction -}
--betaRed :: ExpBrunijn -> ExpBrunijn
--betaRed (Lambda a) b = 


---------------------------------------------------------------------------------------
procExp :: Expression -> IO() 
procExp exp = do
  putStrLn $ "Input: " ++ (show exp)
  putStrLn $ "BRed:  " ++ (show $ betaRed exp)
