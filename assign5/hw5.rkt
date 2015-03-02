;; Programming Languages, Homework 5 version 1.1
#lang racket


(provide (all-defined-out)) ;; so we can put tests in a second file

;; definition of structures for MUPL programs - Do NOT change
(struct var  (string) #:transparent)  ;; a variable, e.g., (var "foo")
(struct int  (num)    #:transparent)  ;; a constant number, e.g., (int 17)
(struct add  (e1 e2)  #:transparent)  ;; add two expressions
(struct ifgreater (e1 e2 e3 e4)    #:transparent) ;; if e1 > e2 then e3 else e4
(struct fun  (nameopt formal body) #:transparent) ;; a recursive(?) 1-argument function
(struct call (funexp actual)       #:transparent) ;; function call
(struct mlet (var e body) #:transparent) ;; a local binding (let var = e in body)
(struct apair (e1 e2)     #:transparent) ;; make a new pair
(struct fst  (e)    #:transparent) ;; get first part of a pair
(struct snd  (e)    #:transparent) ;; get second part of a pair
(struct aunit ()    #:transparent) ;; unit value -- good for ending a list
(struct isaunit (e) #:transparent) ;; evaluate to 1 if e is unit else 0

;; a closure is not in "source" programs; it is what functions evaluate to
(struct closure (env fun) #:transparent)

;; Problem A

;; CHANGE (put your solutions here)
(define (mupllist->racketlist lst)
  (cond [(aunit? lst) null]
        [(apair? (apair-e1 lst)) (cons (mupllist->racketlist (apair-e1 lst)) (mupllist->racketlist (apair-e2 list)))]
        [#t (cons (apair-e1 lst) (mupllist->racketlist (apair-e2 lst)))]))

(define (racketlist->mupllist lst)
  (cond [(null? lst) (aunit)]
        [(list? (car lst)) (apair (racketlist->mupllist (car lst)) (racketlist->mupllist (cdr lst)))]
        [#t (apair (car lst) (racketlist->mupllist (cdr lst)))]))

;; Problem B

;; lookup a variable in an environment
;; Do NOT change this function
(define (envlookup env str)
  (cond [(null? env) (error "unbound variable during evaluation" str)]
        [(equal? (car (car env)) str) (cdr (car env))]
        [#t (envlookup (cdr env) str)]))

;; Do NOT change the two cases given to you.
;; DO add more cases for other kinds of MUPL expressions.
;; We will test eval-under-env by calling it directly even though
;; "in real life" it would be a helper function of eval-exp.
(define (eval-under-env e env)
  (cond [(var? e)
         (envlookup env (var-string e))]
        [(add? e)
         (let ([v1 (eval-under-env (add-e1 e) env)]
               [v2 (eval-under-env (add-e2 e) env)])
           (if (and (int? v1)
                    (int? v2))
               (int (+ (int-num v1)
                       (int-num v2)))
               (error "MUPL addition applied to non-number")))]
        ;; "CHANGE" add more cases here

        [(ifgreater? e)
         (let ([v1 (eval-under-env (ifgreater-e1 e) env)]
               [v2 (eval-under-env (ifgreater-e2 e) env)])
           (if (and (int? v1) (int? v2))
               (if (> (int-num v1) (int-num v2))
                   (eval-under-env (ifgreater-e3 e) env)
                   (eval-under-env (ifgreater-e4 e) env)
               )
               (error "MUPL ifgreater applied to non-number")))]
        [(int? e) e]
        ;[(mlet? e)
         ;(letrec ([v (eval-under-env (mlet-e e) env)] ;letrec needed for, v in line below
          ;     [env2 (cons (cons (mlet-var e) v) env)])
         ;(eval-under-env (mlet-body e) env2))]
        [(mlet? e)
         (let ([v (eval-under-env (mlet-e e) env)])
           (eval-under-env(mlet-body e) (cons (cons (mlet-var e) v) env)))]

;        [(call? e)
;         (letrec ([closur (eval-under-env (call-funexp e) env)]
;                  [actul (eval-under-env (call-actual e) env)]
;                  [funbody (fun-body (closure-fun closur))]
;                  [funform (fun-formal (closure-fun closur))])
;           (if (closure? closur)
;               (eval-under-env (fun-body (closure-fun closur))
;                               (cons (cons funform actul)
;                                     (closure-env closur)))
;               (error "MUPL can't call a function that isn't a closure")))]
        [(call? e)
         (let ([v1 (eval-under-env (call-funexp e) env)]
               [v2 (eval-under-env (call-actual e) env)])
           (if (closure? v1)
               (let* ([c1 (closure-fun v1)]
                      [c2 (closure-env v1)]
                      [cn (cons (fun-nameopt c1) v1)]
                      [cf (cons (fun-formal c1) v2)])
                 (eval-under-env
                  (fun-body c1)
                  (if (eq? (car cn) #f)
                      (cons cf c2)
                      (cons cf (cons cn c2)))))
               (error "MUPL call applied to non-closure")))]
        [(fun? e) (closure env e)]
        [(closure? e) e]
        [(apair? e)
         (let ([v1 (eval-under-env (apair-e1 e) env)]
               [v2 (eval-under-env (apair-e2 e) env)])
           (apair v1 v2))]
        [(fst? e)
         (let ([v (eval-under-env (fst-e e) env)])
           (if (apair? v) (apair-e1 v) (begin (print v) (error "Can only call fst on a pair"))))]
        [(snd? e)
         (let ([v (eval-under-env (snd-e e) env)])
           (if (apair? v) (apair-e2 v) (error "Can only call snd on a pair")))]
        [(isaunit? e)
          (if (aunit? (eval-under-env (isaunit-e e) env))
              (int 1)
              (int 0))]
        [(aunit? e) e]
        [#t (error (format "bad MUPL expression: ~v" e))]))

;; Do NOT change
(define (eval-exp e)
  (eval-under-env e null))

;; Problem C

(define (ifaunit e1 e2 e3)
  (ifgreater (isaunit e1) (int 0) e2 e3))

(define (mlet* lstlst e2)
  (if (null? lstlst)
      e2
      (mlet
       (car (car lstlst))
       (cdr (car lstlst))
       (mlet* (cdr lstlst) e2))))

(define (ifeq e1 e2 e3 e4)
  (mlet* (list (cons "_x" e1) (cons "_y" e2))
         (ifgreater (var "_x") (var "_y") e4
                    (ifgreater (var "_y") (var "_x") e4 e3))))

;; Problem D

(define mupl-map "CHANGE")

(define mupl-mapAddN
  (mlet "map" mupl-map
        "CHANGE (notice map is now in MUPL scope)"))
