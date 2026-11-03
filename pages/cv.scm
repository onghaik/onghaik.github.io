(define-module (pages cv)
  #:use-module (theme)
  #:use-module (utils)
  #:export (cv-page))

;; (define my-cv
;;   (let ((commit "de1e4dfc2da4ddb0cc3f8bdb73bb0c6d8b054749") ; Replace with actual commit SHA
;;         (revision "0"))
;;     (package
;;      (name "my-cv")
;;      (version (git-version "0.1.0" revision commit))
;;      (source
;;       (origin)
;;       (method git-fetch
;;        (uri (git-reference
;;              (url "https://github.com/onghaik/resume.git") ; Replace with your repo URL
;;              (commit commit)))
;;        (file-name (git-file-name name version))
;;        (sha256
;;         (base32 "0000000000000000000000000000000000000000000000000000")))) ; Replace via `guix hash -rx`
;;      (build-system copy-build-system)
;;      (arguments
;;       (list
;;        ;; Assuming your .tex file is named resume.tex; adjust if named cv.tex or main.tex
;;        #:install-plan #~'(("resume.pdf" "share/resume/"))
;;        #:phases
;;        #~(modify-phases %standard-phases
;;                        (add-before 'install 'compile-resume
;;                                                (lambda _
;;                                                  ;; LuaTeX/fontspec and Biber require a writable HOME/cache directory
;;                                                  ;; for luaotfload font-name indexing and Biber's unpacked Perl cache.
;;                                                  (setenv "HOME" (getcwd))
;;                                                  (setenv "TEXMFVAR" (string-append (getcwd) "/.texmf-var"))
;;                                                  ;; latexmk -lualatex automatically triggers biber on docs.bib
;;                                                  ;; and re-runs lualatex until all references resolve.
;;                                                  (invoke "latexmk" "-lualatex" "-interaction=nonstopmode" "cv.tex"))))))
;;      (native-inputs
;;       (list texlive-scheme-basic
;;             texlive-luatex
;;             texlive-latexmk
;;             ;; Fonts & Unicode engine support
;;             texlive-fontspec
;;             texlive-lm
;;             texlive-fontawesome5
;;             texlive-academicons
;;             texlive-marvosym
;;             ;; Document class & layout packages
;;             texlive-moderncv
;;             texlive-enumitem
;;             texlive-geometry
;;             texlive-etoolbox
;;             texlive-xpatch
;;             texlive-ifmtarg
;;             texlive-xcolor
;;             texlive-colortbl
;;             texlive-hyperref
;;             texlive-url
;;             texlive-pgf
;;             texlive-fancyhdr
;;             texlive-microtype
;;             ;; Bibliography (BibLaTeX + Biber backend)
;;             texlive-biblatex
;;             texlive-biber
;;             texlive-logreq))
;;      (home-page "https://onghaik.github.io")
;;      (synopsis "Curriculum Vitae and Resume of Kyle Onghai")
;;      (description
;;       "Compiled PDF resume built reproducibly with ModernCV, BibLaTeX, and LuaLaTeX.")
;;      (license license:cc-by-sa4.0))))

(define cv-page
  (static-page
   "CV"
   "cv"
   `((div (div (@ (class "pdf-embed-wrapper"))
               (div (@ (class "pdf-embed-link"))
                    (a (@ (href "/assets/pdf/cv/my-cv.pdf")
                          (target "_blank"))
                       "View/Download PDF"))
               (div (@ (class "pdf-embed-container"))
                    (iframe (@ (src "/assets/pdf/cv/my-cv.pdf")))))))))
