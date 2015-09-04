

res_list <<- reactive({
  p <- input$fdr
  methods <- input$showMethods
  up_list <- list()
  dn_list <- list()
  for(i in methods) {
    if(i == "LIMMA") {
      dat <- limma_de_table_res()
      print(head(dat))
      up_list$LIMMA <- as.character(na.omit(rownames(dat)[dat$adj.P.Val < p & dat$logFC > 0]))
      dn_list$LIMMA <- as.character(na.omit(rownames(dat)[dat$adj.P.Val < p & dat$logFC < 0]))
    }
    
    if(i == "DESeq") {
      dat <- res()
      print(head(dat))
      up_list$DESeq <- as.character(na.omit(rownames(dat)[dat$adj.P.Val < p & dat$logFC > 0]))
      dn_list$DESeq <- as.character(na.omit(rownames(dat)[dat$adj.P.Val < p & dat$logFC < 0]))
    }    
    if(i == "DESeq2") {
      dat <- as.data.frame(res2())
      print(head(dat))
      up_list$DESeq2 <- as.character(na.omit(rownames(dat)[dat$padj < p & dat$log2FoldChange > 0]))
      dn_list$DESeq2 <- as.character(na.omit(rownames(dat)[dat$padj < p & dat$log2FoldChange < 0]))
    }
  }
  res <- list(up = up_list,
              dn = dn_list)
  print(res)
  return(res)
  
})






