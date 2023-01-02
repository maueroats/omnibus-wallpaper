#lang racket

(require racket/gui)
(require racket/gui/easy)
(require racket/gui/easy/operator)
(require "omnibus-wallpaper.rkt")

(define (slider-f n zoom-factor)
  (/ n zoom-factor))

(define @scale (obs 171 #:name '@scale))
(define @zoom (obs 10 #:name '@zoom))
(define @corner-x (obs 490 #:name 'x))
(define @corner-y (obs 151 #:name 'y))

(struct model (x y scale zoom) #:transparent)

(define @model (obs-combine model @corner-x @corner-y @scale @zoom))

(define (corner-f v)
  (exact-round (* 0.1 v)))

(define one-slider
  (slider @scale (λ:= @scale)
          #:min-value 1
          #:max-value 500))

(define (handle-zoom magnify?)
  (if magnify?
      (:= @zoom 2000)
      (:= @zoom 10)))

(define slide-x (slider @corner-x (λ:= @corner-x) #:min-value 0 #:max-value 1000))
(define slide-y (slider @corner-y (λ:= @corner-y) #:min-value 0 #:max-value 1000))
(define magnify (checkbox handle-zoom #:label "zoom" #:enabled? #t))

(define (one-rendering @model width height)
  (define ans
    (wallpaper-image width height
                     (corner-f (model-x @model))
                     (corner-f (model-y @model))
                     (slider-f (model-scale @model)
                               (model-zoom @model))
                     (list "black" "white")))
  (make-object image-snip% ans))

(define my-view (snip-canvas @model one-rendering))
  
(render
 (window (vpanel (hpanel #:stretch '(#t #f)
                         (vpanel (text "x") slide-x)
                         (vpanel (text "y") slide-y)
                         magnify
                         one-slider)
                 my-view)))

