#lang racket

(require racket/contract)
(provide wallpaper-f)

#|
This is a Racket implementation of the bytefiller code.
It seems fast enough compared the the C code. It's definitely
easier to maintain and share.

|#

(define/contract (wallpaper-f pixbuf
                              width height
                              cx cy
                              scale
                              ncolors
                              xcolors)
  (-> bytes?
      integer? integer? integer? integer?
      real? integer? (listof integer?)
      void?)
  #;(define pixbuf (make-bytes (* 4 width height)))
  (define colors (list->vector xcolors))
  (for* [(x (in-range width))
         (y (in-range height))]
    (define i (+ cx (* x scale)))
    (define j (+ cy (* y scale)))
    (define c (exact-floor (+ (sqr i)
                              (sqr j))))
    (define k (* 4 (+ x (* width y))))
    (integer->integer-bytes (vector-ref colors (modulo c ncolors))
                            4
                            false
                            false
                            pixbuf
                            k)))

(define (inner-loop width height cx cy scale ncolors colors x y)
  (define i (+ cx (* x scale)))
  (define j (+ cy (* y scale)))
  (define c (floor (+ (sqr i)
                      (sqr j))))
  (define k (* 4 (+ x (* width y))))
  (integer->integer-bytes (vector-ref colors (modulo k ncolors))
                          4
                          false
                          false))
(module+ test
  (inner-loop 300 200 50 50 (/ 25.0 200.0) 2
              (vector #xff2255ff #xffff7700)
              0 0))


