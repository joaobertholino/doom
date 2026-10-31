;;; latex.el --- LaTeX, PDF refresh, Citar and Texlab -*- lexical-binding: nil; -*-

;; O daemon pode ter iniciado antes da instalação do TeX Live do usuário.
(let ((tex-bin (expand-file-name "~/.local/share/texlive/2026/bin/x86_64-linux")))
  (when (file-directory-p tex-bin)
    (add-to-list 'exec-path tex-bin)
    (setenv "PATH" (concat tex-bin path-separator (getenv "PATH")))))

(defun my/latex-pdf-auto-revert ()
  "Atualiza o PDF aberto quando o latexmk termina uma compilação."
  (auto-revert-mode 1))
(add-hook 'pdf-view-mode-hook #'my/latex-pdf-auto-revert)

(after! auctex-cont-latexmk
  (setq auctex-cont-latexmk-command
        '("latexmk -pvc -lualatex -view=none -synctex=1 -file-line-error -interaction=nonstopmode")))

(after! latex
  ;; Mantém um monitor contínuo por documento principal desde a abertura.
  ;; Aguarda as variáveis locais para respeitar TeX-master em arquivos incluídos.
  (defun my/latex-auto-compile ()
    "Inicia a compilação contínua do documento LaTeX salvo."
    (when (and buffer-file-name
               (not (file-remote-p buffer-file-name))
               (file-exists-p (TeX-master-file "tex"))
               (executable-find "latexmk")
               (not (bound-and-true-p auctex-cont-latexmk-mode)))
      (auctex-cont-latexmk-mode 1)))

  (defun my/latex-auto-compile-setup ()
    "Ativa a compilação automática ao salvar neste buffer."
    (add-hook 'after-save-hook #'my/latex-auto-compile t t)
    (setq-local TeX-command-default "LatexMk"))

  (add-hook 'LaTeX-mode-hook #'my/latex-auto-compile-setup)
  (add-hook 'LaTeX-mode-local-vars-hook #'my/latex-auto-compile)

  (setq-default TeX-engine 'luatex)
  (setq TeX-command-default "LatexMk"
        TeX-save-query nil
        TeX-parse-self t
        TeX-auto-save t
        TeX-electric-sub-and-superscript t
        TeX-view-program-selection '((output-pdf "PDF Tools"))
        TeX-source-correlate-mode t
        TeX-source-correlate-start-server t
        font-latex-fontify-script t
        font-latex-fontify-sectioning 'color
        LaTeX-indent-level 1
        LaTeX-item-indent 1
        TeX-brace-indent-level 2
        LaTeX-top-newline-count 2
        LaTeX-electric-left-right-brace t
        preview-auto-cache-preamble t
        preview-scale-function 1.3
        ispell-program-name "aspell"
        ispell-dictionary "pt_BR"
        TeX-fold-auto t
        fill-column 90)

  (add-to-list 'TeX-command-list
               '("LatexMk" "latexmk -lualatex -synctex=1 -file-line-error -interaction=nonstopmode %(output-dir) %t"
                 TeX-run-TeX nil t))

  (dolist (hook '(cdlatex-mode LaTeX-preview-setup flyspell-mode
                  wc-mode TeX-fold-mode auto-fill-mode))
    (add-hook 'LaTeX-mode-hook hook))

  (map! :map LaTeX-mode-map
        :leader
        "b"     #'TeX-command-master
        "v"     #'TeX-view
        "k"     #'TeX-kill-job
        "l"     #'TeX-recenter-output-buffer
        "e"     #'LaTeX-environment
        "s"     #'LaTeX-section
        "m"     #'TeX-insert-macro
        "p p"   #'preview-at-point
        "p b"   #'preview-buffer
        "p c"   #'preview-clearout-buffer
        "f f"   #'TeX-fold-dwim
        "f b"   #'TeX-fold-buffer
        "f c"   #'TeX-fold-clearout-buffer
        "r"     #'citar-insert-citation
        "S"     #'ispell-buffer))

(after! citar
  (setq citar-bibliography '("~/Documents/refs.bib")
        citar-library-paths '("~/Documents/papers/")
        citar-notes-paths '("~/Documents/notes/"))
  (with-eval-after-load 'embark
    (citar-embark-mode +1)))

(after! lsp-latex
  (setq lsp-latex-texlab-executable "texlab"
        lsp-latex-build-on-save nil
        lsp-latex-lint-on-save t))
