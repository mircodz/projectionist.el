;;; prejectionist.el --- Emacs port of tpope/vim-projectionist

;;; Author: Mirco De Zorzi
;;; Version: 0.1
;;; URL: https://github.com/mircodezorzi/projectionist.el

;;; Commentary:

;;; Code:

;; Defaults
(defvar projectionist-heuristics
  '((c++-mode . (("src/*.cpp"     "../include/{}.hpp")
                 ("include/*.hpp" "../src/{}.cpp")))

    (go-mode . (("*.go"      "{}_test.go")
                ("*_test.go" "{}.go")))))

;; Utility functions
(defun @any (f v)
  "Return first element inside of list V that matched F(v)."
  (catch 'break
    (dolist (i v)
      (when (not (equal (funcall f i) nil))
        (throw 'break i)))))

(defun @get (v d)
  "Return V if V != nil, else D."
  (if (equal v nil) d v))

;; Projectionist

(defun projectionist-get-heuristic ()
  "Get correct heuristic to apply to the filepath."
  (@any
    (lambda (pattern)
      (string-match (s-replace "*" ".*" (car pattern)) buffer-file-name))
    (cdr (assoc major-mode projectionist-heuristics))))

(defun projectionist-alternative ()
  "Switch to alternative buffer."
  (interactive)
  (let* ((heuristic    (nth 1 (projectionist-get-heuristic)))
         (filename     (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
         (alt-filename (s-replace "{}" filename (@get heuristic ""))))
    (if (equal heuristic nil)
      (message "no altervative found")
      (switch-to-buffer (find-file-noselect alt-filename)))))

(provide 'projectionist)

(global-set-key [f1] 'projectionist-alternative)
;;; projectionist.el ends here
