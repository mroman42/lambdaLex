import Lambdalit

yaccexp :: Expression
yaccexp = Lambda 'x' (Pair (Variable 'f') (Variable 'x'))

main = putStrLn $ show yaccexp

