;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :ai.lang.lisp.code.tools.xref
  (:use)
  (:nicknames :xref)
  (:export 
   :list-callers :list-users :list-readers :list-setters :what-files-call
   :who-calls :list-callees :source-file :clear-tables
   :define-pattern-substitution :define-caller-pattern :define-variable-pattern
   :define-caller-pattern-synonyms :clear-patterns :*last-form* :*xref-verbose*
   :*handle-package-forms* :*handle-function-forms* :*handle-macro-forms*
   :*types-to-ignore* :*last-caller-tree* :*default-graphing-mode*
   :*indent-amount* :xref-file :xref-files :write-callers-database-to-file
   :display-database :print-caller-trees :make-caller-tree :print-indented-tree
   :determine-file-dependencies :print-file-dependencies :psgraph-xref))

(defpackage :ai.lang.lisp.code.tools.xref.internal
  (:use :ai.lang.lisp.code.tools.xref :cl :fiveam))

