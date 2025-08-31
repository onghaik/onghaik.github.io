(define-module (pages resume)
  #:use-module (theme)
  #:use-module (utils)
  #:export (resume-page))

(define resume-page
  (static-page
   "CV"
   "resume"
   `((div (div (@ (class "pdf-embed-wrapper"))
               (div (@ (class "pdf-embed-link"))
                    (a (@ (href "/assets/pdf/resume/my-cv.pdf")
                          (target "_blank"))
                       "View/Download PDF"))
               (div (@ (class "pdf-embed-container"))
                    (iframe (@ (src "/assets/pdf/resume/my-cv.pdf")))))))))
