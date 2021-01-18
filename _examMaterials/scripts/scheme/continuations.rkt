#lang racket

(let (
    (x (call/cc(
        lambda(proc-or-val)
            (displayln "in the continuation")
            proc-or-val))) ;; setting x as the continuation
    )

    (if (procedure? x)
        ;; calling the continuation (that puts us in the declaration part)
        ;; and forcing it to return "5"
        (x 5);; this call does not display "in the continuation"        
        (displayln x)
    )
)

;; continuations used as a loop breaker:
(call/cc(
    lambda(break) ;; set the continuation outisde the loop
        (let loop ((x 0))
            (when (< x 10)
                (displayln x)
                (if (= x 7) 
                    (break) ;; if the condition is met we just jump outside of the loop 
                    (loop (+ x 1)))
            )
        )
))