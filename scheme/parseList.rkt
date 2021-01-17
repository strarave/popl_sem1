#lang racket

(define (flip b)
    (if (= b #f)
        #t
        #f
    )
)

(define (parseList lst)
    (define (parseListAux lst acc str accumulate strappend)
        (cond 
            [(eq? (car lst) '*) (parseListAux (cdr lst) acc str (flip accumulate) strappend)]
            [(eq? (car lst) '$) (parseListAux (cdr lst) acc str accumulate (flip strappend))]
            [(integer? (car lst))
                (if (eq? accumulate #t)
                    (parseListAux (cdr lst) (+ acc (car lst)) str accumulate strappend)
                    (parseListAux (cdr lst) acc str accumulate strappend)
                )
            ]
            [(string? (car lst))
                (if (eq? strappend #t)
                    (parseListAux (cdr lst) acc (append str (car lst)) accumulate strappend)
                    (parseListAux (cdr lst) acc str accumulate strappend)
                )
            ]
        )
    )
    (parseListAux lst 0 "" #f #f)
)