
library(shiny)



input_panel <- sidebarPanel(h3("Choose Data File"),
                            checkboxInput('header', 'Header', TRUE),
                            radioButtons('sep', 'Separator',
                                         c(Comma=',',
                                           Semicolon=';',
                                           Tab='\t'),
                                         ','),
                            radioButtons('quote', 'Quote',
                                         c(None='',
                                           'Double Quote'='"',
                                           'Single Quote'="'"),
                                         '"'),
                            fileInput('file1', 'Choose CSV File',
                                      accept=c('text/csv', 
                                               'text/comma-separated-values,text/plain', 
                                               '.csv'))
                            )


data_preview <- wellPanel(h3("Data Preview"), dataTableOutput('datatable'))

controls_panel <- wellPanel(h3("Control Samples"), 
                            uiOutput('controlbox'))

shinyUI(navbarPage("SeqR!",
                   tabPanel("Data Upload",
                            fluidRow(
                              column(width=12, p('')),
                              column(width=8,
                                     input_panel),
                              
                              column(width = 4,
                                     conditionalPanel("!is.null(input.file1)",
                                                      controls_panel)),
                              
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
                   
                   
                   tabPanel("DE",
                            fluidRow(
                              column(width=12, p('')),
                              column(width=12, dataTableOutput('table_limma')),
                              column(width=12, plotOutput('figure_voom_limma')),
                              column(width=12, plotOutput('figure_qt_limma'))
                              
                            )
                   )
))