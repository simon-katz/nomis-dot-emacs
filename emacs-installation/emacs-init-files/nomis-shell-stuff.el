;;;; Init stuff -- Shell stuff.


(add-hook 'sh-mode-hook 'flycheck-mode)


(defun shell-region (start end)
  ;; Copied from http://stackoverflow.com/questions/6286579/emacs-shell-mode-how-to-send-region-to-shell.
  "Execute contents of region in an inferior shell."
  (interactive "r")
  (shell-command (buffer-substring-no-properties start end)))

;;;; ___________________________________________________________________________

(provide 'nomis-shell-stuff)
