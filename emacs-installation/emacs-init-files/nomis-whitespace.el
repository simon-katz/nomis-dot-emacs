;;;; Init stuff -- whitespace

(require 'whitespace)
(require 'nomis-right-margin-column)

(setq whitespace-line-column nomis/right-margin-column)

(setq whitespace-style '(face trailing lines-tail tabs))

(defun nomis/whitespace-faces ()
  ;; Less-garish-than-default highlighting for > 80 (or whatever)
  ;; characters.
  (set-face-attribute 'whitespace-line nil
                      :background "pink"
                      :foreground 'unspecified)
  (set-face-attribute 'whitespace-trailing nil
                      :box (list :line-width -10
                                 :color "hotpink"
                                 :style nil)))

(progn
  ;; For some reason my whitespace face definitions get blatted, even
  ;; if this file is the last thing that gets loaded by my init.
  (defadvice whitespace-mode (after nomis/whitespace-faces (&rest args))
    (nomis/whitespace-faces))
  (ad-activate 'whitespace-mode))

(provide 'nomis-whitespace)
