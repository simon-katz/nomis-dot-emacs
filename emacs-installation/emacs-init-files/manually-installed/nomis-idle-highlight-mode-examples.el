:Elisp
;;;; Elisp examples for testing nomis-idle-highlight-mode.

;; Ensure no problem at start of buffer.

;; Move cursor through the following and check all is good.

(fred
 @fred ; This is Elisp, not Clojure, so @ is not treated specially.
 :fred
 ^:fred foo ; This is Elisp, not Clojure, so ^ is not treated specially.
 )

;; Run `nomis-idle-highlight-toggle-colon-at-start-matters`.
;; Check the above again.
;; Run `nomis-idle-highlight-toggle-colon-at-start-matters`.

;; Put cursor at the start of the following lines. Should be no highlighting.

;(fred @fred :fred ^:fred foo)
'(fred @fred :fred ^:fred foo)
`(fred @fred :fred ^:fred foo)

;; Highlighting happens in comments.
;; fred @fred :fred ^:fred
;; `fred` too.

;; More to run through:

(defn foo ()
  (let ((aaaa (goo 42 42))
        (bbbb (goo aaaa 42)))
    ;; Position cursor at start of this comment, on the first semicolon.
    ;; Ensure no highlighting.
    (goo aaaa bbbb)))

;; After the following symbol, check highlighting for all following points.
;; (There was a bug when at end of file, when highlighting would incorrectly
;; happen.)
final-stuff-with-blank-lines-following
