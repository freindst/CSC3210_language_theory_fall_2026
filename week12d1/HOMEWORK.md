# Week 12 Day 1 Homework: The Heap

**Due:** _TBD_

The variable scope works like a stack: a value lives only until its scope is popped. Objects need to live longer than the function that created them, so they are stored in a separate memory, the **heap**. Variables will later hold only the **id** of a heap item.

In this homework you build the heap itself. Classes and objects come later and will use the functions you write here.

## The heap structure

The heap in `heap.rkt` is a list of `(id value)` pairs, the same shape as a variable scope:

```racket
((|#3| (bool #t)) (|#2| |#empty|) (|#1| (num 10)))
```

- **Ids** are symbols made from `heap_counter`: `|#1|`, `|#2|`, `|#3|`, ... Racket prints them as `#1`, `#2`, `#3` with `display`.
- **Values** are tagged values from last week, such as `(num 3)` or `(str "abc")`.
- **New items** are added at the **front** of the heap.
- **A deleted item stays in the heap** with the value `|#empty|`, and its id is **never used again**.

## What to do

Complete the five functions described by the comments in `heap.rkt`:

| Function | What it does |
|---|---|
| `(generate-id)` | Increases `heap_counter` and returns the new id, e.g. `|#1|`. |
| `(create-item value)` | Gets a new id, adds `(id value)` to the front of the heap, and **returns the id**. |
| `(read-item id)` | Returns the value stored under the id. |
| `(update-item id value)` | Replaces the value stored under the id. |
| `(delete-item id)` | Replaces the value with `|#empty|`. |

`read-item`, `update-item` and `delete-item` must report an error, using `error`, when the id cannot be used:
- an id that was never created: `Heap error: #99 does not exist`
- an id that was deleted: `Heap error: #2 has been deleted`

Reuse the functions you already have in `util.rkt` where they fit.

## Tests

The bottom of `main.rkt` has sections 9–13. Each line has its expected output in a comment. `racket main.rkt` must print exactly that output, and sections 1–8 must still work.

Until all five functions are defined, `main.rkt` stops with `unbound identifier`. That is expected.

## Fix report

Write a separate document, as a Word file or PDF, that explains your work. For each of the five functions, describe:

1. **What** it does, and which tests check it.
2. **How** you implemented it. A short code snippet is welcome.
3. **Why** you implemented it that way. For example, why a deleted item is kept as `#empty` instead of being removed, or why an id is never reused.

The report must end with an **AI disclosure** section (required). Either state that you did not use any AI tools, or list:
- which AI tools you used (for example ChatGPT, Claude or Copilot),
- what you asked them,
- what you used from their answers,
- how you checked that their answers were correct.

## Submission

1. Push your work to your GitHub repository and submit the link to your `week12d1` folder.
2. Submit a screenshot of `racket main.rkt` (or DrRacket) showing the output of sections 9–13.
3. Submit your report as a Word file or PDF.

## Grading

| Part | Points |
|---|---|
| Section 9: `create-item` and `generate-id` | 15 |
| Section 10: `read-item` | 15 |
| Section 11: `update-item` | 15 |
| Section 12: `delete-item` | 15 |
| Section 13: errors | 15 |
| Report: what, how and why for each function, with the AI disclosure | 25 |
| **Total** | **100** |
