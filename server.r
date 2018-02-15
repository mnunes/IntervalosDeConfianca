library("shiny")
library("ggplot2")
library("plyr")

norm_mean <- 0
norm_sd <- 1

## Amostras aleatorias de uma normal e seu intervalo de confianca
smpl_mean_sample_ci <- function(n, p=0.95, pop_mean=0, pop_sd=1) {
    smpl <- rnorm(n, norm_mean, norm_sd)
    smpl_sd <- sd(smpl)
    smpl_mean <- mean(smpl)
    tailprob <- (1 - p) / 2
    q <- -qt(tailprob, df=(n - 1), lower.tail=TRUE)
    se <- smpl_sd / sqrt(n)
    ci <- data.frame(ci_lb = smpl_mean - q * se,
                     ci_ub = smpl_mean + q * se)
    ci
}

shinyServer(function(input, output) {
    sample_ci <- reactive({
        input$draw
        mutate(rdply(input$nsamples, smpl_mean_sample_ci(input$smplsize,
                                                         input$confidence / 100)),
               n = seq_len(input$nsamples),
               contains_mean = ((0 > ci_lb) & (0 < ci_ub)))
    })

    output$plot <- renderPlot({
        print(ggplot(sample_ci(), aes(x = n, ymin = ci_lb, ymax = ci_ub,
                                      colour = contains_mean))
              + geom_hline(yintercept = 0, colour="blue")
              + geom_linerange()
              + coord_flip()
              + scale_x_continuous("Amostras")
              + scale_y_continuous(sprintf("%d%% IC", input$confidence))
              + scale_colour_manual(values = c("red", "black"))
              + theme(legend.position = "none",
                      axis.text.y = element_blank(),
                      axis.ticks.y = element_blank()))
    })

    output$npct <- renderText({
        c("Porcentagem de Intervalos de Confiança que contém a média:", round(mean(sample_ci()$contains_mean) * 100, 2), "%")
    })
})
