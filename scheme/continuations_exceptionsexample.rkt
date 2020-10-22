#lang racket

;; try catch structure
(define-syntax try
    (syntax-rules (catch) ;; the construct must know the exception to be catched and the handler
        ((_ exp ... (catch what hand ...))
        (call/cc (lambda (exit)
            (push-handler (
                lambda(x)
                    (if (equal? x what)
                        (exit (begin hand ...))
                        (throw x)
                    )
            ))
            (let((res (begin exp ...)))
                (pop-handler)
                res))))))

;; throw procedure
(define (throw x)
    (if (pair? *handlers*)
        ((pop-handler) x)
        (apply error x)))

;; handlers stack
(define *handlers* (list))
(define (push-handler proc)
    (set! *handlers* (cons proc *handlers*)))
(define (pop-handler) 
    (let((ret (car *handlers*)))
        (set! *handlers* (cdr *handlers*))
        ret))

(define (dummy-thrower)
    (displayln "no throw")
    (throw "throw")
    (displayln "throwed"))

;; main
(try 
    (displayln "before")
    (dummy-thrower)
    (displayln "after")
    (catch "throw" 
        (displayln "catched")
    )
)
(displayln "fucking finally")
