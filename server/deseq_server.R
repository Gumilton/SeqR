cds <<- reactive(deseq(dat(), controls(), filter()))
res <<- reactive(deseq_de(cds()))

