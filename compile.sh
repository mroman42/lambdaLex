#!/bin/bash

# LambdaLex script.
# Compiles Lambda calculus files into Haskell files and shows the results.

INPUT=$1
HSOUT=$INPUT.hs
CCOUT=$INPUT.out

# Messages
echo "LambdaLex v0.1 Compiling..."

# Compiling
Lex/lambdalit $INPUT > $HSOUT
ghc $HSOUT -o $CCOUT > /dev/null
./$CCOUT

# Cleaning
#rm $INPUT.{hi,o,hs,out}
