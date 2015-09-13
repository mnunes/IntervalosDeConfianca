library("shiny")
 
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
        textOutput("npct"),
        plotOutput("plot"),
        p("A população tem média 0 e desvio padrão 1.",
          "Intervalos que incluem a média populacional estão coloridos de preto e intervalos que a excluem estão coloridos de vermelho. Baseado no trabalho de https://gist.github.com/jrnold/7124461.")
    )))
