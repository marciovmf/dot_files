;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "evil" "20260601.1932"
  "Extensible vi layer."
  '((emacs    "24.1")
    (cl-lib   "0.5")
    (goto-chg "1.6")
    (nadvice  "0.3"))
  :url "https://github.com/emacs-evil/evil"
  :commit "457db14f04dd562c36e5704d5ede5c5813224a84"
  :revdesc "457db14f04dd"
  :keywords '("emulations")
  :maintainers '(("Tom Dalziel" . "tom.dalziel@gmail.com")))
