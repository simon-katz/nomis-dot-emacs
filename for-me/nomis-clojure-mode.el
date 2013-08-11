;;;; Init stuff -- Clojure mode.

;; (eval-after-load 'clojure-mode
;;   ;; Get rid of displaying (fn ...) as italic-y f (f ...),
;;   ;; which is set up in ".../.emacs.d/starter-kit-lisp.el" using a
;;   ;; form like this but with font-lock-add-keywords instead of
;;   ;; font-lock-remove-keywords
;;   '(font-lock-remove-keywords
;;     'clojure-mode `(("(\\(fn\\>\\)"
;;                      (0 (progn (compose-region (match-beginning 1)
;;                                                (match-end 1) "ƒ")
;;                                nil))))))

(progn
  ;; Get rid of displaying (fn ...) as italic-y f (f ...)
  (remove-hook 'clojure-mode-hook 'esk-pretty-fn))

(add-hook 'clojure-mode-hook 'subword-mode)
(add-hook 'clojure-mode-hook 'generic-lispy-stuff)

;;;; ___________________________________________________________________________

(provide 'nomis-clojure-mode)