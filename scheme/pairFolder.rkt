#lang racket

;; list reverse
(define (tsil l)
    (if (= (length l) 1)
        l
        (append (tsil (cdr l)) (list (car l)))
    ))

(define (pairFolder . args)
    (foldl list '() args))

;; solution (porcozio)
(define (f . L)
    (foldl (lambda (x y)
        (list x y))
        (foldl cons '() L)
        L))