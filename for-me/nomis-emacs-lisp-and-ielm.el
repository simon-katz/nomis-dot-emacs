;;;; Init stuff -- emacs-lisp and ielm.

;;;; ___________________________________________________________________________

(dolist (hook '(emacs-lisp-mode-hook ielm-mode-hook))
  (add-hook hook 'turn-on-elisp-slime-nav-mode)
  (add-hook hook 'turn-on-eldoc-mode))

(dolist (hook '(emacs-lisp-mode-hook))
  (add-hook hook 'generic-lispy-stuff-for-non-repls))

(dolist (hook '(ielm-mode-hook))
  (add-hook hook 'generic-lispy-stuff-for-repls))

(define-key emacs-lisp-mode-map (kbd "RET") 'newline-and-indent) ; TODO: Modularise with same change to clojure-mode-map, and see comment there

;;;; ___________________________________________________________________________

(provide 'nomis-emacs-lisp-and-ielm)