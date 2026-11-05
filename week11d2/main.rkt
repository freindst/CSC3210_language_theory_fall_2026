#lang racket
(require "parser.rkt")
(require "util.rkt")
(require "interpreter.rkt")

(displayln environment)
(parse '(
  main
  (fire (a + b))
))
;(check_type 'num '(num 1))
;(check_type 'num '(str "111"))
(process (parse '(
  main
  (fire (a > b))
  (fire (e && f))
  
)))

;### homework: greatest common divisor
;write gcd with (Euclid's algorithm) in our defined language in two ways:
;  1. loop manner: use while (or do-while / for) to repeat the Euclid step
;  2. recursive manner: the function calls itself
;test 3 cases for each way, for example:
;  gcd(48, 18) = 6
;  gcd(17, 5) = 1
;  gcd(100, 75) = 25
;write your code below

