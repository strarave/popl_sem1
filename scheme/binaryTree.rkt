#lang racket

(struct node(
    (value #:mutable)
))

(struct branch(
    (left)
    (right)
))

(define (tmap! func tree)
    (if (node? tree)
        (func (node-value tree))
        (
            (tmap! func (branch-left tree))
            (tmap! func (branch-right tree))
        )
    )
)