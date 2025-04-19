(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ignored-local-variable-values
   '((eval let ((root (projectile-project-root)))
      (let
          ((includes
            (list "/opt/psn00bsdk/include/libpsn00b" (concat root "include")))
           (neotreebuf
            (seq-filter (lambda (buf) (equal (buffer-name buf) " *NeoTree*"))
                        (buffer-list))))
        (setq-local flycheck-clang-include-path includes)
        (setq-local flycheck-gcc-include-path includes)
        (dap-register-debug-template "PSX Debug"
                                     (list :name "PSX -- Engine debug" :type
                                           "gdbserver" :request "attach" :gdbpath
                                           "/usr/bin/gdb-multiarch" :target
                                           ":3333" :cwd root))))))
 '(package-selected-packages
   '(auctex auto-complete cargo-mode company company-spell daemons evil-collection
     lsp-java lsp-ui rust-mode vterm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
