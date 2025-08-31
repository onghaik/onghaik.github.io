(define-module (pages index)
  #:use-module (theme)
  #:use-module (utils)
  #:export (index-page))

(define index-page
  (static-page
   "Kyle Onghai"
   "index.html"
   `((div (@ (class "about-me"))
          (div (@ (class "index-portrait"))
               (img (@ (src "assets/img/portrait.jpeg")
                       (alt "A portrait of me."))))
          (div (@ (class "index-bio"))
               (h2 "Hi!")
               (p "I am a second-year PhD student at "
                  ,(link "Princeton University" "https://www.princeton.edu")
                  " within the "
                  ,(link "Department of Operations Research and Financial Engineering" "https://orfe.princeton.edu") ". "
                  "Currently, my research focuses on modeling the impact of data center growth on electricity prices and using techniques from stochastic control to inform grid planning.  I am also interested in risk-sharing mechanisms for renewables to hedge against intermittency.")
               (p  "Previously, I received my B.S. in Mathematics (with a Specialization in Computing) from "
                   ,(link "UCLA" "https://www.ucla.edu") "."))))))
