#lang racket

;; try catch structure
(define-syntax try
    (syntax-rules (catch finally) ;; the construct must know the exception to be catched and the handler
        ((_ exp ... (catch what hand ...) (finally f ...))
            (call/cc (lambda (exit)
                (push-handler (
                    lambda(x)
                        (if (equal? x what)
                            (exit (begin hand ...) (begin f ...))
                            (throw x)
                        )
                ))
                (let((res (begin exp ...)))
                    (pop-handler)
                    res
                    (begin f ...))))
                )))

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

(define (throw-function)
    (displayln "no throw")
    (throw "throw")
    (displayln "throwed"))

(define (finally-function)
    (displayln "fucking finally"))

;; main
(try
    (displayln "before throwing...")
    (throw-function)
    (catch "throw"
        (displayln "catched"))
    (finally 
        (finally-function)))
(try
    (displayln "no throw this time")
    (catch "throw"
        (displayln "catched"))
    (finally 
        (finally-function)))
