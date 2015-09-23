

intersect_table <<- reactive({
  res_inter <- input$interTableMethods
  res_list <- res_list()
  tab <- data.frame(GeneID = unlist(c(Reduce(intersect,
                                         res_list$up[res_inter]),
                                  Reduce(intersect,
                                         res_list$dn[res_inter]))))
  
  raw <- dat()
  colnames(raw) <- paste(colnames(raw), "raw", sep = "_")
  raw <- cbind(GeneID = rownames(raw), raw)
  tab <- merge(tab, raw, by = "GeneID")
  
  for(i in res_inter) {
    if(i == "LIMMA") {
      temp <- limma_de_table_res()
      colnames(temp) <- paste(colnames(temp), "limma", sep = "_")
      temp <- cbind(GeneID = rownames(temp), temp)
      tab <- merge(tab, temp, by = "GeneID")
    }
    
    if(i == "DESeq") {
      temp <- res()
      colnames(temp) <- paste(colnames(temp), "deseq", sep = "_")
      tab <- merge(tab, temp, by.x = "GeneID", by.y = "id_deseq")
      
    }
    
    if(i == "DESeq2") {
      temp <- as.data.frame(res2())
      colnames(temp) <- paste(colnames(temp), "deseq2", sep = "_")
      temp <- cbind(GeneID = rownames(temp), temp)
      tab <- merge(tab, temp, by = "GeneID")
      
    }
  }
  
  return(tab)
  
})