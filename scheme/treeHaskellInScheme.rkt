#lang racket
(define (Leaf a)
    (define (print)
        (display "Leaf ")
        (display a)
        (display " ")
    )
    (define (map f)
        (Leaf (f a))
    )
    (lambda (message . args)
        (apply
            (case message
                ((print) print)
                ((map) map)
                (else (displayln "error"))
            )
            args
        )
    )
)

(define (Branch right a left)
    (define (print)
        (display "Branch ")
        (right 'print)
        (display a)
        (left 'print)
        (display " ")
    )
    (define (map f)
        (Branch (right 'map f) (f a) (left 'map f))
    )
    (lambda (method . args)
        (apply
            (case method
                ((map) map)
                ((print) print)
                (else (displayln "error"))
            )
            args 
        )
    )
)