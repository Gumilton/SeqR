library(limma)
library(edgeR)


limma <- function(data, controls, filter) {
  

  
  dge <- edgeR::DGEList(counts=data[filter,])
  dge <- edgeR::calcNormFactors(dge)
  
  contrast <- factor(! colnames(data) %in% controls, 
                     labels = c("Control","Case"))
  
  
  design <- model.matrix(~ contrast)
  return(list(dge = dge,
              design = design))
}


limma_fit <- function(limma_ob) {
  dge <- limma_ob$dge
  design <- limma_ob$design
  v <- limma::voom(dge, design)
  
  fit <- limma::lmFit(v,design)
  fit <- limma::eBayes(fit)
  return(fit)
}


limma_de_table <- function(limma_fit,limma_ob) {
  
  limma::topTable(limma_fit, coef=ncol(limma_ob$design),
                  number = Inf, adjust.method = 'fdr')
  
}

limma_voom_figure <- function(limma_ob) {
  dge <- limma_ob$dge
  design <- limma_ob$design
  limma::voom(dge, design, plot = T)
}


limma_qt_figure <- function(limma_fit) {
  qqt(limma_fit$t,df=limma_fit$df.prior+limma_fit$df.residual,
      pch=16,cex=0.2)
  abline(0,1)
  
}



