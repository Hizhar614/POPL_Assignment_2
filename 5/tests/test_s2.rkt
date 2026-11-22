#lang racket/base

(require rackunit
         "../code/5_q4.rkt")

(test-case "official example: nested numbers and empty list"
  (check-equal? (insert-if-short 42 '((1 2) (3 4 5) (6) ()) 3)
                '((42 1 2) (3 4 5) (42 6) (42))))

(test-case "official example: nested lists at multiple levels"
  (check-equal? (insert-if-short 0 '(((1) 2) (3) ((4 5 6) ())) 3)
                '((0 (0 1) 2) (0 3) (0 (4 5 6) (0)))))

(test-case "official example: empty top-level list with positive threshold"
  (check-equal? (insert-if-short 7 '() 3)
                '(7)))

(test-case "official example: empty top-level list with zero threshold"
  (check-equal? (insert-if-short 7 '() 0)
                '()))

(test-case "list length equal to threshold is unchanged"
  (check-equal? (insert-if-short 'x '(a b) 2)
                '(a b)))

(test-case "list shorter than threshold receives inserted element"
  (check-equal? (insert-if-short 'x '(a) 2)
                '(x a)))

(test-case "nested empty lists are each treated as lists"
  (check-equal? (insert-if-short 'x '(() ()) 2)
                '((x) (x))))

(test-case "a list containing only atoms"
  (check-equal? (insert-if-short 'x '(a b c) 4)
                '(x a b c)))

(test-case "insertion recurses through multiple nesting levels"
  (check-equal? (insert-if-short 'x '((a (b)) ((c))) 3)
                '(x (x a (x b)) (x (x c)))))
