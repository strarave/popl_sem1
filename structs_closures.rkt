#lang racket

(struct airplane(
  name
  (altitude #:mutable)
  (departure #:mutable)
  (arrival #:mutable)
))

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

(define (airplane-takeoff plane)
  (let up ((m 0))
    (when (< m 20)
      (set-airplane-altitude! plane (+ (airplane-altitude plane) 1))
      (display "current altitude: ") (displayln (airplane-altitude plane)) 
      (up (+ m 1)))))


;; MAIN
;;; (let ((x 1)
;;;       (vect (vector 1 2 3 4)))
;;;   (no-side-effects vect)
;;;   (mutate-values x vect)
;;;   (display x) (newline)
;;;   (display vect) (newline))

(define boeing747 (airplane "B747" 0 "" ""))
(displayln (airplane-name boeing747))
(airplane-takeoff boeing747)
(display "stable altitude: ")
(displayln (airplane-altitude boeing747))