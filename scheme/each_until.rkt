;; exam text 2020 02 07
#lang racket

;; implementation of each-until product
(define-syntax each-until
    (syntax-rules (in until :)
        ((_ var in list until pred : body ...)
            (let loop ((xs list))
                (unless (null? xs)
                    (let ((var (car xs)))
                        (unless pred
                            (begin 
                            body 
                            ... 
                            (loop (cdr xs)))
                        )
                    )
                )
            )
        )
    )
)


;;; (define-syntax each-until
;;;     (syntax-rules (in until :)
;;;         ((_ x in L until pred : body ...)
;;;             (let loop ((xs L))
;;;                 (unless (null? xs)
;;;                     (let ((x (car xs)))
;;;                         (unless pred
;;;                             (begin
;;;                             body ...
;;;                             (loop (cdr xs))))))))))