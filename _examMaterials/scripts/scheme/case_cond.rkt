#lang racket

;; easy case and cond syntax
(let (
    (x 0)
    (y 10)
    (lst '(1 2 3 4 5 6))
    )

    ;; case -> like a switch statement
    (case (car lst)
        [(1) (displayln "one")]
        [(2) (displayln "two")]
        [(3) (displayln "three")]
        [(4) (displayln "four")]
        [(5) (displayln "five")]
        [(6) (displayln "six")]
        [else (displayln "such")]
    )

    ;; cond -> multiple condition, no fixed variable to consider
    (cond
        [(> (length lst) 0) (displayln "suchhh")] ;; the first true condition is the only evaluated  
        [(= x 0) (displayln "x major")]
        [(> y 0) (displayln "y major")]
        [else (displayln "else branch")]
    )
)