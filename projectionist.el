;;; prejectionist.el --- Emacs port of tpope/vim-projectionist

;;; Author: Mirco De Zorzi
;;; Version: 0.1
;;; URL: https://github.com/mircodezorzi/projectionist.el

;;; Commentary:

;;; Code:

;; Defaults
(defvar projectionist-heuristics
  '(("src/*.cpp"     "../include/{}.hpp")
    ("include/*.hpp" "../src/{}.cpp")
    ("*.cpp"         "{}.hpp")
    ("*.hpp"         "{}.cpp")))

;; Utility function
(defun @any (f v)
  "Return first element inside of list V that matched F(v)."
  (catch 'break
    (dolist (i v)
      (when (not (equal (funcall f i) nil))
        (throw 'break i)))))

(defun projectionist-get-heuristic ()
  "Get correct heuristic to apply to the filepath."
  (@any
    (lambda (pattern)
      (string-match (s-replace "*" ".*" (car pattern)) buffer-file-name))
    projectionist-heuristics))

(defun projectionist-alternative ()
  "Switch to alternative buffer."
  (interactive)
  (let* ((heuristic    (nth 1 (projectionist-get-heuristic)))
         (filename     (file-name-sans-extension (file-name-nondirectory buffer-file-name)))
         (alt-filename (s-replace "{}" filename heuristic)))
    (if (equal heuristic nil)
      (message "no match found")
      (switch-to-buffer (find-file-noselect alt-filename)))))

(provide 'projectionist)
;;; projectionist.el ends here
