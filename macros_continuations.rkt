#lang racket
(define-syntax while
  (syntax-rules ()
    ((_ condition body ...)
     (let loop ()
       (when condition
         (begin
           body
           ...
           (loop)))))))

(define-syntax =
  (syntax-rules ()
    ((_ var val body ...)
     (let ((var val))
       (begin
         body
         ...)))))



;(let ((x 1))
;  (while (< x 10) (display x) (set! x (+ x 1))))

;(+ 3
;   (call/cc(
;    lambda(env)
;       (for-each (lambda (index) (when (negative? index) (env index)))'(1 2 3 -3))
;       10
;   ))
;)

