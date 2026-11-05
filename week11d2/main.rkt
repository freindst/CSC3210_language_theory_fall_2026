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

;### homework: data type in the variable scope
;every value of our language is a tagged pair (type value), e.g. (num 1) (str "ccc") (bool #t)
;complete the data type update so that all the tests below run, and print the expected output in the comments
;starting scope: a = 1, b = 2, c = "ccc", e = True, f = False

;1. variables and literals
(process (parse '(
  main
  (fire a)        ;1
  (fire "hello")  ;hello
  (fire True)     ;True
)))

;2. math, and using a result again
(process (parse '(
  main
  (fire (a + b))          ;3
  (fire ((a + b) * 2))    ;6
  (n = ((a + b) * 2))
  (fire (n - 1))          ;5
)))

;3. comparison and logic
(process (parse '(
  main
  (fire (a < b))          ;True
  (g = (a < b))
  (fire (g && e))         ;True
  (fire (! e))            ;False
)))

;4. strings and equality
(process (parse '(
  main
  (s = "abc")
  (fire s)                ;abc
  (fire (s == "abc"))     ;True
  (fire (a === c))        ;False
)))

;5. conditions must be a boolean, and False must really be false
(process (parse '(
  main
  (ask f ((fire "wrong")) ((fire "right")))   ;right
  (running = True)
  (k = 0)
  (while running (
    (k = (k + 1))
    (ask (k == 3) ((running = False)) ())
  ))
  (fire k)                ;3
  (more = False)
  (m = 0)
  (do-while ((m = (m + 1))) more)
  (fire m)                ;1
)))

;6. functions
(process (parse '(
  main
  (func add (x y) (
    (z = (x + y))
    (return z)
  ))
  (fire (call add (3 4)))       ;7
  (func is_big (x) (
    (ask (x > 10) ((return True)) ((return False)))
  ))
  (fire (call is_big (20)))     ;True
  (func nothing () (
    (z = 1)
  ))
  (fire (call nothing ()))      ;void
)))

;7. gcd: paste your gcd_loop and gcd_rec from week 10 here, then remove the ; of the tests
;(process (parse '(fire (call gcd_loop (48 18)))))   ;6
;(process (parse '(fire (call gcd_loop (17 5)))))    ;1
;(process (parse '(fire (call gcd_loop (100 75)))))  ;25
;(process (parse '(fire (call gcd_rec (48 18)))))    ;6
;(process (parse '(fire (call gcd_rec (17 5)))))     ;1
;(process (parse '(fire (call gcd_rec (100 75)))))   ;25

;8. every value stored in the variable scope must be tagged, e.g. (n (num 6)) (g (bool #t)) (s (str abc))
(displayln environment)
