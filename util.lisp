(cl:in-package :lambda.format.internal)

(defvar xr-special-character-names '())
(defvar kbd-new-table (make-array 1024))

(defun operation-handled-p (&rest args)
  (declare (ignore args))
  nil)

(defun flonum-to-string
       (flonum ignore max-digits fraction-digits &optional drop-leading-zero)
  "Return a string containing the printed representation of FLONUM.
At most MAX-DIGITS are printed if MAX-DIGITS is non-NIL.
If FRACTION-DIGITS is non-NIL, exactly FRACTION-DIGITS
 digits are printed after the decimal point.  This overrides the effect of MAX-DIGITS.
The second value is the number of digits that preceded the decimal point.
DROP-LEADING-ZERO means print .123 rather than 0.123 ."
  (declare (ignore ignore))
  (let ((str (cl:format nil
                        "~V,V,,,F"
                        max-digits
                        fraction-digits
                        flonum )))
    (values (if (and drop-leading-zero
                     (char= #\0 (char str 0)) )
                (subseq str 1)
                str )
            (- (length str)
               (position #\. str)
               1))))

(defun pttbl-decimal-point (readtable)
  (declare (ignore readtable))
  #\.)

(defmethod send ((s stream) &rest args)
  (destructuring-bind (type &rest args)
                      args
    (case type
      (:tyo (princ (car args) s))
      (:string-out
       (destructuring-bind (string &optional (start 0) end)
                           args
         (write-string string s :start start :end end)))
      (:which-operations
       (typecase s
         (string-stream (list :string-out))
         (stream (list :print :read-cursorpos))))
      (:read-cursorpos
       #+sbcl
       (if (sb-impl::ansi-stream-p s)
           (sb-kernel:charpos s)
           (sb-gray:stream-line-column s)))
      (otherwise (error "send: unknown type ~A." type)))))

(defun send-if-handles (&rest args)
  (declare (ignore args))
  nil)

(defun pttbl-minus-sign (readtable)
  (declare (ignore readtable))
  #\-)

(defun float-exponent (flonum)
  #+sbcl (nth-value 1 (sb-impl::scale-exponent flonum)))

(defun scale-flonum (x &aux (short (typep X 'short-float)) tem expt wastoobig)
  (setq expt (truncate (/ (float-exponent x) (log 10s0 2s0))))
  (tagbody
      again
         (if (minusp expt)
             (setq tem (* x (aref powers-of-10f0-table (- expt))))
             (setq tem (/ x (aref powers-of-10f0-table expt))))
         (cond ((and (≤ tem -10s0) (not wastoobig)) (incf expt) (go again))
               ((> tem -1s0)  (decf expt) (setq wastoobig t) (go again))
               (t (return-from scale-flonum (values (- (if short (float tem 0s0) tem))
                                                    expt))))))

;;; eof
