#lang racket

(define (mutate-values cost array)
  (set! cost 5)
  (vector-set! array 2 "changed")
  (display cost) (newline)
  (display array) (newline))

(define (no-side-effects array)
  (let ((x array))
  (vector-set! x 2 "changed")
  (display x) (newline)
  (display array) (newline)))

(let ((x 1)
      (vect (vector 1 2 3 4)))
  (no-side-effects vect)
  (mutate-values x vect)
  (display x) (newline)
  (display vect) (newline))