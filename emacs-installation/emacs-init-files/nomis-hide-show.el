;;;; Init stuff -- nomis-hide-show

;;;; ___________________________________________________________________________

(defun nomis-hs-hide-all ()
  (interactive)
  (hs-minor-mode 1)
  (hs-hide-all))

(defun nomis-hs-show-all ()
  (interactive)
  (hs-minor-mode 1)
  (hs-show-all))

(defun nomis-hs-hide-block ()
  (interactive)
  (hs-minor-mode 1)
  (hs-hide-block)
  (backward-char))

(defun nomis-hs-show-block ()
  (interactive)
  (hs-minor-mode 1)
  (hs-show-block)
  (backward-char))

(defun nomis-hs-toggle-hiding ()
  (interactive)
  (hs-minor-mode 1)
  (hs-toggle-hiding)
  (backward-char))

(define-key global-map (kbd "H-q H-[") 'nomis-hs-hide-all)
(define-key global-map (kbd "H-q H-]") 'nomis-hs-show-all)
(define-key global-map (kbd "H-q H-;") 'nomis-hs-hide-block)
(define-key global-map (kbd "H-q H-'") 'nomis-hs-show-block)
(define-key global-map (kbd "H-q H-/") 'nomis-hs-toggle-hiding)

(key-chord-define-global "q[" 'nomis-hs-hide-all)
(key-chord-define-global "q]" 'nomis-hs-show-all)
(key-chord-define-global "q;" 'nomis-hs-hide-block)
(key-chord-define-global "q'" 'nomis-hs-show-block)
(key-chord-define-global "q/" 'nomis-hs-toggle-hiding)

(defun nomis-display-hs-hidden-stuff (ov)
  (when (eq 'code (overlay-get ov 'hs))
    (overlay-put ov 'help-echo
                 (buffer-substring (overlay-start ov)
                                   (overlay-end ov)))
    (overlay-put ov 'display
                 (propertize (format "......... / %d"
                                     (count-lines (overlay-start ov)
                                                  (overlay-end ov)))
                             'face 'font-lock-type-face))))

(setq hs-set-up-overlay 'nomis-display-hs-hidden-stuff)

(defadvice goto-line (after expand-after-goto-line
                            activate compile)
  "hideshow-expand affected block when using goto-line in a collapsed buffer"
  (save-excursion
    (hs-show-block)))

;;;; ___________________________________________________________________________
;;;; nomis/hs-adjust

(defvar nomis/hs-adjust/level)

(defun nomis/hs-adjust/set-level (n)
  (interactive "p")
  (setq nomis/hs-adjust/level n)
  (if (zerop n)
      (nomis-hs-hide-block)
    (hs-hide-level nomis/hs-adjust/level)))

(defun nomis/hs-adjust/inc-level (n)
  (setq nomis/hs-adjust/level (max 0
                                   (+ nomis/hs-adjust/level n)))
  (nomis/hs-adjust/set-level nomis/hs-adjust/level))

(defun nomis/hs-adjust/init ()
  (interactive)
  (hs-minor-mode 1)
  (nomis/hs-adjust/set-level 0))

(defun nomis/hs-adjust/less (n)
  (interactive "p")
  (nomis/hs-adjust/inc-level (- n)))

(defun nomis/hs-adjust/more (n)
  (interactive "p")
  (nomis/hs-adjust/inc-level n))

(defun nomis/hs-adjust/set-0 ()
  (interactive)
  (nomis/hs-adjust/set-level 0))

(defun nomis/hs-adjust/set-0/exiting ()
  ;; This exists to overcome a bug in Hydra when you have both
  ;;     :exit t
  ;; and
  ;;     :exit nil
  ;; for the same function.
  (interactive)
  (nomis/hs-adjust/set-0))

(defun nomis/hs-adjust/show-all ()
  (interactive)
  ;; This exists to overcome a bug when showing all when level shown is 1,
  ;; whereby the cursor moved weirdly and fucked things up.
  (nomis-hs-hide-block)
  (nomis-hs-show-block))

(defun nomis/hs-adjust/show-all/exiting ()
  ;; This exists to overcome a bug in Hydra when you have both
  ;;     :exit t
  ;; and
  ;;     :exit nil
  ;; for the same function.
  (interactive)
  (nomis/hs-adjust/show-all))

(require 'nomis-hydra)

(define-nomis-hydra nomis/hs-adjust
  :name-as-string "Hide-show incremental"
  :key "H-q H-q"
  :init-form   (nomis/hs-adjust/init)
  :hydra-heads
  (("["         nomis/hs-adjust/set-0/exiting "Min and exit" :exit t)
   (";"         nomis/hs-adjust/set-0/exiting "Min and exit" :exit t)
   ("<S-left>"  nomis/hs-adjust/set-0     "Min")
   ("_"         nomis/hs-adjust/set-0     "Min")
   ("-"         nomis/hs-adjust/less      "Less")
   ("<left>"    nomis/hs-adjust/less      "Less")
   ("l"         nomis/hs-adjust/set-level "Choose")
   ("="         nomis/hs-adjust/more      "More")
   ("<right>"   nomis/hs-adjust/more      "More")
   ("<S-right>" nomis/hs-adjust/show-all  "All")
   ("+"         nomis/hs-adjust/show-all  "All")
   ("'"         nomis/hs-adjust/show-all/exiting "All and exit" :exit t)
   ("]"         nomis/hs-adjust/show-all/exiting "All and exit" :exit t)))

(provide 'nomis-hide-show)
