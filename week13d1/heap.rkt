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
(define
    generate_new_id
    (lambda ()
        ;"#counter"
        (string->symbol (string-append "#" (number->string heap_counter)))
    )
)

;function create-item. 1. generate a new id. 2 link the id with the value
(define
    create_heap_item
    (lambda(value)
        (
            let*
            (
                (new_id (generate_new_id))
                (new_item (list new_id value))
                (new_heap (cons new_item heap))
            )
            ;1. add the item to heap -> create a new heap, and replace the heap. 2. increment the id
            (begin
                (set! heap new_heap)
                (set! heap_counter (+ heap_counter 1))
                new_id
            )
        ))
)

;function read-item, return the value based on the id
(define
    read_heap_item
    (lambda(key)
        (letrec
            (
                (read_helper (lambda(key_id heap_stack)
                    (cond
                        ((null? heap_stack) (error "The heap item is not existed"))
                        ((and 
                            (eq? key_id (car (car heap_stack)))
                            (eq? '|#empty| (cadr (car heap_stack)))) (error "The heap item has been deleted"))
                        ((eq? key_id (car (car heap_stack))) (cadr (car heap_stack)))
                        (else (read_helper key_id (cdr heap_stack)))
                    )
                ))
            )
            (read_helper key heap)
        )
    )
)

;function update-item. 1. create a the pair with old id and the new value. 2. assign the new heap including with the updates
;0. given id, how do we know it is existed in the heap: #0 -> "#0" -> substring -> "0" -> number -> compare
;1. find the id, update the heap
;2. find the id, but the item has been removed we can ignore it, but we also can add the error
;3. not find the id: error
(define
    update_heap_item
    (lambda (key_id value)
        (letrec
            (
                (string_key (symbol->string key_id))
                (check_heap_id? (lambda (key)
                    (<= (string->number (substring string_key 1 (string-length string_key))) heap_counter)
                ))
                (update_item (lambda (left right)
                    (cond 
                        ((null? right) (error "Heap id has not found."))
                        ((eq? (car (car right)) key_id)
                            (append left (cons (list key_id value) (cdr right))))
                        (else (update_item (append left (list (car right))) (cdr right)))
                    ))
                )
            )
            (if (check_heap_id? key_id)
                (set! heap (update_item '() heap))
                (error "Heap id is not in the range.")
            )
        )
    )
)


;function delete-item. 1. create the pair with old id, and "#empty". 2 set the heap
(define
    delete_heap_item
    (lambda (key_id)
        (update_heap_item key_id '|#empty|)
    )
)


(define
  get_obj_property
  (lambda (obj_name property_name)
    (letrec
      (
        (obj_id (resolve_env environment obj_name))
        (heap_item (read_heap_item obj_id))
      )
      (resolve heap_item property_name)
    )
  )
)

(define
  set_obj_property
  (lambda (obj_name property_name property_value)
    (letrec
      (
        (obj_id (resolve_env environment obj_name))
        (heap_item (read_heap_item obj_id))
        (new_heap_item (update_scope heap_item property_name property_value))
      )
      (update_heap_item obj_id new_heap_item)
    )
  )
)

(provide (all-defined-out))