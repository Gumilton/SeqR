
library(shiny)
library(shinyjs)
library(V8)

source('./ui/seq/input_ui.R', local=TRUE)
source('./ui/seq/eda_ui.R', local=TRUE)
source('./ui/seq/analysis_ui.R', local=TRUE)
source('./ui/seq/overlap_ui.R', local=TRUE)
source('./ui/seq/function_ui.R', local=TRUE)



shinyUI(navbarPage("SeqR!",
                   tabPanel("RNAseq",
                            tabsetPanel(
                              tabPanel_dataUPload,
                              tabPanel_EDA,
                              tabPanel_limma,
                              tabPanel_deseq,
                              tabPanel_deseq2,
                              tabPanel_overlap,
                              tabPanel_analyze
                              )
                            ),
                   
                   tabPanel("MicroArray",
                            tabsetPanel(
                              
                              )
                            ),
                   
                   tabPanel("About")
                   )
)