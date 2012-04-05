(cl:in-package :lambda.format.internal)
;; (in-readtable :lambda.format)

(def-suite lambda.format)

(in-suite lambda.format)

#||
(format t "~∧" #\a) ;>>  A ;=>  NIL

(format nil "~{~∧~}" (coerce "foo bar baz" 'list))
;=>  "FOO BAR BAZ"

(format nil "~(~A~)" "foo")

(cl:format nil "~:@(~A~)" 'foo)

(defmethod upcase ((obj string))
  (string-upcase obj))

(defmethod upcase ((obj symbol))
  (string-upcase obj))

(defmethod upcase ((obj character))
  (char-upcase obj))

(defmethod downcase ((obj string))
  (string-downcase obj))

(defmethod downcase ((obj symbol))
  (string-upcase obj))

(defmethod downcase ((obj character))
  (char-downcase obj))

;=>  "A"
;>>  FOO BAR BAZ
;=>  NIL

(format t "~→~←" '(a b c d))

(format nil "a")
;>>  a
;=>  ""
(print-list nil "~A" '(1 2 3 4))
;=>  "1, 2, 3, 4"

#|(loop for i from -18 to 12
      do (format t "~%~14e ~:*~14f ~:*~\\scientific\\" (* 1.2 (^ 10.0 i))))|#
;>>
;>>    .     0.0s+1  1.2000001e-18 1.20 atto
;>>    .     0.0s+1        1.2e-17 12.00 atto
;>>    .     0.0s+1        1.2e-16 120.00 atto
;>>    .     0.0s+1        1.2e-15 1.20 femto
;>>    .     0.0s+1 1.20000005e-14 12.00 femto
;>>    .     0.0s+1        1.2e-13 120.00 femto
;>>    .     0.0s+1  1.2000001e-12 1.20 pico
;>>    .     0.0s+1  1.2000001e-11 12.00 pico
;>>    .     0.0s+1  1.2000001e-10 120.00 pico
;>>   ..00000000s+1         1.2e-9 1.20 nano
;>>   ..00000001s+1         1.2e-8 12.00 nano
;>>   0..0000002s+1   1.2000001e-7 120.00 nano
;>>    .0.000012s+1         1.2e-6 1.20 micro
;>>    . 0.00012s+1         1.2e-5 12.00 micro
;>>    .  0.0012s+1  1.20000004e-4 120.00 micro
;>>    .   .0012s+1         0.0012 1.20 milli
;>>    .   0.012s+1          0.012 12.00 milli
;>>   ..12000000s+1    0.120000005 120.00 milli
;>>    .     1.2s+1            1.2 1.20
;>>    .    12.0s+1           12.0 12.00
;>>    .120.0001s+1      120.00001 120.00
;>>    .  1200.0s+1         1200.0 1.20 kilo
;>>    . 12000.0s+1        12000.0 12.00 kilo
;>>    .10000.01s+2      120000.01 120.00 kilo
;>>    .200000.0s+1      1200000.0 1.20 mega
;>>   1.000000.0s+1          1.2e7 12.00 mega
;>>   2.0000010.s+1    1.2000001e8 120.00 mega
;>>  2.00000000.s+1          1.2e9 1.20 giga
;>>  2.000000000.s+1         1.2e10 12.00 giga
;>>  2.0000000000.s+1         1.2e11 120.00 giga
;>>  2.00000100000.s+1   1.2000001e12 1.20 tera
;=>  NIL
