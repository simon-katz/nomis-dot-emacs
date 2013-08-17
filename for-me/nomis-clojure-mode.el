;;;; Init stuff -- Clojure mode.

(require 'clojure-mode)
(require 'nomis-define-lispy-modes)

(add-hook 'clojure-mode-hook 'nomis-lispy-non-repl-setup)
(add-hook 'clojure-mode-hook 'nomis-clojure-setup)

(define-key clojure-mode-map (kbd "RET") 'newline-and-indent) ; TODO: Modularise with same change to emacs-lisp-mode-map.

;;;; ___________________________________________________________________________

(provide 'nomis-clojure-mode)
