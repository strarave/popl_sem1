(define-syntax curried
(
    syntax-rules ()
    ((_ args func)
        (call/cc(
            lambda(run)
                (cons run args)
;; ????
        ))

    )
))