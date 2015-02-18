
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

;; 1
(define (sequence low high stride)
  (if (<= low high)
      (cons low (sequence (+ low stride) high stride))
      '()))

;; 2
(define (string-append-map xs suffix)
  (map (lambda (x) (string-append x suffix)) xs))

;; 3
(define (list-nth-mod xs n)
  (cond [(< n 0) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (let ([r (remainder n (length xs))]) (car (list-tail xs r)))]))
              



;
;         (list-nth-mod (list-tail xs 1) (- n 1))]))
;
;(define (list-nth-mod xs n) 
;  (cond [(< n 0) (error "list-nth-mod: negative number")]
;        [(null? xs) (error "list-nth-mod: empty list")]
;        [#t (let ([rem (remainder n (length xs))]) (car (list-tail xs rem)))]))