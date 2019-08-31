;;;; nomis-org-key-bindings  ---  -*- lexical-binding: t -*-

;;;; ___________________________________________________________________________
;;;; ____ * General

;;; The following lines are always needed. Choose your own keys.

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))

(add-hook 'org-mode-hook 'turn-on-font-lock) ; not needed when global-font-lock-mode is on

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(org-defkey global-map "\C-cc" 'org-capture)

;;;; ___________________________________________________________________________
;;;; ____ * Hooks

(add-hook 'org-mode-hook 'nomis/turn-on-idle-highlight-mode)

;;;; ___________________________________________________________________________
;;;; ____ * Navigation and cycling

;;;; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;;;; ____ ** The design of some of these key chords

(defconst -nomis/org/navigation-and-cycling-help
  "
Use H with various other keys:
    ,. is for moving forward or backward headlines (without M, at same level)
        <> (add S to ,. on my keyboard) to cross the parent level
        Add C to step (ie collapse then move then expand)
        Add M to visit headlines at any level
    '\\[]-= is for expanding and collapsing
        Add M to fully expand or collapse
        Add C to '\\ for visibility cycling of spans")

(defun nomis/org/pop-up-navigation-and-cycling-help ()
  (interactive)
  (case 2
    (1 (let* ((*nomis/popup/message/auto-dismiss?* nil))
         (nomis/popup/message "%s" -nomis/org/navigation-and-cycling-help)))
    (2 (with-help-window (help-buffer)
         (princ -nomis/org/navigation-and-cycling-help)))))

(org-defkey org-mode-map (kbd "C-H-M-?") 'nomis/org/pop-up-navigation-and-cycling-help)

;;;; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;;;; ____ ** Following links

(org-defkey org-mode-map (kbd "M-.") 'org-open-at-point)
(org-defkey org-mode-map (kbd "M-,") 'org-mark-ring-goto)

;;;; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;;;; ____ ** "Visibility" -- the org-show-only stuff (which is badly named)

;;;; I'm unsure about these, but they're the best you have for now.

(org-defkey org-mode-map (kbd "C-H-'")   'nomis/org-show-only/cycle/less)
(org-defkey org-mode-map (kbd "C-H-\\")  'nomis/org-show-only/cycle/more)

;;;; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;;;; ____ ** Expand/collapse

(org-defkey org-mode-map (kbd "H-q =")   'norg/show-all-to-current-level)

(org-defkey org-mode-map (kbd "H-M-'")   'norg/show-children-from-point/set-0)
(org-defkey org-mode-map (kbd "H-M-\\")  'norg/show-children-from-point/fully-expand)
(org-defkey org-mode-map (kbd "H-M-[")   'norg/show-children-from-root/set-0)
(org-defkey org-mode-map (kbd "H-M-]")   'norg/show-children-from-root/fully-expand)
(org-defkey org-mode-map (kbd "H-M--")   'norg/show-children-from-all-roots/set-0)
(org-defkey org-mode-map (kbd "H-M-=")   'norg/show-children-from-all-roots/fully-expand)

(org-defkey org-mode-map (kbd "H-'")     'norg/show-children-from-point/incremental/less)
(org-defkey org-mode-map (kbd "H-\\")    'norg/show-children-from-point/incremental/more)
(org-defkey org-mode-map (kbd "H-[")     'norg/show-children-from-root/incremental/less)
(org-defkey org-mode-map (kbd "H-]")     'norg/show-children-from-root/incremental/more)
(org-defkey org-mode-map (kbd "H--")     'norg/show-children-from-all-roots/incremental/less)
(org-defkey org-mode-map (kbd "H-=")     'norg/show-children-from-all-roots/incremental/more)

;;;; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;;;; ____ ** Movement

(org-defkey org-mode-map (kbd "H-,")     'norg/backward-heading-same-level)
(org-defkey org-mode-map (kbd "H-.")     'norg/forward-heading-same-level)
(org-defkey org-mode-map (kbd "H-<")     'norg/backward-heading-same-level/allow-cross-parent)
(org-defkey org-mode-map (kbd "H->")     'norg/forward-heading-same-level/allow-cross-parent)

;;;; - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
;;;; ____ ** Movement + expand/collapse

(org-defkey org-mode-map (kbd "C-H-,")   'norg/step-backward)
(org-defkey org-mode-map (kbd "C-H-.")   'norg/step-forward)
(org-defkey org-mode-map (kbd "C-H-<")   'norg/step-backward/allow-cross-parent)
(org-defkey org-mode-map (kbd "C-H->")   'norg/step-forward/allow-cross-parent)

(org-defkey org-mode-map (kbd "H-M-,")   'norg/forward-heading/any-level)
(org-defkey org-mode-map (kbd "H-M-.")   'norg/backward-heading/any-level)

;; (org-defkey org-mode-map (kbd "C-H-M-,") ????) ; TODO Want something that visits headlines at any level and collapses as it goes
;; (org-defkey org-mode-map (kbd "C-H-M-.") ????) ; TODO Want something that visits headlines at any level and collapses as it goes

;; (org-defkey org-mode-map (kbd "H-M-<")   ????) ; No real meaning -- with the M we are already crossing parent levels
;; (org-defkey org-mode-map (kbd "H-M->")   ????) ; No real meaning -- with the M we are already crossing parent levels
;; (org-defkey org-mode-map (kbd "C-H-M-<") ????) ; No real meaning -- with the M we are already crossing parent levels
;; (org-defkey org-mode-map (kbd "C-H-M->") ????) ; No real meaning -- with the M we are already crossing parent levels

;;;; ___________________________________________________________________________
;;;; ____ * Agenda

(progn ; TODO This is not only agenda stuff (contrary to the comment above), and this does not need to be done in a hook (or else everything should go in a hook)
  (defun nomis/setup-org-keys ()
    ;; I don't like RETURN in org agenda giving ORG-AGENDA-SWITCH-TO.
    ;; I prefer this:
    (org-defkey org-agenda-mode-map "\C-m" 'org-agenda-show-and-scroll-up)
    ;; Stuff that got changed when I upgraded to Emacs 26.1 -- this is mad!
    (org-defkey org-mode-map (kbd "M-S-<down>") 'org-move-subtree-down)
    (org-defkey org-mode-map (kbd "M-S-<up>")   'org-move-subtree-up))
  (add-hook 'org-mode-hook 'nomis/setup-org-keys))

;;;; ___________________________________________________________________________
;;;; ____ * End

(provide 'nomis-org-key-bindings)
