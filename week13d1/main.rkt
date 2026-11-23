#lang racket
(require "parser.rkt")
(require "util.rkt")
(require "interpreter.rkt")
(require "heap.rkt")



(define class1 (list 'cls 'rectangle '(w h) (list (list 'func 'size '() (list '(return ((this -> w) * (this -> h))))))))

(parse '(a = 1))

(parse class1)
(process (parse class1))
(display environment)

(parse '(new_obj = (new rectangle)))
