---
name: scheme-dev
description: Practical development and review instructions for Racket 8.x Scheme code in CS F301 Assignment 2.
---

# Scheme and Racket Development Instructions

## Environment and assignment boundaries

- Target Racket 8.x, and begin every submitted file with `#lang racket/base`.
- These restrictions apply to the assignment code. Use only the forms and procedures listed below; do not assume another `racket/base` binding is permitted.
- A Scheme prompt should cover one unit of work, such as one function, test file, or review. Do not produce a whole problem solution in one step.

## Permitted forms and procedures

The complete permitted set is:

- `define`, `lambda`, `let`, `let*`, `letrec`, named `let`, `if`, `cond` (including `else`), `and`, `or`, `not`, `begin`, and quote syntax (`'`).
- `cons`, `car`, `cdr`, `list`, and every composition of `car` and `cdr` up to four levels (for example, `cadr`, `caddr`, and `cddddr`).
- `null?`, `pair?`, `eq?`, `assq`, and `assoc`.
- Arithmetic and comparison operators: `+`, `-`, `*`, `<`, `>`, `<=`, `>=`, and `=`; also `max`.
- `display` and `newline`.
- For S2 only, `read` is additionally allowed.

Do not use any other Racket built-in, library, syntax, or feature. In particular, do not use `set!` or other mutation; vectors; hash tables; strings; `do` or `for` loops; or `length`, `append`, `reverse`, `map`, `filter`, `member`, `memq`, `list-ref`, or `list-tail`.

When a convenient operation is prohibited, implement a small helper using the permitted forms. For example, define a recursive length helper that returns zero for the empty list and adds one per pair, or define a recursive map helper that processes the head and tail. Keep helpers general enough to be clear, and check their empty-input behavior. Do not call a prohibited built-in indirectly through an alias or wrapper.

## Functional programming approach

- Use recursion instead of loops. Prefer structural recursion: for a list, handle the empty list and recursively process its tail; for a tree, handle the empty tree and recursively process its subtrees.
- Keep data immutable. Construct results with `cons` and `list`; do not mutate an input or use assignment. Pass changing state explicitly through function arguments, including accumulators when they make a recursive computation clearer or more efficient.
- Use higher-order functions when the task calls for them. Accept functions as arguments and return functions with `lambda`; apply the supplied procedure to the appropriate value rather than hard-coding one behavior.
- For nested structures, distinguish atoms from lists with the permitted predicates and recurse at each list level. Preserve the required order while combining recursively produced results.
- Choose tail recursion when input size or depth makes it useful, especially for long lists. Ensure recursive calls make progress and that accumulated results preserve the intended order.

## Naming, layout, and comments

- Use descriptive, lowercase hyphenated names for procedures and helpers (for example, `tree-height` or `my-length`). Use names that express a value or action clearly.
- Indent nested forms consistently, with each clause or argument on a readable line when the expression is long. Align `cond` clauses and keep parentheses balanced and easy to scan.
- Give each function a clear purpose. Keep helpers close to the functions that use them and avoid duplicate definitions of the same required function.
- Put base cases and recursive cases in an explicit, easy-to-follow structure, usually with `cond` or `if`. Confirm that every recursive branch reduces the structure or advances toward a base case.
- Comment non-obvious invariants, accumulator meanings, and tricky order or nesting behavior. Avoid comments that merely repeat the code.

## Running files

Run each file from the directory containing it:

```sh
racket 5_q3.rkt
racket 5_q4.rkt
```

The grader appends its own calls. For local checks, use a separate temporary driver or test file that requires the implementation and invokes the functions; do not put test calls into the submitted implementation file. For S2, test input through standard input because its entry point reads values with `read`.

## Submitted file requirements

- Start with `#lang racket/base`.
- Contain definitions only. Do not call solution functions at the top level.
- Do not print anything when the file is loaded.
- Leave the grader able to append its own function calls to the file.
- Where output is part of a function's contract, print only the specified result and newline.

## Common AI-generated Scheme failure modes

- Using a prohibited built-in because it is familiar from Racket or another Scheme dialect. Audit every identifier against the permitted list, including helpers and convenience syntax.
- Mishandling the empty list: treating `()` as a pair, missing an empty-list base case, or giving it the wrong result for the task.
- Recursing incorrectly over nested lists by either stopping at the outer level or treating an atom as a list. Handle list structure and atoms deliberately at every depth.
- Accidentally modifying data or relying on mutation instead of constructing a new result and passing state through arguments.
- Constructing a higher-order function with the wrong arity, capturing the wrong value, or applying the predicate/function to the wrong argument.
- Reversing or scrambling output order while building results recursively, especially when a custom helper replaces `map`, `append`, or `reverse`.
- Using recursion that does not make progress, causing nontermination, or using non-tail recursion on very long lists when performance matters.
- Printing during module load, adding top-level sample calls, or emitting prompts or extra output that violate the grader's output contract.

## Self-review checklist

Before presenting any implementation, verify all of the following:

- [ ] The change addresses only the requested unit and matches its contract.
- [ ] The file starts with `#lang racket/base` and uses only permitted forms and procedures; `read` appears only for S2.
- [ ] No mutation, prohibited built-in, unapproved library, or indirect call to a prohibited operation is used.
- [ ] Recursion is structural, makes progress, and handles empty inputs and base cases correctly.
- [ ] Nested lists or trees are processed at every required level, in the required order.
- [ ] Data remains immutable, and state is passed through arguments.
- [ ] Higher-order functions have the intended arity and apply supplied procedures to the correct values.
- [ ] Recursion is tail-recursive where performance on long inputs calls for it.
- [ ] The submitted file contains definitions only, performs no top-level calls, and prints nothing when loaded.
- [ ] Any function output matches the required format exactly; independent tests include boundary and nested cases.
