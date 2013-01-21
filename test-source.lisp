;;; ********************************
;;; Test Source Program ************
;;; ********************************

(defun top-level () 
  "Top level function with null lambda list."
  (let* ((input (read))
	 (key (car input)))
    (declare (special key))
    (case key
      (quit
       (return (values (frob (rest input)) 'quit)))
      (otherwise
       (cond ((member key '(foo bar baz))
	      (barf key (rest input)))
	     (t
	      (frowz (rest input) :key key)))))))

(defun frob (items)
  "Here we test mapcar."
  (mapcar #'frob-item items))
(defun frob-item (item)
  "Here we test apply."
  (apply #'append-frobs item))
(defun barf (key &optional items)
  "Optional args test."
  (cons key (frowz items)))
(defun frowz (items &key key)
  "Keyword args test."
  (dolist (item items)
    (let ((frowz (if (eq key 'quit)
		     (intern (format nil "FOO~A" 
				     (round (+ (length (process-keys items))
					       10))) 'keyword)
		     (snarf-item item))))
      (when (string-equal frowz (process-key key))
	(setf (node-position key) 12)
	(return frowz)))))
(defun process-key (key)
  (funcall #'symbol-name-key key))
