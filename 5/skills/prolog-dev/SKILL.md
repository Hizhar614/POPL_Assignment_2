---
name: prolog-dev
description: Practical development and review instructions for SWI-Prolog 9.x code in CS F301 Assignment 2.
---

# Prolog Development Instructions

## Environment and assignment boundaries

- Target SWI-Prolog 9.x.
- Follow the assignment's one-unit-per-prompt rule: handle one predicate, test file, or review at a time. Do not produce a whole problem solution in one step.
- Submitted Prolog files contain definitions only. Do not add initialization directives or call `halt/0` from a submitted file.
- Do not use `assert/1`, `retract/1`, or global variables. The only allowed libraries are `lists`, `apply`, `yall`, and `aggregate`; import only what is needed.
- Keep output limited to exactly what the assignment explicitly requires. Predicates that are meant to compute or enumerate should not print.

## Declarative style

- Describe relationships and constraints in clauses; prefer unification, recursion, and relational goals over procedural sequencing or mutation.
- Write predicates so their intended modes and logical meaning are clear. Avoid unnecessary cuts, `once/1`, side effects, and control constructs that hide valid answers or restrict backtracking.
- Use finite, well-founded recursion. Make each recursive call operate on a structurally smaller input or otherwise show why it terminates.
- Decompose a task into small predicates with one clear responsibility. Keep domain facts, constraint checks, generation, formatting, and output separate when that makes the logic clearer.
- Do not assume a predicate is called in only one mode unless the assignment specifies that mode. Check how it behaves on variables, ground terms, and edge cases relevant to its contract.

## Naming, clauses, and comments

- Name predicates in `snake_case`, with descriptive nouns or verb phrases; use names that communicate the relation (for example, `valid_solution/1`).
- Use lowercase atoms for constants and predicate names. Use descriptive `UpperCamelCase` or `PascalCase`-style variable names, beginning with an uppercase letter; use `_` for a value that is intentionally unused.
- Keep clauses short and group clauses for the same predicate together. Put base cases before or alongside recursive cases so termination and coverage are easy to inspect.
- Use comments to explain the purpose of a non-obvious predicate, a tricky invariant, or an assignment-required English clue. Do not narrate each obvious line or use comments to conceal a procedural workaround.
- Keep arities consistent with the documented meaning of a predicate. Check that each clause covers the intended cases and that recursive clauses make progress.

## Running code

Run the required entry point from the directory containing the file:

```sh
swipl -q -f 5_q1.pl -g main -t halt
```

Run another predicate or goal with:

```sh
swipl -q -f 5_q1.pl -g "<goal>" -t halt
```

Replace `<goal>` with a concrete Prolog goal, including any required quoting. `-t halt` is a command-line top-level action; it does not permit a `halt/0` call in the submitted source.

## Independent tests

- Keep tests separate from submitted solution files, in the assignment's test area. A test should load or run the target predicates without adding test calls to the solution file.
- Give each test a specific expected behavior and cover ordinary inputs, boundary cases, failure, and backtracking where relevant. For enumerators, check both the set and number of answers; account for duplicates explicitly.
- Run tests independently with SWI-Prolog, for example by loading the solution and issuing a goal with `-g`. Compare actual answers and output with the expected result; do not rely only on a successful load or one successful query.
- Re-run the relevant tests after each change. Keep test output separate from the exact output contract of the submitted program.

## Common AI-generated Prolog failure modes

- Using `=` as arithmetic equality or evaluation. `=/2` unifies terms; use `is/2` to evaluate an arithmetic expression and arithmetic comparison predicates (such as `=:=/2`) to compare evaluated values.
- Recursive clauses that do not reduce the input or constrain a search space, causing unintended infinite recursion or nontermination.
- Incorrect backtracking behavior: a cut or other procedural restriction can suppress valid answers, while a missing constraint can produce invalid ones.
- Duplicate solutions from multiple derivations. Check whether the contract requires unique answers and deduplicate or structure generation accordingly.
- Treating arithmetic expressions as already evaluated numbers, or overlooking evaluation order, integer constraints, division-by-zero, or exact-division requirements.
- Adding unnecessary cuts to make one sample appear to work; cuts can change the relation and prevent valid alternatives.
- Misusing list predicates, especially their argument modes and failure behavior. Check empty lists, improper or unexpected shapes when relevant, and ensure recursion consumes the list correctly.
- Assuming a predicate succeeds exactly once when it may leave choice points or produce multiple answers.

## Self-review checklist

Before presenting any implementation, verify all of the following:

- [ ] The change addresses only the requested unit and matches the stated predicate contract.
- [ ] The code is valid for SWI-Prolog 9.x and imports no disallowed library.
- [ ] The clauses state the intended relation declaratively and recursion terminates for the required inputs.
- [ ] Unification, arithmetic evaluation, and arithmetic comparison are used correctly.
- [ ] Backtracking yields all and only the intended answers, with no unintended duplicates.
- [ ] Lists, empty cases, arithmetic edge cases, and failure cases are handled as required.
- [ ] No unnecessary cuts, side effects, global state, `assert/1`, or `retract/1` were introduced.
- [ ] The source has no initialization directive or `halt/0` call and contains only definitions.
- [ ] Any output is exactly what the assignment requires, and independent tests cover the changed behavior.
