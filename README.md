LambdaLex
=========

## Installation
The complete program can be built using: `make` in the `./Lex` folder.  

The *Glasgow Haskell Compiler* (GHC), and the package `Data.ByteString.UTF8` are required. The package can be installed using Cabal:
``` bash
cabal install utf8-string
```  


## Usage

The script `./compile.sh` parses the input and performs beta reduction on it. An input file contains:
 * The keyword `Defs.`
 * Multiple definitions in the form `name = lambdaexpression`
 * The keyword `Comp.`
 * The target lambda expression.
A lambda expression can be written using `\` as *lambda*.  

The following code is an example of input file:
``` Haskell
Defs.
zero = (\f.(\x.x))
one  = (\f.(\x.f x))
two  = (\f.(\x.f (f x)))
three= (\f.(\x.f (f (f x)))) 
sucr = (\n.(\f.(\x.f ((n f) x))))
plus = (\m.(\n.(\f.(\x.(m f) ((n f) x)))))
mult = (\m.(\n.(\f.m (n f))))
true = (\x.(\y.x))
false= (\x.(\y.y))
andr = (\p.(\q.(p q) p))
orr  = (\p.(\q.(p p) q))
notr = (\p.(\a.(\b.(p b) a)))
Comp.
(orr false) (notr true)
```
