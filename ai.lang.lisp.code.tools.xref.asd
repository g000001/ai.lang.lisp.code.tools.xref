;;;; ai.lang.lisp.code.tools.xref.asd -*- Mode: Lisp;-*- 

(cl:in-package :asdf)

(defsystem :ai.lang.lisp.code.tools.xref
  :serial t
  :depends-on (:fiveam)
  :components ((:file "package")
               (:file "ai.lang.lisp.code.tools.xref")
               (:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system :ai.lang.lisp.code.tools.xref))))
  (load-system :ai.lang.lisp.code.tools.xref)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :ai.lang.lisp.code.tools.xref.internal :ai.lang.lisp.code.tools.xref))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

