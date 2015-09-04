library(DESeq2)
library(BiocParallel)

deseq2 <- function(data, controls, filter) {
  
  intType <- any(apply(data,2,typeof) != "integer")
  if(intType) {
    data[] <- lapply(data, as.integer)
  }
  
  condition <- factor(! colnames(data) %in% controls, 
                      labels = c("Control","Case"))
 
  info <- data.frame(condition, row.names = colnames(data))
  
  dds <- DESeq2::DESeqDataSetFromMatrix(countData = data,
                                        colData = info,
                                        design = ~ condition)
  
  
  if(Sys.info()["sysname"] == "Windows") {BiocParallel::register(SnowParam())}
  else {BiocParallel::register(MulticoreParam())}
  
  dds <- DESeq2::DESeq(dds, parallel = T )
  return(dds)
}


deseq2_de <- function(dds) {
  
  res <- DESeq2::results(dds, parallel = T)
  
  return(res)
}



