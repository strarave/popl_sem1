#lang racket

;; exam text 2020 01 15
;; foldl and foldr operation for vectors in scheme
(define (vector-foldl proc start vec)
    (let loop ((index 0)(acc start))
        (if (< index (vector-length vec))
            (loop (+ index 1)(proc acc (vector-ref vec index)))
            acc
        )
    )
)

(define (vector-foldr proc start vec)
    (let loop ((index (- (vector-length vec) 1))(acc start))
        (if (>= index 0)
            (loop (- index 1)(proc acc (vector-ref vec index)))
            acc
        )
    )
)

;; pure and <*> operations for vectors
(define (vector-pure v)
    (vector v))

(define (vector-<*> fun-vect data-vect)
    (let loop ((index 0)(final-vect #()))
        (if (< index (vector-length fun-vect))
            (loop 
                (+ index 1)
                (vector-append 
                    final-vect 
                    (vector-map (eval (vector-ref fun-vect index)) data-vect)
                )
            )
            final-vect
        )           
    )
)