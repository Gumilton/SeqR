DensityPlot <- function(data.frame, cutoff, main=""){
  samples <- colnames(data.frame)
  if (class(data.frame) == "data.frame") {
    data.frame <- as.matrix(data.frame)}
  if ( max(data.frame) > 10e3) { data.frame <- log2(data.frame + 1)}
  
  geneMeans <- rowMeans(data.frame)
  qt <- quantile(geneMeans, cutoff/100)
  color <- rainbow(ncol(data.frame))
  xlim_vec <- range(density(data.frame)$x)
  
  y_density_range <- function(data){
    y<-range(density(data)$y)
    return (c(y))
  }  
  
  ylim_vec <-range(apply(data.frame,2,y_density_range))
  
  plot.new()
  plot.window(xlim_vec, ylim_vec)
  
  for(i in 1:ncol(data.frame)) {
    
    points(density(data.frame[,i]),
           type = "l", lty=3,
           ylim = ylim_vec,
           xlim = xlim_vec,
           main="",col=color[i])
  }
  
  box()
  axis(1)
  axis(2)
  title(main)
  
  legend("topright", samples, fill = color)
  
  abline(v = qt)
  text(qt + xlim_vec[2]/10, ylim_vec[2]/8, paste("<", cutoff, "% Filter"))
}




PCAPlot <- function( data, controls, filter) {
  if(length(filter) != 0) {
    data <- data[filter,]
  }
  
  library(svd)
  library(scales)
  
  svd_data <- svd(data - rowMeans(data))
  
  if(length(controls) != 0) {
    colors = alpha(ifelse(colnames(data) %in% controls,"red","blue"), .5)
  }
  else {colors = "black"}
  
  par(mfrow=c(1,2))
  plot((svd_data$d^2/sum(svd_data$d^2))[1:min(10, length(svd_data$d))],
       xlab="First 10 Principle Components", ylab="% Variance Explained",
       main="Factor Analysis PCA",pch=19,type="b")
  
  plot(svd_data$v[,1],svd_data$v[,2],pch=19, 
       col=colors,
       
       xlab=paste("Principle Component 1:", 
                  signif((svd_data$d^2/sum(svd_data$d^2))[1]*100,4),
                  "%"),
       ylab=paste("Principle Component 2:", 
                  signif((svd_data$d^2/sum(svd_data$d^2))[2]*100,4),
                  "%"),
       main="Principle Component Analysis")
  if(length(controls) != 0) {
    legend("bottomleft", legend=c("Controls","Case"),
           col=c("red","blue"),pch=19, bty = "n")
  }
  
  # par(p0)
  
  
}


libSizePlot <- function(data) {
  
  suffix <- ""
  if(max(data) > 10e5) {
    data <- (data)/10e6
    suffix <- "(Million)"
  }
  
  
  barplot(colSums(data),las=2, 
          names.arg = colnames(data),
          cex.names =  1,
          main= paste("Library Size", suffix))
}





