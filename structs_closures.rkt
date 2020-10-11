#lang racket

(define (mutate-values cost array)
  (set! cost 5)
  (vector-set! array 2 "changed")
  (display cost) (newline)
  (display array) (newline))

(define (vector-copy vect)
  (let ((copy (make-vector (vector-length vect))))
    (let loop((index 0))
      (when (< index (vector-length vect))
        (vector-set! copy index (vector-ref vect index))
        (loop (+ index 1)))
    copy)))

(define (no-side-effects array)
  (define x (vector-copy array))
  (vector-set! x 2 "changed")
  (display x) (newline)
  (display array) (newline))

(let ((x 1)
      (vect (vector 1 2 3 4)))
  (no-side-effects vect)
  (mutate-values x vect)
  (display x) (newline)
  (display vect) (newline)
)