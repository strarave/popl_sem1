#lang racket

(define (pure-push s e)
    (append (list e) s)
    s
)
(define (pure-pop s)
    (car s)
)

(define (dyck-parser L)
    (define (dyck-aux lst stack couples)
        (if (= (length lst) 0)
            couples
            (cond
                [(eq? (car lst) '1) 
                    (dyck-aux (cdr lst) (pure-push stack '1) couples)
                ]
                [(eq? (car lst) 'a)
                    (dyck-aux (cdr lst) (pure-push stack 'a) couples)
                ]
                [(eq? (car lst) '2)
                    (if (eq? (pure-pop stack) '1)
                        (dyck-aux (cdr lst) (cdr stack) (+ couples 1))
                        #f
                    )
                ]
                [(eq? (car lst) 'b)
                    (if (eq? (pure-pop stack) 'a)
                        (dyck-aux (cdr lst) (cdr stack) (+ couples 1))
                        #f
                    )
                ]
                [else (dyck-aux lst stack couples)]

            )
        )
    )
    (dyck-aux L '() 0)
)