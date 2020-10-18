#lang racket

;;; (define-syntax =
;;;   (syntax-rules ()
;;;     ((_ var val body ...)
;;;      (let ((var val))
;;;        (begin
;;;          body
;;;          ...)))))

;;; (define (fibonacci n)
;;;   (cond [(= n 0) 0]
;;;         [(= n 1) 1]
;;;         [else (+ (fibonacci (- n 1)) (fibonacci (- n 2)))]))

(define-syntax while
  (syntax-rules ()
    ((_ condition body ...)
     (let loop ()
       (when condition
         (begin
           body
           ...
           (loop)))))))

;; projection function: extracts the n-th element from the "rest" list
(define-syntax proj
  (syntax-rules ()
    ((_ n v) v)
    ((_ n v1 vr ...)
      (if (= n 0) v1 (proj (- n 1) vr ...)))))

;; generator of factorial numbers with continuations
(define gen-fact #f)
(define (set-fact-gen)
  (let loop ((f 1) (n 1))
    (call/cc (lambda (env) 
      (set! gen-fact env)))
    (set! f (* f n))
    (set! n (+ n 1))
    f))

;; loop with continuations
(define (make-while guard)
  (call/cc (
      lambda(back-edge)
        (lambda () (when (guard) (back-edge (make-while guard)))
  ))))
(define (count n)
  (let* ((i 0) (mywhile (make-while (lambda() (< i n)))))
    (displayln i)
    (set! i (+ i 1))
    (mywhile)))


;; simple call/cc usage
(define (break-negative l)
  (call/cc (lambda (break)
    (for-each (lambda(x)
      (if (>= x 0) (displayln x) (break))) l ))))

(define (skip-negative l) 
  (for-each (lambda (x) (
    call/cc( lambda(env) (
      if (> x 0) (displayln x) (env)
    ))
  )) l))

;; backtracking choices
(define *paths* '())
(define fail #f)
(define (choose l)
  (if (null? l) 
    (fail)
    (call/cc
      (lambda(cc)
        (set! *paths* (cons 
          (lambda()
            (cc (choose (cdr l))))
          *paths*))
        (car l)))))

(define (is-the-sum-of n)
  (unless (and (>= n 0) (<= n 10)) (error "Out of range"))
  (let ((x (choose '(1 2 3 4 5)))
        (y (choose '(1 2 3 4 5))))
      (if (= (+ x y) n) 
        (list x y)
        (fail)))
)

;; main
(call/cc 
  (lambda(exit)
    (set! fail 
      (lambda() 
        (if (null? *paths*)
        (exit 'end)
        (let ((p1 (car *paths*)))
          (set! *paths* (cdr *paths*))
          (p1)))))))




