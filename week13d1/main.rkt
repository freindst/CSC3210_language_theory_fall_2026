#lang racket
(require "parser.rkt")
(require "util.rkt")
(require "interpreter.rkt")
(require "heap.rkt")

(define prog
  (list
   'main
   '(cls rectangle
         (width height)
         (
          (func size () (return ((this -> width) * (this -> height))))
          )
         )
   '(new_obj = (new rectangle))
   '((new_obj -> width) = 2)
   '((new_obj -> height) = 1)
 )
)
(parse prog)
(process (parse prog))
(display environment)
(display heap)