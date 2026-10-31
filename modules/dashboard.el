;;; dashboard.el --- Dashboard layout and actions -*- lexical-binding: nil; -*-

(setq +dashboard-functions
      '(+dashboard-widget-banner +dashboard-widget-shortmenu)
      +dashboard-banner-vertical-padding '(1 . 1)
      +dashboard-menu-sections
      '(("Open file"
         :icon (nerd-icons-octicon "nf-oct-file" :face '+dashboard-menu-title)
         :action find-file)
        ("Open project"
         :icon (nerd-icons-octicon "nf-oct-briefcase" :face '+dashboard-menu-title)
         :action projectile-switch-project)
        ("Create new project"
         :icon (nerd-icons-octicon "nf-oct-play" :face '+dashboard-menu-title)
         :action my/create-project)
        ("Open home terminal"
         :icon (nerd-icons-octicon "nf-oct-terminal" :face '+dashboard-menu-title)
         :action my/open-home-terminal)
        ("Open private configuration"
         :icon (nerd-icons-octicon "nf-oct-tools" :face '+dashboard-menu-title)
         :when (file-directory-p doom-user-dir)
         :action doom/open-private-config)))
