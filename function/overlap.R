
library(VennDiagram)

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
