#lang racket

(require racket/draw) ;; for color%
(require (only-in ffi/unsafe
                  get-ffi-obj
                  ffi-lib)

         ;; renamed the arrow from ffi so I can also use the arrow from contracts
         (rename-in ffi/unsafe
                    [-> -->]))
(require ffi/cvector)

(provide wallpaper-f)

;; NOTE: Setting #:custodian (current-custodian) causes the library
;; to be reloaded every time the file is run. Important if you're
;; recompiling the library.
(define omnibus-lib (ffi-lib "libomnibus-0.1"
                             #:custodian (current-custodian)))

(define wallpaper-f*
  (get-ffi-obj "wallpaper" omnibus-lib
               (_fun _bytes
                     _int _int _int _int _double
                     _int
                     _cvector
                     --> _void)))



;;
;;
;;

(define/contract (wallpaper-f pixbuf
                              width height
                              cx cy
                              scale
                              ncolors
                              the-colors)
  (-> bytes?
      integer? integer? integer? integer?
      real? integer? (listof integer?)
      void?)
  
  (define c-colors
    (list->cvector the-colors
                   _uint32))
  (wallpaper-f* pixbuf
                width height
                cx cy
                scale
                ncolors
                c-colors))
