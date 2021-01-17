#lang racket

(define (deepen lst)
    (foldl (lambda (x y)
        (list y x)
    )
    (list (car lst))
    (cdr lst)
    )
)

(define-syntax define-with-return:
    (syntax-rules ()
        ((_ return (fun p1 ... ) e1 ...)
            (define (fun p1 ...)
                (call/cc (lambda(return) e1 ...)))
        )
    )
)


(define-with-return: return (f x)
    (define a 3)
    (return (* a x))
)