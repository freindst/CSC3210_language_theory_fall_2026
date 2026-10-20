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
            ((eq? 'boolean-exp (car parsed-exp))
                (cond
                    ;boolean True void void
                    ((void? (caddr parsed-exp)) (if (eq? 'True (cadr parsed-exp)) #t #f))
                    ;boolean ! (var-exp a) void
                    ((void? (cadddr parsed-exp)) (not (process (caddr parsed-exp))))
                    ;boolean > (num-exp 1) (var-exp a)
                    (else (calculate_boolean (cadr parsed-exp) (process (caddr parsed-exp)) (process (cadddr parsed-exp))))
                )
            )
            ((eq? 'func-exp (car parsed-exp))
                (let
                    (
                        ;cons the parameter list with the original environment
                        ;(((var-exp a) (num-exp 1)) ((var-exp b) (var-exp a)))
                        (my_env 
                            (cons (map (lambda (pair) (list (cadr (car pair)) (process (cadr pair)))) (cadr parsed-exp))
                        environment))
                        (expression_lst
                            (caddr parsed-exp))
                            ;(set! environment (cdr environment)))
                        (ret_val (void))
                    )
                    (begin
                        (update_base_environment my_env)
                        ;(print (cadr (cadr (process expression_lst))))
                        (set! ret_val (cadr (cadr (process expression_lst))))
                        (update_base_environment (cdr environment))
                        ret_val
                    )
                )
            )
            (
                (eq? 'ask-exp (car parsed-exp))
                    (if (process (cadr parsed-exp))
                        (process (caddr parsed-exp))
                        (process (cadddr parsed-exp))
                )
            )
            ;create a scope, and add all the parameters and its value into the scope
            ;append the scope on top of the environment
            ;wrap the begin with each statement of the bulk-exp
            ;remove the scope when the execution completes
            ;done
            ;(bulk-exp
            ;  (math-exp + 1 2)
            ;  (var-exp a)
            ;)
            ;(bulk-exp)
            ;we will iterate every expressions in the list, and until it leaves no expression to execute
            ((eq? (car parsed-exp) 'bulk-exp)
                (
                    if (null? (cdr parsed-exp))
                        (list 'terminator-exp (list 'bulk-ret (void))) ;(bulk-exp)
                        (let
                            (
                                (ret_lst (map process (cdr parsed-exp)))
                            )
                            (list 'terminator-exp (list 'bulk-ret (list-ref ret_lst (- (length ret_lst) 1))))
                        )
                )
            )
            (else (displayln "ERROR: expression has not been supported yet."))
    )
    )
)

(provide (all-defined-out))