;; Package Manegement
(package-initialize)
(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://melpa.org/packages/")
        ("org" . "http://orgmode.org/elpa/")
	("marmalade" . "http://marmalade-repo.org/packages/")))
;; auto install
(require 'cl)
(defvar installing-package-list
  '(
    init-loader
    ;; groovy-mode
    yaml-mode
    markdown-mode
    magit
    ))
(let ((not-installed (loop for x in installing-package-list
                            when (not (package-installed-p x))
                            collect x)))
  (when not-installed
    (package-refresh-contents)
    (dolist (pkg not-installed)
        (package-install pkg))))
(init-loader-load)
