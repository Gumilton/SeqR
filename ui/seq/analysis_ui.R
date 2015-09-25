
tabPanel_limma <- tabPanel("limma",
                           fluidRow(
                             column(width=12, p('')),
                             column(width=6, plotOutput('figure_voom_limma')),
                             column(width=6, plotOutput('figure_qt_limma')),
                             column(width=12, dataTableOutput('table_limma'))
                           )
)

tabPanel_deseq <- tabPanel("DESeq",
                           fluidRow(
                             column(width=12, p('')),
                             column(width=6, plotOutput('figure_disp_deseq')),
                             column(width=6, plotOutput('figure_MA_deseq')),
                             column(width=12, dataTableOutput('table_deseq'))
                           )
)

tabPanel_deseq2 <- tabPanel("DESeq2",
                            fluidRow(
                              column(width=12, p('')),
                              column(width=6, plotOutput('figure_disp_deseq2')),
                              column(width=6, plotOutput('figure_MA_deseq2')),
                              column(width=12, dataTableOutput('table_deseq2'))
                            )
)
