# projectionist.el

```lisp
(require 'projectionist)

;; Defaults
(defvar projectionist-heuristics
  '((c++-mode . (("src/*.cpp"     "../include/{}.hpp")
                 ("include/*.hpp" "../src/{}.cpp")))

    (go-mode . (("*.go"      "{}_test.go")
                ("*_test.go" "{}.go")))))
                
(global-set-key [f1] 'projectionist-alternative)
```

# todo
- Support for more complex rules
