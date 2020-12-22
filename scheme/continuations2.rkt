#lang racket
(define (extraction)
    (displayln "EXTRACTED"))

(define (extract proc)
    (displayln "inside box")
    (call/cc(
        lambda(cc)
            (proc cc)
    ))
    (displayln "outside box")
)

(define (freak-procedure cont)
    (displayln "before cont")
    (cont (extraction))
    (displayln "after cont"))

(define (cont-list-check lst)
    (call/cc(
        lambda(break)
            (let loop ((x 0))
                (if (> (car lst) 5)
                    (displayln (car lst))
                    (break))
                (set! lst (cdr lst))
                (loop x)
    ))))