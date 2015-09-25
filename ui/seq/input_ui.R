
input_panel <- sidebarPanel(h3("Choose Data File"),
                            p("Excel Format not Recommended!"),
                            checkboxInput('header', 'Header', TRUE),
                            radioButtons('sep', 'Separator',
                                         c(Comma=',',
                                           Semicolon=';',
                                           Tab='\t'),
                                         '\t'),
                            radioButtons('quote', 'Quote',
                                         c(None='',
                                           'Double Quote'='"',
                                           'Single Quote'="'"),
                                         '"'),
                            fileInput('file1', 'Choose Data File',
                                      accept=c('text/csv', 
                                               'text/comma-separated-values,text/plain', 
                                               '.csv', '.xlsx')),
                            actionButton("dataIn", "UpLoad!")
)


data_preview <- wellPanel(h3("Data Preview"), dataTableOutput('datatable'))

controls_panel <- wellPanel(h3("Control Samples"), 
                            uiOutput('controlBox'),
                            actionButton("controlSet","Set"))

methods_panel <- wellPanel(h3("Analysis Methods"), 
                           checkboxGroupInput('methods',
                                              'Choose Analysis Methods',
                                              c("LIMMA","DESeq","DESeq2")),
                           p("Note: DESeq may take long time to run when sample size is large"),
                           actionButton("methodSet","Analyze"))

tabPanel_dataUPload <- tabPanel("Data Upload",
                                fluidRow(
                                  column(width=12, p('')),
                                  column(width=8,
                                         input_panel),
                                  
                                  column(width = 4,
                                         conditionalPanel("!is.null(input.file1)",
                                                          controls_panel)),
                                  column(width = 4,
                                         conditionalPanel("!is.null(input.file1)",
                                                          methods_panel)),
                                  
                                  column(width=12,
                                         data_preview)
                                )
)
