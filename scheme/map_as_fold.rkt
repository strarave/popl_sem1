#lang racket

(define (mapfold func lst)
    (let loop (
            (c 0)
            (final '())
            )
        (cons final (func (list-ref c lst)))
        (unless (>= c (lenght lst))  (loop (+ c 1) (final)))
    )
    (foldr cons '() lst)
)

(define (filterfold func lst)
    (define (condcons func l1 l2)
        (if (f l2)
            (cons l1 l2)
            l1
        )
    )
    (foldr condcond '() lst)
)

(define (f x)
    (+ x 1)
)

(mapfold f '(1 2 3 4 5))