#lang racket

;;; (call/cc(
;;;     lambda(break)(
;;;         let loop ((x 0))
;;;         (displayln x)
;;;         (when (> x 10) (break))
;;;         (loop (+ x 1))
;;;     )
;;; ))
;;; (displayln "eccheccazzo")

(define cont-buffer #f)
(define (fill-buffer)
    (let ((x 0))(
        call/cc(
            lambda(env)(
                set! cont-buffer env))
        )
        (set! x (+ x 1))
        (displayln x)
    )
)

(define saved-cont #f) ; place to save k
(define (test-cont)(
    let ((x 0))(
        call/cc( 
            lambda (k)( 
                set! saved-cont k 
            )))
        (set! x (+ x 1))
        (display x)
        (newline )
    )
)