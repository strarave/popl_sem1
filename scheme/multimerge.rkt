#lang racket

(define (merge l1 l2)
    (cond
        ((null? l1) l2)
        ((null? l2) l1)
        (else
            (let (
                (first (car l1))
                (second (car l2))
                )
                (if (< first second)
                    (cons first (merge (cdr l1) l2))
                    (cons second (merge l1 (cdr l2)))
                )    
            )
        )
    )
)

(define (multi-merge . other-lists)
    (foldl merge '() other-lists)
)