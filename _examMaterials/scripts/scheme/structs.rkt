#lang racket

;; structs, much like C structs. Mutable fields must be marked; if not
;; they're immutable
(struct airplane(
  name
  (altitude #:mutable)
  (departure #:mutable)
  (arrival #:mutable)
))

;; inheritance: 
(struct idroplane airplane(
  (on-water #:mutable)
)) ;; NOT LIKE OBJECT ORIENTED INHERITANCE

(define (airplane-takeoff plane)
  (let up ((m 0))
    (when (< m 20)
      (set-airplane-altitude! plane (+ (airplane-altitude plane) 1)) ;; use of a pregenerated setter
      (display "current altitude: ") (displayln (airplane-altitude plane)) 
      (up (+ m 1)))))

;; main code
(define boeing747 (airplane "B747" 0 "" "")) ;; list of fields to fill
(displayln (airplane-name boeing747)) ;; standard way to access a structure field: "structName"-"fieldName"
(airplane-takeoff boeing747)
(display "stable altitude: ")
(displayln (airplane-altitude boeing747))