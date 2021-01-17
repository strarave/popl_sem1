#lang racket

(define (ap state equality)
    (let ((local state))
        (lambda (f)
            (let
                ((new (f local))
                (flag (equality new local)))
            (when flag
                (set! local new))
            (cons flag new)))))

(define (g f v equality)
    (let ((alpha (ap v equality)))
        (let beta ((v (alpha f)))
            (call/cc
                (lambda (done)
                    (when (car v)
                        (done (cdr v)))
                    (beta (alpha f)))))))
