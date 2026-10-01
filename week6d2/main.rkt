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
(parse '(function (a b) ((1 + 1) (a * b) (a + 1)) (4 5))) ;func ((a 4) (b 5)) (bulk-exp ((math-exp '* (var-exp a) (var-exp b))))
;(var-exp a): interpreter will find out the a as a variable name from the environment, and tell us what it is
(process (parse 'a))
(process (parse 'b))
(process (parse 'c))
(process (parse 10))
(process (parse '(function (a b) ((1 + 1) (a * b) (a + 1)) (4 5))))
;homework week5 day 1, 9/22
;test "process" function from interpreter, and confirm that it works in main
;(test (execute (prase 'a))) -> 1
;(test (execute (parse 'c'))) -> "ERROR: variable not found"
;(test (execute (parse 1))) -> a certain error

;if statement
;1. make the boolean expression work
;1a. define the boolean operator, so the parser knows what is a boolean, compared to what is a math
;1b. then you can based on its a boolean expression, return logic operation results instead of math result
;ask (a > b) (bulk-exp true_statments) (bulk-exp false_statements)
;2. make the new if-condition, ask-exp: if (process (parsed boolean-exp)) (process (parse true_statements)) (process (parse (false_statements))