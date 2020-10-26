#lang racket

;; the function stack (FIFO manged list of lambdas)
(define *stack* '())

;; function to save a lambda on top of the stack
;; must be called to initialize the block to yield to the execution
(define (enqueue proc)
    (set! *stack* (cons proc *stack*)))

;; "pop" operation from the stack
;; called by the yield thunk itself to move to the coroutine block
(define (dequeue)
    (let ((popped (car *stack*)))
        (set! *stack* (cdr *stack*))
        popped))


;; function to yield the execution to a saved block
(define (yield)
    (displayln "yielding...")
    (call/cc(
        lambda(cc)
            ((dequeue))
            (cc)
    )))

;; test function
(define (yield-test)
    (displayln "before")
    (yield)
    (displayln "after"))

;; some other test functions
(define (first-level)
    (displayln "first level!")
    (yield))
(define (second-level)(displayln "second level!"))

;; main
(enqueue second-level)
(enqueue first-level)
(yield-test)