;;;; lambda.format.asd -*- Mode: Lisp;-*-

(cl:in-package :asdf)

(defsystem :lambda.format
  :serial t
  :depends-on (:fiveam
               :zl-compat)
  :components ((:file "package")
               (:file "util")
               (:file "lambda.format")))

(defmethod perform ((o test-op) (c (eql (find-system :lambda.format))))
  (load-system :lambda.format)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :lambda.format.internal :lambda.format))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))
