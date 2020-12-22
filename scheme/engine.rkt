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
        ;; most "external" function. 
        (define (handler) (start-timer (call/cc do-expire) handler))

        ;; main function
        (define (new-engine start-engine)
            (lambda (ticks complete expire)
                (let ((exec-end (
                    ;; this callcc sets the return point for both success and expired scenarios 
                    call/cc (
                        lambda (escape)
                            (set! do-complete 
                                (lambda (remaining-ticks result) (escape (lambda() (complete remaining-ticks result))))
                                )
                            (set! do-expire 
                                (lambda (resume) (escape (lambda() (expire (new-engine resume)))))
                                )
                            (start-engine ticks)
                    )
                )))
                (exec-end))))

        ;; still make-engine's body
        (new-engine (lambda (ticks) 
            (start-timer ticks handler)

            (let ((result (proc)))
                ;; collection of remaining ticks if task completes successfully
                (let ((remaining-ticks (stop-timer)))
                    (do-complete remaining-ticks result))))
            )
        )
    )

;; put some displays around
;; implement a recursive function that calls decrease-timer (factorial goes well)
;; we can redefine the syntax for lambdas to include decrease timer automatically

(define (factorial n)
    (decrease-timer)
    (if (<= n 0) 
        1
        (* n (factorial (- n 1))))
)