# Week 11 Day 2 Homework: Data Types in the Variable Scope

**Due:** _TBD_

In class we started adding data types to our language. Every value carries a type tag:

```racket
(num 1)  (str "ccc")  (bool #t)  ;see the type list at the top of util.rkt
```

Only part of the project uses the tags so far. Your job is to finish the update so that the **whole project** works with tagged values.

## The rule

> **Every value of our language is a tagged pair `(type value)`.** That includes every value that `process` returns, that is stored in the variable scope, passed as a function argument, or returned from a function.
>
> **Unwrap only where Scheme has to compute**, for example in math or comparisons, and **wrap the result again**.

## What to do

The bottom of `main.rkt` has a test program, sections 1–8. Each line has its expected output in a comment. Right now most of it fails. Update `parser.rkt`, `util.rkt` and `interpreter.rkt` until:

1. **Sections 1–6** run and print exactly the expected output.
2. **Section 7:** paste your `gcd_loop` and `gcd_rec` from week 10, uncomment the tests, and they print 6, 1, 25 for both versions.
3. **Section 8** prints the environment. Every value stored in it must be tagged, e.g. `(n (num 6))`, `(g (bool #t))`, `(s (str abc))`, and none may be a plain value like `(n 6)`.

Finding **where** to update is part of the homework. Start from the first test that fails, find out why, fix it, and move on to the next one.

A few decisions are already made for you by the expected outputs:
- `fire` prints the plain value: `1`, `ccc`, `True`, `False`.
- `==` compares values of the same type; `===` compares the type and the value.
- A function without `return` prints `void`.
- A condition in `ask`, `while`, `do-while` or `for` must be a `bool`. `False` must really be false.

## Fix report

Write a separate document, as a Word file or PDF, that explains your fixes. For each fix, describe:

1. **What** you fixed: the file and the function or expression, and the test that failed because of it.
2. **How** you fixed it: what you changed. A short code snippet is welcome.
3. **Why** the fix was needed: what went wrong with the tagged values before your fix, and why your change solves it.

The report must end with an **AI disclosure** section (required). Either state that you did not use any AI tools, or list:
- which AI tools you used (for example ChatGPT, Claude or Copilot),
- what you asked them,
- what you used from their answers,
- how you checked that their answers were correct.

## Submission
1. Push your work to your GitHub repository and submit the link to your `week11d2` folder.
2. Submit screenshots of `racket main.rkt` (or DrRacket) showing the output of sections 1–8, including the printed environment.
3. Submit your fix report as a Word file or PDF.

## Grading

| Part | Points |
|---|---|
| Sections 1–6 print the expected output | 65 |
| Section 7: both GCD versions still work | 10 |
| Fix report: what, how and why for each fix, with the AI disclosure | 25 |
| **Total** | **100** |
