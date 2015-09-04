dds <<- reactive(deseq2(dat(), controls(), filter()))
res2 <<- reactive(deseq2_de(dds()))

