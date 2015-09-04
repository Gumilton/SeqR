

intersect_table <<- reactive({
  res_inter <- input$interTableMethods
  print(res_inter)
  res_list <- res_list()
  tab <- data.frame(GeneID = unlist(c(Reduce(intersect,
                                         res_list$up[res_inter]),
                                  Reduce(intersect,
                                         res_list$dn[res_inter]))))
  print(nrow(tab))
  
  raw <- dat()
  colnames(raw) <- paste(colnames(raw), "raw", sep = "_")
  raw <- cbind(GeneID = rownames(raw), raw)
  tab <- merge(tab, raw, by = "GeneID")
  print(nrow(tab))
  
  for(i in res_inter) {
    if(i == "LIMMA") {
      print("LIMMA")
      temp <- limma_de_table_res()
      colnames(temp) <- paste(colnames(temp), "limma", sep = "_")
      temp <- cbind(GeneID = rownames(temp), temp)
      tab <- merge(tab, temp, by = "GeneID")
      print(nrow(tab))
    }
    
    if(i == "DESeq") {
      print("DESeq")
      temp <- res()
      colnames(temp) <- paste(colnames(temp), "deseq", sep = "_")
      tab <- merge(tab, temp, by.x = "GeneID", by.y = "id_deseq")
      print(nrow(tab))
      
    }
    
    if(i == "DESeq2") {
      print("DESeq2")
      temp <- as.data.frame(res2())
      colnames(temp) <- paste(colnames(temp), "deseq2", sep = "_")
      temp <- cbind(GeneID = rownames(temp), temp)
      tab <- merge(tab, temp, by = "GeneID")
      print(nrow(tab))
      
    }
  }
  
  print("done")
  print(head(tab))
  return(tab)
  
})