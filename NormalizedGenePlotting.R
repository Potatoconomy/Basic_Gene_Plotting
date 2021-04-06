# Normalized Gene Count Plotting
# Patrick Campbell
# April 2021


rm(list=ls())
################################################
##~ User Paths ~################################
################################################
path_dir <- '/Path/to/DESeq2/DDS/'
fig_save_path <-'/home/user/Desktop/'
################################################
##~ Create genes vector ~#######################
################################################
#load()
#readcsv() readcsv2()
genes_1 <- 'TSPAN6'
genes_2 <- c('HSPA8', 'HSPA6A', 'PHF6')
################################################
##~ Imports ~###################################
################################################
load_libraries <- function(){
  library(DESeq2)
  library(reshape2)
  library(dplyr)
  library(ggplot2)
}

load_libraries()
################################################
##~ Functions ~#################################
################################################
plotGeneCounts <- function(dds, genes, fig_name){
  # Plot genes boxplots for a vector of gene names that match gene names in dds
  # dds is the dds object from DESeq2, --- save(dds, f=filename)
  # genes is a vector of gene names matching dds gene names
  # fig_name is character
  gene <- intersect(genes, rownames(dds)) # Prevent errors by removing mismatches.
  difff <- setdiff(genes, gene)
  
  if (length(difff) > 0) {cat('Following genes were not measured:', difff, '\n')}
  
  if (length(gene) == 1){
    df <- plotCounts(dds, gene, intgroup = 'condition', returnData = TRUE)
    p <- ggplot(df, aes(x=condition, y=count)) + 
      geom_point(position=position_jitter(w=0.1,h=0)) + 
      scale_y_log10(breaks=c(25,100,400)) + 
      labs(title=gene)
    ggsave(filename = paste(fig_save_path, fig_name, '.svg', sep=''), plot = p)
  }
  
  else if (length(gene) > 1){
    df <- data.frame()
    l <- list()
    j = 1
    
    for (i in gene){
      data <- plotCounts(dds, i, intgroup = 'condition', returnData = TRUE)
      colnames(data) <- c(i, 'condition')
      l[[j]] <- data
      j <- j + 1
    }
    df <- do.call(cbind, l)
    df.m <- melt(df, id.var = "condition")
    
    p <- ggplot(data = df.m, aes(x=variable, y=value)) + 
      geom_boxplot(aes(fill=condition)) + 
      ggtitle(fig_name)
    ggsave(filename = paste(fig_save_path, fig_name, '.svg', sep=''), plot = p)
  }
  dev.off()
}

loadRData <- function(DEObject_name){
  #loads an RData file, and returns it
  # DEObject_name: name of DEObject that was saved in your directory, ie: 'lfc'
  file_name <- paste(path_dir, DEObject_name, sep='')
  load(file_name)
  DEObject <- get(ls()[!(ls() %in% c("file_name","DEObject_name"))])
  return(DEObject)
}
################################################
##~ Call Functions ~############################
################################################
dds <- loadRData('name of dds_object here')
plotGeneCounts(dds, your_genes_vector, 'Fig save name')






