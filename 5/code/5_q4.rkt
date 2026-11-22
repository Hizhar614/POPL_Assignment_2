#lang racket/base

(provide insert-if-short
         print-insert-result)

(define (my-length lst)
  (let loop ([remaining lst]
             [count 0])
    (cond
      [(null? remaining) count]
      [else (loop (cdr remaining) (+ count 1))])))

(define (my-reverse lst)
  (let loop ([remaining lst]
             [result '()])
    (cond
      [(null? remaining) result]
      [else (loop (cdr remaining)
                  (cons (car remaining) result))])))

(define (my-map fn lst)
  (let loop ([remaining lst]
             [mapped-reversed '()])
    (cond
      [(null? remaining) (my-reverse mapped-reversed)]
      [else
       (loop (cdr remaining)
             (cons (fn (car remaining)) mapped-reversed))])))

(define (make-inserter x len-ok?)
  (letrec ([insert-rec
            (lambda (lst)
              (let* ([original-length (my-length lst)]
                     [processed-elements
                      (my-map (lambda (element)
                                (if (or (null? element) (pair? element))
                                    (insert-rec element)
                                    element))
                              lst)])
                (if (len-ok? original-length)
                    (cons x processed-elements)
                    processed-elements)))])
    insert-rec))

(define (insert-if-short x lst n)
  ((make-inserter x (lambda (len) (< len n))) lst))

(define (print-insert-result)
  (let* ([x (read)]
         [lst (read)]
         [n (read)])
    (display (insert-if-short x lst n))
    (newline)))
