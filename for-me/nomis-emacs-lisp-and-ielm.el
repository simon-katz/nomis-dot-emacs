;;;; Init stuff -- emacs-lisp and ielm.

;;;; ___________________________________________________________________________

(require 'nomis-lispy-mode-hooks)

(add-hook 'emacs-lisp-mode-hook 'nomis-emacs-lisp-setup)
(add-hook 'ielm-mode-hook 'nomis-ielm-setup)

(define-key emacs-lisp-mode-map (kbd "RET") 'newline-and-indent) ; TODO: Modularise with same change to clojure-mode-map, and see comment there

;;;; ___________________________________________________________________________

(provide 'nomis-emacs-lisp-and-ielm)
