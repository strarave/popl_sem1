#lang racket
(+ 3
   (call/cc(
    lambda(env)
       (for-each (lambda (index) (when (negative? index) (env index)))'(1 2 3 -3))
       10
   ))
)