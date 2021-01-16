#lang racket

(define saved '())
(define (poprun-k)
    (if (null? saved)
        #f
        (let ((x (car saved)))
            (set! saved (cdr saved))
            (x)
        )
    )
)
(define (push k)
    (set! saved (append saved (list k)))
)

(define (f1 x)
    (call/cc(
        lambda(k)
        (push k)
    ))
    (set! x (+ 1 x))
    (display "f1: ")(displayln x)
)

(define (f2 y)
    (call/cc(
        lambda(k)
        (push k)
    ))
    (set! y (* 2 y))
    (display "f2: ")(displayln y)
)

(define (run)
    (f1 0) (f2 2) (poprun-k)
)