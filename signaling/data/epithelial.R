allcells <- read.csv("genenames.csv")
clusterlabels <- read.table("Li_cluster_labels.txt")
df1 <- c(0)
cellnames <- names(allcells)
cellnames<- as.vector(unlist(cellnames))
cellnames <- cellnames[2:376]
df1["cluster"]<-c(clusterlabels)
df1[["cellnames"]]<-cellnames

# get a csv with cells corresponding to clusters
write.csv(df1, "clusteredcells.csv")
