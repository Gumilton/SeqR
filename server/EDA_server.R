output$densityPlot <- renderPlot({
  
  DensityPlot(dat(), cutoff = input$cutoff)
  
})

filter <- reactive({
  geneMeans <- rowMeans(dat())
  qt <- quantile(geneMeans, as.numeric(input$cutoff)/100)
  return(geneMeans > qt)
})

output$PCAPlot <- renderPlot(PCAPlot(dat(), controls(), filter()))

output$LibSizePlot <- renderPlot(libSizePlot(dat()))
