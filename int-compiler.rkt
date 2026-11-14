#lang scheme

#|
;; for printing the assembly in the output

(define (compile-program x)
  (emit "movl $~a, %eax" x)
  (emit "ret"))

|#

(define (emit fmt . args)
  (display (apply format fmt args))
  (newline))

(define (compile-program x)
  (emit ".text")
  (emit ".globl scheme_entry")
  (emit "scheme_entry:")
  (emit "movl $~a, %eax" x)
  (emit "ret"))

(with-output-to-file "output.s"
  (lambda ()
    (compile-program 1729))
  #:exists 'replace)