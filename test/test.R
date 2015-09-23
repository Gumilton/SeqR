dat <- read.delim("../testSamples.txt", stringsAsFactors = F)
rownames(dat) <- dat[,1]
dat <- dat[,-1]

dat <- cbind(dat,dat + matrix(rnorm(135654), ncol = 6),
             dat + matrix(rnorm(135654), ncol = 6),
             dat + matrix(rnorm(135654), ncol = 6),
             dat + matrix(rnorm(135654), ncol = 6),
             dat + matrix(rnorm(135654), ncol = 6))

dat <- cbind(dat + matrix(rnorm(813924), ncol = 6),
             dat + matrix(rnorm(813924), ncol = 6),
             dat + matrix(rnorm(813924), ncol = 6),
             dat + matrix(rnorm(813924), ncol = 6),
             dat + matrix(rnorm(813924), ncol = 6))


colnames(dat) <- make.unique(colnames(dat))

dat <- dat - min(dat)


numSample <- seq(4,ncol(dat),10)

result <- data.frame(non_usr = rep(0,length(numSample)),
                     non_sys = rep(0,length(numSample)),
                     non_elp = rep(0,length(numSample)),
                     para_usr = rep(0,length(numSample)),
                     para_sys = rep(0,length(numSample)),
                     para_elp = rep(0,length(numSample)))

sampleInfo <- as.data.frame(t(dat[1:2,]))
colnames(sampleInfo) <- c("sample", "type")
sampleInfo$sample <- rownames(sampleInfo)

sampleInfo$type <- c(rep(c("T","N"),18))

dat[1:500, sampleInfo$type == "T"] <- dat[1:500, sampleInfo$type == "T"] + 100

library(DESeq2)

library(BiocParallel)
BiocParallel::SnowParam()

dds <- DESeq2::DESeqDataSetFromMatrix(round(dat), colData = sampleInfo, design = ~type)



for(i in 1:length(numSample)) {
  ns <- numSample[i]
  print(ns)
  
  temp <- dds[,1:ns]
  
  t <- proc.time()
  temp <- DESeq(temp, parallel = F)
  temp2 <- DESeq2::results(temp,parallel = F)
  result[i,1:3] <- proc.time() - t
  
  
  temp <- dds[,1:ns]
  t <- proc.time()
  temp <- DESeq(temp, parallel =T)
  temp2 <- DESeq2::results(temp,parallel = T)
  result[i,4:6] <- proc.time() - t
  
}

plot(numSample, result[,6], ylim = c(0, max(result[,6])), type = "l")
points(numSample, result[,4], type = "l", col = "black", lty = 2)
points(numSample, result[,5], type = "l", col = "black", lty = 3)
points(numSample, result[,3], type = "l", col = "blue")
points(numSample, result[,1], type = "l", col = "blue", lty = 2)
points(numSample, result[,2], type = "l", col = "blue", lty = 3)

result$numSample <- numSample

write.table(result, "Runtime Analysis.txt", sep = "\t", row.names = F, quote = F)
