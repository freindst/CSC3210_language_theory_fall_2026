#lang racket
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
      ((equal? 'math (car exp))
        (list
          'math-exp
          (caddr exp)
          (parse (cadr exp))
          (parse (cadddr exp))
        ))
       (else (displayln "PARSER ERROR: the statement has not been supported yet."))
    )
  )
)

(provide (all-defined-out))