#lang racket

;; useless closure definition
(define (clos op) (
    let((x 1) (y 0))
        (lambda()
            (set! x (op x y))
            (set! y (op x y))
            x
        )
))


;; main
(let ((sum (clos +)) (molt (clos *)))
    (display (sum)) (newline)
    (display (sum)) (newline)
    (display (sum)) (newline)
    (display (sum)) (newline)
    (display (sum)) (newline)
    (display (molt)) (newline)
    (display (molt)) (newline)
    (display (molt)) (newline)
    (display (molt)) (newline)
    (display (molt)) (newline)
)