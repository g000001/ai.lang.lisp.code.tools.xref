;;; Mon Jan 21 15:43:39 1991 by Mark Kantrowitz <mkant@GLINDA.OZ.CS.CMU.EDU>
;;; xref-test.lisp

;;; ****************************************************************
;;; Test Source File for XREF **************************************
;;; ****************************************************************
;;;
;;; This file contains source code to be used to test XREF.
;;;
;;; Evaluating the following commented out code should produce the
;;; listed output.
;;;

(cl:in-package :ai.lang.lisp.code.tools.xref.internal)


(def-suite ai.lang.lisp.code.tools.xref)


(in-suite ai.lang.lisp.code.tools.xref)


(test xref-test
  (is-true (null 
            (not 
             (search "6 forms processed."
                     (with-output-to-string (*standard-output*)
                       (ai.lang.lisp.code.tools.xref:xref-file 
                        (asdf:system-relative-pathname 
                         :ai.lang.lisp.code.tools.xref
                         "test-source.lisp")))))))
  (is (string= (with-output-to-string (*standard-output*)
                 (ai.lang.lisp.code.tools.xref:print-caller-trees))
               "Rooted calling trees:
  TOP-LEVEL
     FROB
        FROB-ITEM
           APPEND-FROBS
     BARF
        FROWZ
           PROCESS-KEYS
           SNARF-ITEM
           PROCESS-KEY
              SYMBOL-NAME-KEY
           NODE-POSITION
     FROWZ
        PROCESS-KEYS
        SNARF-ITEM
        PROCESS-KEY
           SYMBOL-NAME-KEY
        NODE-POSITION"))
  (is (string= (with-output-to-string (*standard-output*)
                 (ai.lang.lisp.code.tools.xref:print-caller-trees :compact t))
               "Rooted calling trees:
  TOP-LEVEL
     FROB
        FROB-ITEM
           APPEND-FROBS
     BARF
        FROWZ
     FROWZ
        PROCESS-KEYS
        SNARF-ITEM
        PROCESS-KEY
           SYMBOL-NAME-KEY
        NODE-POSITION"))
  (is (equal (multiple-value-list (ai.lang.lisp.code.tools.xref:list-callers 'frowz))
             '((BARF TOP-LEVEL) t)))
  (is (equal (multiple-value-list (ai.lang.lisp.code.tools.xref:list-users 'items))
             '(NIL NIL (FROWZ BARF FROB)))))


#|
<cl> (xref:xref-file "xref-test.lisp")
Cross-referencing file XRef/xref-test.lisp.
......
6 forms processed.
<cl> (xref:print-caller-trees)

Rooted calling trees:
  TOP-LEVEL
     FROB
        FROB-ITEM
           APPEND-FROBS
     BARF
        FROWZ
           PROCESS-KEYS
           SNARF-ITEM
           PROCESS-KEY
              SYMBOL-NAME-KEY
           NODE-POSITION
     FROWZ
        PROCESS-KEYS
        SNARF-ITEM
        PROCESS-KEY
           SYMBOL-NAME-KEY
        NODE-POSITION
NIL
<cl> (xref:print-caller-trees :compact t)

Rooted calling trees:
  TOP-LEVEL
     FROB
        FROB-ITEM
           APPEND-FROBS
     BARF
        FROWZ
     FROWZ
        PROCESS-KEYS
        SNARF-ITEM
        PROCESS-KEY
           SYMBOL-NAME-KEY
        NODE-POSITION
NIL
<cl> (xref:list-callers 'frowz)

(BARF TOP-LEVEL)
T
<cl> (xref:list-users 'items)

NIL
NIL
(FROWZ BARF FROB)
|#


;;; *EOF*
