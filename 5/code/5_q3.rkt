#lang racket/base

(provide print-inorder
         print-all-traversals
         print-height-and-leaves)

(define (my-append first-list second-list)
  (cond
    [(null? first-list) second-list]
    [else
     (cons (car first-list)
           (my-append (cdr first-list) second-list))]))

(define (inorder-values tree)
  (cond
    [(null? tree) '()]
    [else
     (let* ([left-values (inorder-values (cadr tree))]
            [right-values (inorder-values (caddr tree))])
       (my-append left-values
                  (cons (car tree) right-values)))]))

(define (print-inorder tree)
  (display (inorder-values tree))
  (newline))

(define (preorder-values tree)
  (cond
    [(null? tree) '()]
    [else
     (cons (car tree)
           (my-append (preorder-values (cadr tree))
                      (preorder-values (caddr tree))))]))

(define (postorder-values tree)
  (cond
    [(null? tree) '()]
    [else
     (my-append (postorder-values (cadr tree))
                (my-append (postorder-values (caddr tree))
                           (list (car tree))))]))

(define (print-all-traversals tree)
  (display (inorder-values tree))
  (newline)
  (display (preorder-values tree))
  (newline)
  (display (postorder-values tree))
  (newline))

(define (height-and-leaves tree)
  (cond
    [(null? tree) (list 0 0)]
    [else
     (let* ([left-tree (cadr tree)]
            [right-tree (caddr tree)])
       (if (and (null? left-tree) (null? right-tree))
           (list 1 1)
           (let* ([left-result (height-and-leaves left-tree)]
                  [right-result (height-and-leaves right-tree)])
             (list (+ 1 (max (car left-result) (car right-result)))
                   (+ (cadr left-result) (cadr right-result))))))]))

(define (print-height-and-leaves tree)
  (display (height-and-leaves tree))
  (newline))
