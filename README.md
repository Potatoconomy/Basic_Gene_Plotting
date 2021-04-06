# Basic_Gene_Plotting
Basic Normalized Count plotting of genes as a workflow process in DESeq2

# Usage

1. Save a dds object from DESeq2 or load one into the environment. This is used to make the normalized counts. Two comparative conditions (ctrl vs exp) have been tested, may not work with more than that. 
2. Set user path directories
3. Create a vector of gene names matching the gene names found in the dds object. 1 - 6 gene names is aesthetically pleasing. More is not.

# Version

### Dependencies

ggplot2_3.3.3               
dplyr_1.0.4                 
reshape2_1.4.3              
DESeq2_1.26.0  

### My R Session

R version 3.6.1 (2019-07-05)  
Platform: x86_64-conda_cos6-linux-gnu (64-bit)  
Running under: Ubuntu 20.04.1 LTS  
