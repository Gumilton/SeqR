
library(shiny)
library(shinyjs)

source('./ui/panelSets_ui.R', local=TRUE)

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