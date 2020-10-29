#lang racket


(struct promise(
    (val_proc #:mutable)
    (ready? #:mutable)
))

(define-syntax delay (
    syntax-rules()
    ((_ (procedure ...))
        (promise (lambda() (procedure ...)) #f)
)))

(define-syntax force(
    syntax-rules ()
    ((_ prom)
        (cond
            ;; not a promise?
            [(not (promise? prom)) prom]

            ;; value not ready? evaluate it and return it
            [(not (promise-ready? prom)) 
                (set-promise-val_proc! prom ((promise-val_proc prom)))
                (set-promise-ready?! prom #t)
                (promise-val_proc prom)
            ]

            ;; the value is ready
            [else (promise-val_proc prom)]))
))

;; main 
(let ((x (delay (+ 4 5))))
    (displayln x)
    (displayln (force x)))