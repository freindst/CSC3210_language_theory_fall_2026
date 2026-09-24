#lang racket
(require "util.rkt")

;homework week5 day 1, 9/22
;create a function, that "process" the parser's results
;if it is a var-exp, resolve the value if can find, otherwise output void error
;no other expression are supported, so all will prompt errors
(define
    process
    (lambda (parsed-exp) (
        ;var-exp symbol
        cond
            ((null? parsed-exp) (displayln "ERROR: EMPTY PROGRAM."))
            ;error handler from the parser
            ((void? parsed-exp) (void))
            ;if it is a variable, we will resoleve the value, and return the resolved value
            ;programmer should be responsible for what he wrote, rather than hand it to the error handler
            ;since the parser already validate the statement of the language, interpreter can omit this stage, but it is still risky if you do not use the parser before interpreter
            ((equal? 'var-exp (car parsed-exp)) (resolve_env environment (cadr parsed-exp)))
            ((equal? 'num-exp (car parsed-exp)) (car (cdr parsed-exp)))
            ((eq? 'math-exp (car parsed-exp))   ;math-exp + (math-exp + ...) (num-exp 10)
                (cond
                    ;((or (void? (process (caddr parsed-exp)) ) (process (cadddr parsed-exp))))
                    ((and (number? (process (caddr parsed-exp)) ) (number? (process (cadddr parsed-exp))))
                        (do_math (cadr parsed-exp) (process (caddr parsed-exp)) (process (cadddr parsed-exp))))
                    (else (displayln "INTERPRETOR ERROR: non-numeric cannot apply math."))
                )
                
            )
            (else (displayln "ERROR: expression has not been supported yet."))
    ))
)

(provide (all-defined-out))