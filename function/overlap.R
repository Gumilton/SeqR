
library(VennDiagram)
library(gplots)

drawVenn <- function(res_list, title = "") {
  
  fills <- c("red","green","blue")
  positions <- list(c(0), c(-20,20), c(-60,60,180))
  
  
  grid.draw(venn.diagram(res_list,
                         scaled = TRUE, ext.text = TRUE, col = "transparent",
                         fill = fills[1:length(res_list)], alpha = .5,
                         cex =2, cat.pos = positions[[length(res_list)]], 
                         euler.d=TRUE, margin=.2,
                         main=title,
                         filename = NULL))}


drawHeatmap <- function(data, genes, xmar = 5, ymar = 5, title = "",
                        ksample  = 2, kgene = 2, unsupre = T) {
  if(class(genes) == "list") {
    genes <- unique(as.character(unlist(genes)))
  }
  
  
  
  data <- data[genes,]
  
  hr <- hclust(as.dist(1-cor(t(scale(data)), method="pearson")), method="complete") # Cluster rows by Pearson correlation.
  hc <- hclust(as.dist(1-cor(t(scale(t(data))), method="pearson")), method="complete") 
  
  ksample <- min(ksample, ncol(data))
  myclc <- cutree(hc, k = ksample) # Cut the tree at specific height and color the corresponding clusters in the heatmap color bar.
  mycolhc <- sample(rainbow(ksample+1),replace = F)
  mycolhc <- mycolhc[as.vector(myclc)]
  
  kgene <- min(kgene, nrow(data))
  myclr <- cutree(hr, k = kgene) # Cut the tree at specific height and color the corresponding clusters in the heatmap color bar.
  mycolhr <- sample(rainbow(kgene+1),replace = F)
  mycolhr <- mycolhr[as.vector(myclr)]
  
  bluered <- colorRampPalette(c("blue","white","red"))(1024)
  
  if(unsupre) {
    rowCl = as.dendrogram(hr)
    colCl = as.dendrogram(hc)
  }
  
  else {
    rowCl = FALSE
    colCl = FALSE
  }
  
  
#   png(filename="./tmp.png", 
#       width=40, height=40,units="in", res=10)
#   par(mar = c(15,15,15,15))
  
  heatmap.2(as.matrix(scale(data)), Rowv=rowCl, Colv=colCl, 
            labRow=rownames(data), dendrogram="both",
            labCol=colnames(data),
            col=bluered, scale="row", ColSideColors=mycolhc, 
            RowSideColors=mycolhr, margins = c(xmar, ymar),
            # cexRow=1, cexCol=1, keysize=.7,
            key=TRUE,  density.info="density", 
            trace="none", symkey=FALSE,
            main=title) 
  dev.off()
  
}


splitUPDN <- function(data, direc = "both") {
  
  if(!is.null(data)) {
    
    fc <- data[,grep("log", colnames(data))[1]]
    
    if (direc == "both") {
      return (data$GeneID)
    }
    
    else if (direc == "up") {
      return (data$GeneID[fc > 0])
    }
    
    else if (direc == "dn") {
      return (data$GeneID[fc < 0])
    }
    else return(NULL)
    
  }
  
  
  
  
}

