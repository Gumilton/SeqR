
library(shiny)



input_panel <- sidebarPanel(h3("Choose Data File"),
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
                            fileInput('file1', 'Choose CSV File',
                                      accept=c('text/csv', 
                                               'text/comma-separated-values,text/plain', 
                                               '.csv')),
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

shinyUI(navbarPage("SeqR!",
                   tabPanel("RNAseq",
                            tabsetPanel(
                              tabPanel("Data Upload",
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
                                ),
                       
                       
                            tabPanel("EDA",
                                fluidRow(
                                  column(width=12, p('')),
                                  column(6, plotOutput('LibSizePlot')),
                                  column(width=10, p('')),
                                  column(4, sliderInput("cutoff", "Cutoff %:",
                                                        min = 0, max = 100, 
                                                        value = 20, step = 1)),
                                  column(8, plotOutput('densityPlot')),
                                  column(12, plotOutput('PCAPlot'))
                                  )
                                ),
                     
                     
                            tabPanel("limma",
                                 fluidRow(
                                   column(width=12, p('')),
                                   column(width=6, plotOutput('figure_voom_limma')),
                                   column(width=6, plotOutput('figure_qt_limma')),
                                   column(width=12, dataTableOutput('table_limma'))
                                 )
                                 ),
                     
                     
                            tabPanel("DESeq",
                                 fluidRow(
                                   column(width=12, p('')),
                                   column(width=6, plotOutput('figure_disp_deseq')),
                                   column(width=6, plotOutput('figure_MA_deseq')),
                                   column(width=12, dataTableOutput('table_deseq'))
                                 )
                                 ),
                            
                            
                            tabPanel("DESeq2",
                                     fluidRow(
                                       column(width=12, p('')),
                                       column(width=6, plotOutput('figure_disp_deseq2')),
                                       column(width=6, plotOutput('figure_MA_deseq2')),
                                       column(width=12, dataTableOutput('table_deseq2'))
                                     )
                            ),
                            
                            
                            tabPanel("Overlap",
                                     fluidRow(
                                       column(width=12, p('')),
                                       column(width=4, 
                                              wellPanel(h3("Setting"), 
                                                        sliderInput("fdr", "FDR Cutoff:",
                                                                    min = 0, max = 1, 
                                                                    value = .05, step = .001),
                                                        uiOutput('showMethodBox'),
                                                        actionButton("showRes","Show Result"))),
                                       
                                       column(width=12, p('')),
                                       column(width=6, plotOutput('figure_UP')),
                                       column(width=6, plotOutput('figure_DN')),
                                       
                                       column(width=12, p('')),
                                       column(width = 4,
                                              wellPanel(h3("Setting"),
                                                        conditionalPanel('input.showRes',
                                                                         uiOutput('showInterTableBox'),
                                                                         actionButton("showResTable","Show Result Table"),
                                                                         downloadButton('downloadExcel', 'Download as Excel'),
                                                                         downloadButton('downloadCSV', 'Download as CSV'),
                                                                         downloadButton('downloadTXT', 'Download as TXT')))),
                                       column(width=12, dataTableOutput('interTableRes'))
                                     )
                            )
                            
                            )
                            ),
                   
                   tabPanel("MicroArray"),
                   tabPanel("About")
                   )
)