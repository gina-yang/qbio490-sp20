allcells <- read.csv("GSE81861_CRC_tumor_all_cells_COUNT.csv")
names <- allcells[1] # save rownames
names <-as.vector(unlist(names)) # convert from list to character vector
for( i in 1:length(names) ){
  names[i] <- strsplit(names[i], "_")[[1]][2]
}
allcells[1]<-list(names)
