output$densityPlot <- renderPlot(DensityPlot(dat(), cutoff = input$cutoff),
                                 width = 400, height = 400)

filter <- reactive({
  geneMeans <- rowMeans(dat())
  qt <- quantile(geneMeans, as.numeric(input$cutoff)/100)
  return(geneMeans > qt)
})

svd_data <- reactive({
  anaPCA(dat(),filter())
})


output$PCAPlot_factor <- renderPlot(PCAPlot_factor(svd_data()), 
                                    width = 500, height = 500)

output$PCAPlot_pca <- renderPlot(PCAPlot_pca(dat(), svd_data(), controls()), 
                                 width = 500, height = 500)

output$PCA_click_info <- renderPrint({
  # this was a base graphics plot, we'd need to supply xvar or yvar
  temp <- as.data.frame(svd_data()$v[,1:2])
  rownames(temp) <- colnames(dat())
  colnames(temp) <- c("X","Y")
  nearPoints(temp, input$PCAPlot_click, addDist = TRUE, xvar = "X", yvar = "Y")
})

output$PCA_brush_info <- renderPrint({
  temp <- as.data.frame(svd_data()$v[,1:2])
  rownames(temp) <- colnames(dat())
  colnames(temp) <- c("X","Y")
  brushedPoints(temp, input$PCAPlot_brush, xvar = "X", yvar = "Y")
})

output$LibSizePlot <- renderPlot(libSizePlot(dat()))

output$rawClusterPlot <- renderPlot(clusterPlot(dat(), filter(), controls()))
