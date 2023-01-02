#lang racket
(require racket/draw)
(provide color->int)
;; color-to-int returns an ARGB value
;; the number is in LSB order 
;; reading the number it looks like BBGGRRAA

(define (color->int c)
  (if (number? c)
      c
      (local [(define rc (make-object color% c))]
        (bitwise-ior (arithmetic-shift #x0ff 0)
                     (arithmetic-shift (send rc red) 8)
                     (arithmetic-shift (send rc green) 16)
                     (arithmetic-shift (send rc blue) 24)))))

