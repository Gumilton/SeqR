
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
                            sliderInput("cutoff", "Cutoff %:",
                                        min = 0, max = 100, value = 20, step = 1),
                            shiny::plotOutput('densityPlot'),
                            shiny::plotOutput('PCAPlot')
                   )
))