#lang racket

(define (a-function lst sep)
    (foldl 
        (lambda (el next)
            (if (eq? el sep)
                (cons sep next)
                (cons (cons el (car next))(cdr next))
            )
        )
        (list '()) 
        lst
    )
)