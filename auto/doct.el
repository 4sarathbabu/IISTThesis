(TeX-add-style-hook
 "doct"
 (lambda ()
   (TeX-add-to-alist 'LaTeX-provided-class-options
                     '(("iist" "phd" "thesis" "twoside")))
   (TeX-run-style-hooks
    "latex2e"
    "chapter1"
    "chapter2"
    "chapter3"
    "appendixA"
    "appendixB"
    "iist"
    "iist10")
   (LaTeX-add-bibliographies))
 :latex)

