import Prelude hiding (putStr)
import Data.ByteString.Char8 (putStr)
import Data.ByteString.UTF8 (fromString)
import Data.Char

{- Lambda-Calculus expressions -}
{- Definition of a lambda calculus expression -}
--data Expression = Variable Char
--                | Lambda   Char Expression
--                | Pair     Expression Expression
--                deriving (Eq)

{- Showing lambda calculus expressions -}
--instance Show Expression where
--  show (Variable x) = [x]
--  show (Lambda x e) = "(λ" ++ [x] ++ "." ++ show e ++ ")"
--  show (Pair e1 e2) = "(" ++ show e1 ++ " " ++ show e2 ++ ")"



{- Substitution -}
--subsVar :: Char -> Char -> Expression -> Expression
--subsVar x y (Variable z) = if (z == x) then Variable y else Variable x
 


{- De Brunijn expressions -}
data ExpBrunjin = Index  Int
                | Pair   ExpBrunijn ExpBrunijn
                | Lambda ExpBrunijn

showVars :: Char -> ExpBrunijn -> String
showVars a (Lambda e) = "(λ" ++ [a] ++ "." ++ showVars (succ a) e ++ ")"
showVars a (Pair e f) = "(" ++ (showVars a e) ++ " " ++ (showVars a f) ++ ")"
showVars a (Index n)  = [(chr ((ord a) - n))]

instance Show ExpBrunjin where
  show = showVars 'a'


{- Beta reduction -}
betaRed :: ExpBrunijn -> ExpBrunijn
betaRed (Lambda a) b = 
