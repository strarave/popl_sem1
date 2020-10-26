#lang racket

;; the stored function
(define stored #f)

;; function to yield the execution to a saved block
(define (yield)
    (call/cc(
        lambda(cc)
            (stored)
            (cc)
    )))

;; test function
(define (yield-test)
    (displayln "prima")
    (yield)
    (displayln "dopo"))

;; main
(set! stored (lambda() (displayln "stored")))
(yield-test)