

tabPanel_analyze <- tabPanel("Function",
                             fluidRow(
                               column(width=12, p('')),
                               
                               column(width=12, p('')),
                               
                               column(width=12, 
                                      h3("Gene Enrichment Analysis")),
                               column(width=4,
                                      h4("Enrichr"),
                                      actionButton("Enrichr_up", "Enrichr for UP Regulated Genes"),
                                      actionButton("Enrichr_dn", "Enrichr for DOWN Regulated Genes"),
                                      actionButton("Enrichr_both", "Enrichr for Both")),
                               column(width=4,
                                      h4("DAVID"),
                                      radioButtons('david_type', 'Gene Name Types',
                                                   c(GENE_SYMBOL='GENE_SYMBOL',
                                                     UCSC_GENE_ID='UCSC_GENE_ID',
                                                     ENSEMBL_GENE_ID='ENSEMBL_GENE_ID',
                                                     ENTREZ_GENE_ID='ENTREZ_GENE_ID'),
                                                   'GENE_SYMBOL'),
                                      htmlOutput('DAVID_up'),
                                      htmlOutput('DAVID_dn'),
                                      htmlOutput('DAVID_both')),
                               column(width = 4))
)

