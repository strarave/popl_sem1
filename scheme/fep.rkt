#lang racket

(define (fep lst)
    (foldr 
        (lambda (x y) (list x y x))
        lst
        lst)
)