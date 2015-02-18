
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

; Dustin Chang
; Csc330 Assign 4

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

;; 4
;; stream, number --> rtns a list
(define (stream-for-n-steps s n)
  (if (= n 0) ;or equal?
      '()
      (let ([stm (s)])
        (cons (car stm) (stream-for-n-steps (cdr stm) (- n 1))))))

;; 5
;; Creating a stream, negative mod's of 5
(define funny-number-stream
  (letrec ([f (lambda (x) (cons (if (equal? (remainder x 5) 0) (- x) x) (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

;; 6
;; Creates a stream starting with cat.jpg that alternates cat-dog-cat...
(define cat-then-dog
  (letrec ([f (lambda (x) (cons (if (equal? (remainder x 2) 0) "dog.jpg" "cat.jpg") (lambda () (f (+ x 1)))))])
    (lambda () (f 1))))

;; 7
;; Takes a stream --> rtns a stream; produces a pair (0.v) for it's i-th element
(define (stream-add-zero s)
  (lambda () (cons (cons 0 (car (s))) (stream-add-zero (cdr (s))))))

;; 8
;; Takes 2 lists --> rtns a stream
(define (cycle-lists xs ys)
  (letrec ([f (lambda (n) (cons (cons (list-nth-mod xs n) (list-nth-mod ys n)) (lambda () (f (+ n 1)))))])
    (lambda () (f 0))))

