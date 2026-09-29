#lang racket
(require "util.rkt")
;parser will translate my programming language into an intemediate form
;it will be reletively easier to execute

(define parse
  (lambda
      (exp)
    (cond
      ((symbol? exp) (list 'var-exp exp))
      ((number? exp) (list 'num-exp exp))
      ((string? exp) (list 'string-exp exp))
      ((null? exp) (displayln "ERROR: empty statement"))
      ;a math is a triple element list, and the second element is a valid operator
      ;1 + a
      ((and (is_valid_math_op (cadr exp)) (equal? (length exp) 3))
        (list
          'math-exp
          (cadr exp)
          (parse (car exp))
          (parse (caddr exp))
        ))  ;math-exp has no error message here
      ;function expression
      ((equal? 'function (car exp))
        (if (and (equal? (length (cadr exp)) (length (cadddr exp))) (not (null? (caddr exp))))
          (list
            'func-exp
            (create_pair_list '() (map parse (cadr exp)) (map parse (cadddr exp)))
            (cons 'bulk-exp (map parse (caddr exp)))
          )
          (displayln "PARSER ERROR: this is not a valid anonymous function definition."))
      )
      (else (displayln "PARSER ERROR: the statement has not been supported yet."))
    )
  )
)

(provide (all-defined-out))