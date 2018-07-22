shinyUI(pageWithSidebar(
    headerPanel("Intervalos de Confiança"),

    sidebarPanel(
        actionButton("draw", "Amostrar"),
        numericInput("confidence", "Confiança (%):", 95, min = 1, max = 99,
                     step=1),
        numericInput("smplsize", "Tamanho Amostral:", 100, min = 2, max = 1000,
                     step=1),
        numericInput("nsamples", "Número de Amostras:", 100, min = 1, max = 500,
                     step=1)
        ),

    mainPanel(
      
      tabsetPanel(type = "tabs",
                  selected = "Aplicativo",
        
                  tabPanel("Aplicativo",
                           column(width = 12,
                                  plotOutput("plot"),
                                  p("Desenvolvido por", a("Marcus Nunes", href="http://marcusnunes.me")
                                    )
                           )
                  ),

                  tabPanel("Sobre",
                           column(width = 12,
                                  p("A população tem média 0 e desvio padrão 1. Amostras aleatórias são sorteadas a partir desta população e os intervalos de confiança para a média são calculados em seguida.",
                                    "Intervalos que incluem a média populacional estão coloridos de preto e intervalos que a excluem estão coloridos de vermelho. Baseado no trabalho de", a("jrnold", href="https://gist.github.com/jrnold/7124461"), "."),
                                  p("Desenvolvido por", a("Marcus Nunes", href="http://marcusnunes.me")
                                  )
                           )
                  )
                  
      )
    )
)
)

