
tabPanel_EDA <- tabPanel("EDA",
                         fluidRow(
                           column(width=12, p('')),
                           column(width=12, h2("Library Size")),
                           column(width=12, p('')),
                           column(4, plotOutput('LibSizePlot')),
                           column(width=12, p('')),
                           
                           
                           column(width=12, p('')),
                           column(width=12, h2("Set up Low Expression Gene Filter")),
                           column(width=12, p('')),
                           column(4,
                                  sliderInput("cutoff", "Cutoff %:",
                                                 min = 0, max = 100, 
                                                 value = 20, step = 1)),
                           column(6, plotOutput('densityPlot')),
                           
                           column(width=12, p('')),
                           column(width=12, h2("Principle Component Analysis")),
                           column(width=12, p('')),
                           
                           column(6, 
                                  h4("Variance Factor Plot"),
                                  plotOutput('PCAPlot_factor')),
                           
                           column(6, 
                                  h4("Principle Component Plot"),
                                  plotOutput('PCAPlot_pca',
                                             click = "PCAPlot_click",
                                             brush = brushOpts(
                                               id = "PCAPlot_brush"
                                               )
                                             )
                                  ),
                           
                           
                           column(width=12, p('')),
                           column(width=12, h3("Samples on the Plot")),
                           column(width=12, p('')),
                           
                           column(width = 6, 
                                  h4("Samples near click"),
                                  verbatimTextOutput("PCA_click_info")
                           ),
                           
                           column(width = 6,
                                  h4("Brushed Samples"),
                                  verbatimTextOutput("PCA_brush_info")
                           ),
                           
                           
                           column(width=12, p('')),
                           column(width=12, h2("Samples Clusters")),
                           column(width=12, p('')),
                           
                           column(width = 8,
                                  plotOutput("rawClusterPlot")
                           )
                         )
)
