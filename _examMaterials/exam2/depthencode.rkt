#lang racket

;;; Write a function 'depth-encode' that takes in input a list possibly containing other lists at multiple nesting levels, 
;;; and returns it as a flat list where each element is paired with its nesting level in the original list.

;;; E.g. (depth-encode '(1 (2 3) 4 (((5) 6 (7)) 8) 9 (((10))))) 
;;; returns
;;; ((0 . 1) (1 . 2) (1 . 3) (0 . 4) (3 . 5) (2 . 6) (3 . 7) (1 . 8) (0 . 9) (3 . 10)

#lang racket

(define (depth-encode lst)
    (define (depth-encode-aux lst level)
        (cond
            [(null? lst) lst]
            [(not (list? lst)) (cons level lst)]
            [(not (list? (car lst))) (list (cons level (car lst)) (depth-encode-aux (cdr lst) level))]
            [else (append (depth-encode-aux (car lst) (+ level 1)) (depth-encode-aux (cdr lst) level))])
            )
    (depth-encode-aux lst 0)
)