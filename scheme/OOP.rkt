;; this example shows a basic OOP implementation
#lang racket

;; "constructor"
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
            (apply (case message
                ((get-altitude) get-altitude)
                ((get-wings-number) get-wings-number)
                ((toString) toString)
                ((takeoff) takeoff)
                (else (error "method non available")))
                arguments))
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