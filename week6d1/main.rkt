#lang racket
(require "parser.rkt")
(require "util.rkt")
(require "interpreter.rkt")



;a-> (var-exp a): parser will convert a symbol into var-exp
;(parse a) -> (var-exp a)
;(parse 1) -> error
(parse 'a)
(parse 'b)
(parse 10)
(parse '(32 + 32))
(parse '(function (a b) ((a * b)) (4 5))) ;func ((a 4) (b 5)) (bulk-exp ((math-exp '* (var-exp a) (var-exp b))))
;(var-exp a): interpreter will find out the a as a variable name from the environment, and tell us what it is
(process (parse 'a))
(process (parse 'b))
(process (parse 'c))
(process (parse 10))
;homework week5 day 1, 9/22
;test "process" function from interpreter, and confirm that it works in main
;(test (execute (prase 'a))) -> 1
;(test (execute (parse 'c'))) -> "ERROR: variable not found"
;(test (execute (parse 1))) -> a certain error