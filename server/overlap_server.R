library(VennDiagram)

res_list <- reactive({
  p <- input$fdr
  methods <- input$showMethods
  res_list <- list()
  for(i in methods) {
    if(i == "LIMMA") {
      dat <- limma_de_table_res()
      res_list$"UP"$i <- rownames(dat)[dat$adj.P.Val < p & dat$logFC > 0]
      res_list$"DN"$i <- rownames(dat)[dat$adj.P.Val < p & dat$logFC < 0]
    }
    
    if(i == "DESeq") {
      dat <- res()
      res_list$"UP"$i <- rownames(dat)[dat$adj.P.Val < p & dat$logFC > 0]
      res_list$"DN"$i <- rownames(dat)[dat$adj.P.Val < p & dat$logFC < 0]
    }    
    if(i == "DESeq2") {
      dat <- res2()
      res_list$"UP"$i <- rownames(dat)[dat$padj < p & dat$log2FoldChange > 0]
      res_list$"DN"$i <- rownames(dat)[dat$padj < p & dat$log2FoldChange < 0]
    }
  }
  return(res_list)
  
})

figure_UP <- VennDiagram::venn.diagram(res_list()$UP,
                                       filename = NULL)
figure_DN <- VennDiagram::venn.diagram(res_list()$UP,
                                       filename = NULL)