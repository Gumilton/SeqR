
limma_ob <<- reactive(limma(dat(), controls(), filter()))
limma_fit_res <<- reactive(limma_fit(limma_ob()))

limma_de_table_res <<- reactive(limma_de_table(limma_fit = limma_fit_res(), 
                                              limma_ob = limma_ob()))
