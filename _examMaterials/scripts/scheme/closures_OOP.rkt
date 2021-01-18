#lang racket
;; first, closure: procedures corredated with a referencing environment
;; for the non local variables of that function
(define (make-adder n)
    (lambda (x) (+ x n))
)
;; calling "make-adder" won't produce any results, in term of output:
;; it will just return a "environmentaled" function
;; pulling the hair of this concepts, we can obtain a OOP implementation
;; again, calling "make-ircraft" will return a complex closures, that behaves like 
;; an object
(define (make-aircraft model wings-number)
    (
        ;; instance attibutes
        let (
            (wings wings-number)
            (altitude 0)
            (model-name model)
        )
        
        ;; getters
        (define (get-altitude)
            altitude)
        (define (get-wings-number)
            wings)

        ;; methods
        (define (takeoff reach-altitude)
            (set! altitude reach-altitude))
        (define (toString)
            (if (> altitude 0)
                (string-append "model " model-name " flying at " (~a altitude) " (wings: " (~a wings) ")")
                (string-append "model " model-name " grounded")))
        
        ;; method dispatcher (remember: calls are MESSAGES between objects)
        (lambda (message . arguments)
            (apply ;; the apply call just selects the right method
                (case message  
                    ((get-altitude) get-altitude) ;; (case of message) "actual procedure name"
                    ((get-wings-number) get-wings-number)
                    ((toString) toString)
                    ((takeoff) takeoff)
                    (else (error "method non available")))
                arguments)) ;; the arguments for the method, as list, after the selected method call
    )
)

;; inheritance is implemented through delegation: 
;; every "subclass" is a decorator of the father class
;; and extends his method dispatcher
(define (make-seaplane model wings-number)
    (
        let(
            (plane (make-aircraft model wings-number))
            (water-grounded #f)
        )
        
        (define (is-on-water)
            (displayln (~a water-grounded)))

        ;; dispatcher extension
        (lambda (message . arguments)
            (case message
                ((is-on-water) (is-on-water))
                (else (apply plane (cons message arguments))))
    )
))