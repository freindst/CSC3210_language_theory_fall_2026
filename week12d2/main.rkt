#lang racket
(require "parser.rkt")
(require "util.rkt")
(require "interpreter.rkt")
(require "heap.rkt")

(generate_new_id)

(displayln heap)

(create_heap_item '(1))

(create_heap_item '(2))

(displayln (read_heap_item (string->symbol "#0")))

(displayln (read_heap_item (string->symbol "#1")))

(update_heap_item (string->symbol "#0") 1)

(displayln (read_heap_item (string->symbol "#0")))

(update_heap_item (string->symbol "#2") 2)

(displayln heap)