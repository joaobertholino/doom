(doom! :input

       :completion
       (corfu +orderless)
       vertico

       :ui
       doom
       dashboard
       (emoji +unicode)
       hl-todo
       indent-guides
       modeline
       ophints
       (popup +defaults)
       smooth-scroll
       unicode
       (vc-gutter +pretty)
       vi-tilde-fringe
       window-select
       workspaces

       :editor
       (evil +everywhere)
       file-templates
       fold
       (format +lsp +onsave)
       snippets
       (whitespace +guess +trim)

       :emacs
       dired
       electric
       eww
       tramp
       undo
       vc

       :term
       vterm

       :checkers
       syntax

       :tools
       debugger
       (eval +overlay)
       lookup
       (lsp +booster +eglot)
       (magit +forge)
       make
       (pass +auth)
       (pdf +pdf-tools saveplace-pdf-view)
       tmux
       tree-sitter
       upload

       :os
       (:if (featurep :system 'macos) macos)

       :lang
       common-lisp
       emacs-lisp
       (json +lsp +tree-sitter)
       (javascript +lsp +tree-sitter)
       (latex +cdlatex +lsp +latexmk +pdf-tools)
       (lean +lsp +v3)
       (markdown +lsp +grip +tree-sitter)
       (python +conda +cython +lsp +poetry +pyenv +pyright)
       (sh +lsp)
       (web +lsp +tree-sitter)
       (yaml +lsp +tree-sitter)

       :email

       :app
       everywhere

       :config
       (default +bindings +smartparens))
