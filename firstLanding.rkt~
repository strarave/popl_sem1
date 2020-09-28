#lang racket

;; simple tail recursive function
(define (fold-range-tail oper num lim)
    (define (fold-range-tail-aux oper num acc)
        (if (<= num lim)
            acc
            (fold-range-tail-aux oper (- num 1) (oper num acc))))
    (fold-range-tail-aux oper (- num 1) num))

;; iterative version
(define (fold-range-it oper num lim)
    (let count ((x (- num 1)) (acc num))
        (if (<= x lim)
        acc
        (count (- x 1) (oper x acc)))))

;; pair-reversing function
(define (riap p)
    (let ((f (car p))
          (s (cdr p)))
     (cons s f)))

;; list-reversing function
(define (tsil l)
  (if (null? l) 
      l
      (append (tsil (cdr l)) (list (car l)))))

;; list-flattening function
;; merge-sorting-lists function
