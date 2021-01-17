#lang racket
;; macros: compile-time executed function
;; "extension of the compiler itself"

(define-syntax while ;; macro declaration
    (syntax-rules () ;; other keyword in the struct
        ((_ condition body ...) ;; pattern to match
            ;; list of intructions
            ;; "..." is a "Kleene star" for the "body" placeholder. 
            ;; use last statements with caution, tho
            (let w ()
                (when condition
                    (begin body ...)  
                    (w)
                )              
            )
        )
    )
)