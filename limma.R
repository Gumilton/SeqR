library(limma)
library(edgeR)


limma <- function(data, controls, filter) {
  

  
  dge <- DGEList(counts=data[filter,])
  dge <- calcNormFactors(dge)
  
  contrast <- factor(! colnames(data) %in% controls, 
                     labels = c("Control","Case"))
  
  
  design <- model.matrix(~ contrast)
  return(list(dge = dge,
              design = design))
}


limma_fit <- function(limma_ob) {
  dge <- limma_ob$dge
  design <- limma_ob$design
  v <- voom(dge, design)
  
  fit <- lmFit(v,design)
  fit <- eBayes(fit)
  return(fit)
}


limma_de_table <- function(limma_fit,limma_ob) {
  
  topTable(limma_fit, coef=ncol(limma_ob$design), number = Inf, 
           adjust.method = 'fdr')
  
}

limma_voom_figure <- function(limma_ob) {
  dge <- limma_ob$dge
  design <- limma_ob$design
  voom(dge, design, plot = T)
}


limma_qt_figure <- function(limma_fit) {
  qqt(limma_fit$t,df=limma_fit$df.prior+limma_fit$df.residual,
      pch=16,cex=0.2)
  abline(0,1)
  
}



