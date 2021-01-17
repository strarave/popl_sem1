#lang racket

;; syntax example for a named let
;; simplest loop of all

;; normal LET
(let (
    (value 100)
    (function (lambda (x) (+ x 1)))
    )
    ;; here's the NAMED let that does the loop
    (let label (
        (counter 0)
        )
        (displayln value)
        (set! value (function value))
        (when (< counter 10) 
            ;; invocation of the named label
            ;; the parameter passed are the same ones
            ;; defined in the let lists of attributes
            ;; in this case, only "counter"
            (label (function counter))
        )
    )    
)