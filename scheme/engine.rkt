#lang racket

;; discrete time model 
(define clock 0)
(define expire-handler #f)
(define (start-timer ticks handler)
    (set! clock ticks)
    (set! expire-handler handler))
(define (decrease-timer)
    (if (> clock 0)
        (set! clock (- clock 1))
        (expire-handler)))
(define (stop-timer)
    (let ((time-left clock))
        (set! clock 0)
        (set! expire-handler #f)
        time-left))

;; the fricking engine
;; the engine needs 
;; - the number of ticks available for the computation
;; - the function to call if the inner task completes
;; - a "expire" procedure that is called when the time expires. 
;; this last function takes as argument a new engine that can resume the expired task

(define (make-engine proc)
    (let ((do-complete #f) (do-expire #f))
        (displayln "entering make-engine")

        (define (handler) 
            (displayln "entering handler")
            ;; WATCH OUT the (call/cc do-expire) is EVALUATED! so its content is executed before the "start-timer" execution
            (start-timer (call/cc do-expire) handler))

        (define (new-engine start-engine)
            (lambda (ticks complete expire)
                (displayln "evaluating new-engine")
                (let ((exec-end (
                    ;; this callcc sets the return point for both success and expired scenarios 
                    call/cc (
                        lambda (escape)
                            (displayln "setting expire and complete procedures")
                            (set! do-complete 
                                (lambda (remaining-ticks result) 
                                    (displayln "completing")
                                    (escape (lambda() (complete remaining-ticks result))))
                                )
                            (set! do-expire 
                                (lambda (resume)
                                    (displayln "expired") 
                                    (escape (lambda() (expire (new-engine resume)))))
                                )
                            (start-engine ticks)
                    )
                )))
                (displayln "body of new-engine, executing exec-end")
                (exec-end))))

        ;; still make-engine's body
        (new-engine (lambda (ticks)
            (displayln "starting timer") 
            (start-timer ticks handler)

            (displayln "executing")
            (let ((result (proc)))
                ;; collection of remaining ticks if task completes successfully
                (displayln "here, the computing is completed successfully.")
                (let ((remaining-ticks (stop-timer)))
                    (do-complete remaining-ticks result))))
            )
        )
    )

(define (factorial n)
    (displayln "decreasing timer")
    (decrease-timer)
    (if (<= n 0) 
        1
        (* n (factorial (- n 1))))
)

(define fact-engine (make-engine(lambda()(factorial 10))))
(define (fact-resume res)
    (set! fact-engine res))

;; we can redefine the syntax for lambdas to include decrease timer automatically
