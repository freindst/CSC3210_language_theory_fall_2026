#lang racket
(require "parser.rkt")
(require "util.rkt")
(require "interpreter.rkt")

(parse '(! ((1 + 1) < a)))

(process (parse '(! ((1 + 1) < a))))

;### 10-06 week7d1 homework
;test if-condition
;while loop
;(while (boolean-exp)
;  (body)
;)
;while loop will check boolean-exp each time
;when it is true, it will execute the body
;when it is false, it stops
;while loop has its own scope

;do-while loop
;(do-while
;  (body)
;) (boolean-exp)
;do-while loop will run body for the first time unconditionally
;if boolean-exp is true, it will run the body
;otherwise, halt
;do-while loop also has its own scope