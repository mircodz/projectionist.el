# projectionist.el

```lisp
(require 'projectionist)

;; Defaults
(defvar projectionist-heuristics
  '(("src/*.cpp"     "../include/{}.hpp")
    ("include/*.hpp" "../src/{}.cpp")
    ("*.cpp"         "{}.hpp")
    ("*.hpp"         "{}.cpp")))
    
(global-set-key [f1] 'projectionist-alternative)
```

# todo
- Context aware heuristics (major mode based)
- Better filepath support
