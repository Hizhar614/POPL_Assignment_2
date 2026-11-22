#lang racket/base

(require rackunit
         racket/port
         "../code/5_q3.rkt")

(define (capture-output thunk)
  (let ([output-port (open-output-string)])
    (parameterize ([current-output-port output-port])
      (thunk))
    (get-output-string output-port)))

(define t1
  '(4 (2 (1 () ()) (3 () ()))
      (6 (5 () ()) (7 () ()))))

(define t2
  '(1 () (2 () (3 () ()))))

(define t3
  '(a (b () ()) (c () ())))

(test-case "seven-node balanced tree: inorder"
  (check-equal? (capture-output (lambda () (print-inorder t1)))
                "(1 2 3 4 5 6 7)\n"))

(test-case "seven-node balanced tree: all traversals"
  (check-equal? (capture-output (lambda () (print-all-traversals t1)))
                "(1 2 3 4 5 6 7)\n(4 2 1 3 6 5 7)\n(1 3 2 5 7 6 4)\n"))

(test-case "seven-node balanced tree: height and leaves"
  (check-equal? (capture-output (lambda () (print-height-and-leaves t1)))
                "(3 4)\n"))

(test-case "right-skewed tree: inorder"
  (check-equal? (capture-output (lambda () (print-inorder t2)))
                "(1 2 3)\n"))

(test-case "right-skewed tree: all traversals"
  (check-equal? (capture-output (lambda () (print-all-traversals t2)))
                "(1 2 3)\n(1 2 3)\n(3 2 1)\n"))

(test-case "right-skewed tree: height and leaves"
  (check-equal? (capture-output (lambda () (print-height-and-leaves t2)))
                "(3 1)\n"))

(test-case "three-node symbolic tree: inorder"
  (check-equal? (capture-output (lambda () (print-inorder t3)))
                "(b a c)\n"))

(test-case "three-node symbolic tree: all traversals"
  (check-equal? (capture-output (lambda () (print-all-traversals t3)))
                "(b a c)\n(a b c)\n(b c a)\n"))

(test-case "three-node symbolic tree: height and leaves"
  (check-equal? (capture-output (lambda () (print-height-and-leaves t3)))
                "(2 2)\n"))

(test-case "empty tree: inorder"
  (check-equal? (capture-output (lambda () (print-inorder '())))
                "()\n"))

(test-case "empty tree: all traversals"
  (check-equal? (capture-output (lambda () (print-all-traversals '())))
                "()\n()\n()\n"))

(test-case "empty tree: height and leaves"
  (check-equal? (capture-output (lambda () (print-height-and-leaves '())))
                "(0 0)\n"))
