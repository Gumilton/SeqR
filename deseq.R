library(DESeq)


deseq <- function(data, controls, filter) {
  
  intType <- any(apply(data,2,typeof) != "integer")
  if(intType) {
    data[] <- lapply(data, as.integer)
  }
  
  condition <- factor(! colnames(data) %in% controls, 
                      labels = c("Control","Case"))
  
  cds = newCountDataSet( data[filter,], condition )
  cds = estimateSizeFactors( cds )
  if(all(table(condition) == table(c(1,2)))) {
    cds = estimateDispersions( cds, method="blind", sharingMode="fit-only" )
  }
  else{
    cds = estimateDispersions( cds )
  }
  
  return(cds)
}


deseq_de <- function(cds) {
  res = nbinomTest( cds, "Control","Case" )
  
  return(res)
}



