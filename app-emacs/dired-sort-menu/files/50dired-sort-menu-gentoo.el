
;;; dired-sort-menu site-lisp configuration 

(add-to-list 'load-path "@SITELISP@")
(add-hook 'dired-load-hook
	  (lambda () (require 'dired-sort-menu)))
