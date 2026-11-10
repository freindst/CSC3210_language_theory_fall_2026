#lang racket
(require "util.rkt")

(define
    heap
    '()
)

(define
    heap_counter 0
)

;function generating new id based on heap_counter

;function read-item, return the value based on the id

;function create-item. 1. generate a new id. 2 link the id with the value

;function update-item. 1. create a the pair with old id and the new value. 2. assign the new heap including with the updates

;function delete-item. 1. create the pair with old id, and "#empty". 2 set the heap

(provide (all-defined-out))