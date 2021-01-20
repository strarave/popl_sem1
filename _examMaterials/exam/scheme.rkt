;;; Define a pure function (i.e. without using procedures with side effects, such as set!) 
;;; which takes a multi-level list, i.e. a list that may contain any level of lists, and converts 
;;; it into a data structure where each list is converted into a vector. 

(define (nested-to-vector l)
    (cond
        ;;  in case the first element is a list, it means it's a nested one, so it must be "vectorized"
        [(list? (car l)) (vector (nested-to-vector (car l)) (nested-to-vector (cdr l)))]

        ;; this condition is satisfied if the entire "l" is a list, but the first element is not: so ti's skipped and appended to the vector
        [(list? l) (vector (car l) (nested-to-vector (cdr l)))]
        
        ;; final case: no more nesting. Just return the element
        [else l]
    )
)