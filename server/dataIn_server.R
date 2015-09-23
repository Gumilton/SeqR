
dat <- reactive({
  inFile <- input$file1
  if(is.null(inFile)) return(NULL)
  
  temp <- tryCatch(
    {
      read.delim(inFile$datapath, header = T, 
                 stringsAsFactors = F, sep = input$sep)
    },
    warning = function(cond) {
      message(cond)
#       read.xlsx(inFile$datapath, header = T, 
#                 sheetIndex = 1)
    }
  )
  
  
  
  
  rownames(temp) <- make.unique(temp[,1], sep = "_")
  temp <- temp[,-1]
  temp <- na.omit(temp)
  return(temp)
})

output$datatable <- renderDataTable({
  temp <- dat()
  cbind(ID = rownames(temp), temp)
})

output$controlBox <- renderUI({
  if (!is.null(dat())) {
    checkboxGroupInput('controlSamples',
                       'Choose control samples',
                       colnames(dat())
    )
  }
})

controls <- reactive(as.character(input$controlSamples))


methods <- reactive(as.character(input$methods))

output$showMethodBox <- renderUI({
  checkboxGroupInput('showMethods',
                     'Choose Analysis Methods',
                     methods())
})

  
