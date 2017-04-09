;;;; Init stuff -- Clojure mode.

;;;; ___________________________________________________________________________
;;;; Misc

(require 'clojure-mode)

(progn
  (require 'cider)
  (unless (featurep 'cider-macroexpansion)
    ;; Needed in:
    ;; - 0.8.2
    ;; - 0.9.0-snapshot (2015-02-23)
    ;; Maybe a bug.
    (require 'cider-macroexpansion)))

(require 'cider-grimoire)

(require 'nomis-clojure-indentation)
(require 'nomis-cider-extras)

(require 'align-cljlet)

(define-key clojure-mode-map (kbd "RET") 'newline-and-indent)

;;;; ___________________________________________________________________________
;;;; clj-refactor

(require 'clj-refactor)

(defun nomis-setup-clj-refactor-mode ()
  (clj-refactor-mode 1)
  (cljr-add-keybindings-with-prefix "M-R"))

(add-hook 'clojure-mode-hook (lambda () (yas/minor-mode 1)))

;;;; ___________________________________________________________________________
;;;; Cider
;;;; See https://github.com/clojure-emacs/cider.

(setq nrepl-buffer-name-separator "--")

;; (setq nrepl-buffer-name-show-port t)

(setq cider-repl-display-in-current-window t)
(setq cider-repl-pop-to-buffer-on-connect nil)

(setq cider-repl-history-file "~/.cider-repl-history")
(setq cider-repl-history-size 5000) ; the default is 500

(setq cider-repl-use-clojure-font-lock t)

(setq cider-eval-result-prefix ";; => ")

;; (setq cider-font-lock-dynamically t)

(when (equal (cider-version) "CIDER 0.10.0")
  ;; Fix curly braces bug.
  (add-hook 'cider-repl-mode-hook
            '(lambda ()
               (define-key cider-repl-mode-map "{" #'paredit-open-curly)
               (define-key cider-repl-mode-map "}" #'paredit-close-curly))))

;;;; ___________________________________________________________________________
;;;; Hooks

(defun nomis-set-comment-column-to-zero ()
  (set (make-local-variable 'comment-column)
       0))

(let ((hook-funs-when-repl-exists `(eldoc-mode))
      (hook-funs-always `(rainbow-delimiters-mode
                          paredit-mode
                          nomis-set-comment-column-to-zero
                          subword-mode
                          nomis-setup-clj-refactor-mode))
      (hooks-when-repl-exists '(cider-mode-hook
                                cider-repl-mode-hook))
      (hooks-always '(clojure-mode-hook
                      cider-repl-mode-hook)))
  (labels ((add-hook** (hooks functions)
                       (dolist (h hooks)
                         (dolist (f functions)
                           (add-hook h f)))))
    (add-hook** hooks-when-repl-exists
                hook-funs-when-repl-exists)
    (add-hook** hooks-always
                hook-funs-always)))

;;;; ___________________________________________________________________________
;;;; cider-eval-sexp-fu

(require 'cider-eval-sexp-fu)

(setq eval-sexp-fu-flash-duration 0.5)
(setq eval-sexp-fu-flash-error-duration 0.5)

;;;; ___________________________________________________________________________

(when (equal system-type 'windows-nt)
  (setq nrepl-sync-request-timeout 30))

;;;; ___________________________________________________________________________
;;;; cljs

(setq cider-cljs-lein-repl
      "(do (use 'figwheel-sidecar.repl-api) (start-figwheel!) (cljs-repl))")

;;;; ___________________________________________________________________________

(provide 'nomis-clojure)
