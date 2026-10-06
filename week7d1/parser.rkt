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
      ;boolean expression: True/False; A OP B; !A
      ;we unify everything into the same interface, OP, A, B
      ;when it is only true or false, OP will be TRUE OR FALSE
      ;when it is three elements, OP will be the operator, A and B will be the value
      ;when it is two elements, OP will be NOT, A will be the value, and B will be empty
      ((or (equal? exp "True") (equal? exp "False"))
        (list 'boolean-exp exp (void) (void)))
      ((and (eq? (length exp) 3) (is_valid_boolean_op (cadr exp)))
       (list 'boolean-exp (cadr exp) (parse (car exp)) (parse (caddr exp))))
      ((and (eq? (length exp) 2) (eq? '! (car exp)))
       (list 'boolean-exp (car exp) (parse (cadr exp)) (void)))
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
      ;ask (boolean) true false
      (
        (equal? 'ask (car exp))
        (list
          'ask-exp
          (parse (cadr exp))
          (cons 'bulk (caddr exp))
          (cons 'bulk-exp (cadddr exp))
        )
      )
      (else (displayln "PARSER ERROR: the statement has not been supported yet."))
    )
  )
)

(provide (all-defined-out))