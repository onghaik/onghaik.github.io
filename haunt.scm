(use-modules
 (haunt asset)
 (haunt builder blog)
 ;; (haunt builder flat-pages)
 (haunt builder atom)
 (haunt builder assets)
 (haunt builder redirects)
 (haunt post)
 (haunt reader)
 (haunt reader commonmark)
 (haunt site)

 (theme)

 (pages index)
 (pages resume))

(define post-prefix "/posts")

(define posts-collection
  `(("Recent blog posts" "/posts/index.html" ,posts/reverse-chronological)))

(site #:title
      "Kyle Onghai's Website"
      #:domain
      "example.com"
      #:default-metadata
      '((author . "Kyle Onghai")
        (email . "onghaik@gmail.com"))
      #:readers
      (list commonmark-reader sxml-reader)
      #:builders
      (list (blog #:theme onghaik-theme
                  #:collections posts-collection)
            (atom-feed)
            (atom-feeds-by-tag)
            index-page
            resume-page
            (redirects '(("/resume.html" "/resume")))
            (static-directory "assets")
            (static-directory "css")
            (static-directory "fonts")))
