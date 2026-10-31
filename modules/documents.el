;;; documents.el --- Markdown, Pandoc and PDF associations -*- lexical-binding: nil; -*-

(after! markdown-mode
  (setq markdown-command "pandoc")
  (add-hook 'markdown-mode-hook #'pandoc-mode))

(after! pandoc-mode
  (setq pandoc-use-test-pdf t))

(setq auto-mode-alist
      (cl-remove-if (lambda (entry) (eq (cdr entry) 'zathura-mode)) auto-mode-alist))
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))
