(define-module (pages research)
  #:use-module (theme)
  #:use-module (utils)
  #:export (research-page))

(define* (publication-item #:key title authors venue year links abstract)
  "Renders a publication card in SXML with links and an expandable abstract."
  `(div (@ (class "publication-entry"))
        (h3 (@ (class "publication-title")) ,title)
        (p (@ (class "publication-authors")) ,@authors)
        (p (@ (class "publication-venue"))
           (em ,venue)
           ,(string-append " (" (number->string year) ")"))
        (div (@ (class "publication-links"))
             ,@(map (lambda (link)
                      `(span (@ (class "publication-link-item"))
                             "["
                             (a (@ (href ,(cdr link))
                                   (target "_blank")
                                   (rel "noopener noreferrer"))
                                ,(car link))
                             "] "))
                    links))
        ,@(if abstract
              `((details (@ (class "publication-abstract"))
                         (summary "Abstract")
                         (p ,abstract)))
              '())))

(define research-page
  (static-page
   "Research"
   "research"
   `((div (@ (class "research-container"))
          (section (@ (class "research-section"))
                   (h2 "Preprints")
                   ,(publication-item
                     #:title "AI for AI: Optimizing Additional Infrastructure Build-out to Power Artificial Intelligence Data Centers"
                     #:authors '("Alexander Crosier, " (strong "Kyle Onghai") ", and Ronnie Sircar")
                     #:venue "arXiv preprint arXiv:2609.08166 [q-fin.GN]"
                     #:year 2026
                     #:links '(("arXiv" . "https://arxiv.org/abs/2609.08166")
                               ("PDF"   . "https://arxiv.org/pdf/2609.08166.pdf"))
                     ;; Replace with the exact abstract text from arXiv:2609.08166:
                     #:abstract "The twenty-first century's transformative technology, artificial intelligence, is increasingly constrained by the twentieth century's transformative technology, the electricity grid. Rapid growth in electricity demand from data centers is leading to higher electricity prices, without a compensating supply-side response. We develop a framework linking data-center load growth, available generation capacity, and market-clearing prices to understand this phenomenon. We first analyze a deterministic model to show how differing estimates of demand and supply growth rates affect prices. We then model the expansion of new data centers and their associated electricity demand,together with build-outs of new electricity supply, as stochastic processes,resulting in probabilistic distributions of supply, demand,and prices rather than a single forecast. Finally, we formulate generation expansion as a stochastic control problem in which a revenue-maximizing investor dynamically chooses the intensity of supply-side investments. The analysis highlights a central challenge of the data-center build-out: even when rapid demand growth increases the need for new generation, the uncertainties related to load forecasts, development execution risks, and value cannibalization from overbuilding capacity may weaken incentives to invest at the pace required to keep electricity prices stable."))

          (section (@ (class "research-section"))
                   (h2 "Journal Articles")
                   ,(publication-item
                     #:title `(span (i "k") "-Diophantine " (i "m") "-tuples in finite fields")
                     #:authors '("Trajan Hammonds, Seoyoung Kim, Steven J. Miller, Arjun Nigam, "
                                 (strong "Kyle Onghai")
                                 ", Dishant Saikia, and Lalit M. Sharma")
                     #:venue "International Journal of Number Theory, Vol. 19, No. 04, pp. 891–912"
                     #:year 2023
                     #:links '(("DOI"   . "https://doi.org/10.1142/S1793042123500458")
                               ("arXiv" . "https://arxiv.org/abs/2201.06232")
                               ("PDF"   . "https://arxiv.org/pdf/2201.06232.pdf"))
                     #:abstract '((span "In this paper, we define a " (i "k") "-Diophantine " (i "m") "-tuple to be a set of " (i "m") " positive integers such that the product of any " (i "k") " distinct positive integers is one less than a perfect square. We study these sets in finite fields 𝔽" (sub "p") " for odd prime " (i "p") " and guarantee the existence of a " (i "k") "-Diophantine " (i "m") "-tuple provided " (i "p") " is larger than some explicit lower bound. We also give a formula for the number of 3-Diophantine triples in 𝔽" (sub "p") " as well as an asymptotic formula for the number of " (i "k") "-Diophantine " (i "k") "-tuples."))))))))
