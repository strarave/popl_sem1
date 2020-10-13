#lang racket

(define queue '())
(define (enqueue x)
    (set! queue (append queue (list x))))
(define (dequeue) (unless (null? queue)
    (let ((x (car queue))) 
        (set! queue (cdr queue))
        x)))

(define (start-coroutine proc)
    (call/cc 
        lambda(cc)
        (enqueue cc)
        (proc)))

(define (yield)
    (call/cc 
        (enqueue cc)
        ((dequeue))))
