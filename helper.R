DensityPlot <- function(data.frame,main=""){
  samples <- colnames(data.frame)
  if (class(data.frame) == "data.frame") {
    data.frame <- as.matrix(data.frame)}
  if ( max(data.frame) > 10e5) { data.frame <- log2(data.frame + 1)}
  
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
}




PCAPlot <- function( data, controls) {
  
  
  
  
}








