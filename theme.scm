(define-module (theme)
  #:use-module (haunt artifact)
  #:use-module (haunt builder blog)
  #:use-module (haunt html)
  #:use-module (haunt post)
  #:use-module (haunt site)
  #:use-module (ice-9 match)
  #:use-module (srfi srfi-19)
  #:use-module (utils)
  #:export (onghaik-theme
            flat-page-template
            static-page))

(define (first-paragraph post)
  (let loop ((sxml (post-sxml post)))
    (match sxml
      (() '())
      (((and paragraph ('p . _)) . _)
       (list paragraph))
      ((head . tail)
       (cons head (loop tail))))))

(define onghaik-theme
  (theme #:name "onghaik"
         #:layout
         (lambda (site title body)
           `((doctype "html")
             (head
              (meta (@ (charset "utf-8")))
              (meta (@ (name "description")
                       (content "Kyle Onghai's website")))
              (meta (@ (name "viewport")
                       (content "width=device-width, initial-scale=1")))
              (link (@ (rel "stylesheet") (href "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css")))
              (title ,title)
              ,(stylesheet "fonts")
              ,(stylesheet "onghaik"))
             (body
              (div (@ (class "container"))
                   (nav (@ (class "site-navigation")
                           (id "site-navigation")
                           (aria-labelledby "site-navigation"))
                        (menu (@ (class "nav-brand"))
                              (li ,(link "Kyle Onghai" "/")))
                        (menu (@ (class "nav-headers"))
                              (li ,(link "Blog" "/posts/"))
                              (li ,(link "CV" "/resume/"))))
                   ;; (header (@ (class "page-title"))
                   ;;         (h1 ,title))
                   ,(if (string=? title "Recent blog posts")
                        '()
                        `(h1 ,title))
                   ,body
                   (footer (@ (class "text-center"))
                           (p (@ (class "copyright"))
                              "© 2025 Kyle Onghai")
                           (p (@ (class "contact-links"))
                              (a (@ (href "https://www.linkedin.com/in/kyle-onghai-214587248/")
                                    (target "_blank")
                                    (rel "noopener"))
                                 (i (@ (class "fa-brands fa-linkedin")
                                       (alt "LinkedIn")))))
                           (p "Built using "
                              ,(link "Haunt" "https://dthompson.us/projects/haunt.html")))))))
         #:post-template
         (lambda (post)
           `((article
              ;; (h1 (@ (class "title"))
              ;;     ,(post-ref post 'title))
              (div (@ (class "date"))
                   ,(date->string (post-date post)
                                  "~B ~d, ~Y"))
              (div (@ (class "tags"))
                   "Tags:"
                   (ul ,@(map (lambda (tag)
                                `(li (a (@ (href ,(string-append "/feeds/tags/"
                                                                 tag ".xml")))
                                        ,tag)))
                              (assq-ref (post-metadata post) 'tags))))
              (div (@ (class "post"))
                   ,(post-sxml post)))))
         #:collection-template
         (lambda (site title posts prefix)
           (define (post-uri post)
             (string-append prefix "/" (site-post-slug site post) ".html"))

           `((h1 ,(string-append title " ")
                 (a (@ (href "/feed.xml"))
                    (img (@ (class "feed-icon")
                            (src "../assets/svg/feed.svg")))))

             ,(map (lambda (post)
                     (let ((uri (post-uri post)))
                       `(article (@ (class "summary"))
                                 (h2 (a (@ (href ,uri))
                                        ,(post-ref post 'title)))
                                 (div (@ (class "date"))
                                      ,(date->string (post-date post)
                                                     "~B ~d, ~Y"))
                                 (div (@ (class "post"))
                                      ,(first-paragraph post))
                                 (a (@ (href ,uri)) "read more →"))))
                   posts)))
         #:pagination-template
         (lambda (site body previous-page next-page)
           `(,@body
             (div (@ (class "paginator"))
                  ,(if previous-page
                       `(a (@ (class "paginator-prev") (href ,previous-page))
                           "← Newer")
                       '())
                  ,(if next-page
                       `(a (@ (class "paginator-next") (href ,next-page))
                           "Older →")
                       '()))))))

(define (flat-page-template site metadata body)
  ((theme-layout onghaik-theme) site (assq-ref metadata 'title) body))

(define (static-page title file-name body)
  (lambda (site posts)
    (serialized-artifact
     (if (string-suffix? ".html" file-name)
         file-name
         (string-append file-name "/index.html"))
     (with-layout onghaik-theme site title body)
     sxml->html)))
