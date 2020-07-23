#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("--------------------------------------------")
print("          Running LocalHERA Part 4          ")
print("--------------------------------------------")

#Split the remained pacbio or contigs into parts
print("Split the remained pacbio or contigs into parts")
setwd("./03-Pacbio-SelfAlignment/")
system(paste(Use_Working_Script("03-fasta-splitter"),"--n-parts 30 ../02-Pacbio-Alignment/Both_Side_Pacbio.fasta"))


#Make index for every part of the pacbios and non-scaffolded contigs
setwd("../")
system("ls ./03-Pacbio-SelfAlignment/*.fasta >list_outer_pacbio.txt")
list_outer <- read.table("list_outer_pacbio.txt", header = F)
list_outer$V1 <- as.character(list_outer$V1)
for (n in seq(1,length(list_outer$V1), by = 5)){
  if (n < length(list_outer$V1)+1){
    system(paste("/store/whzhang/tools/bwa-0.7.10/bwa index",list_outer$V1[n]), wait = F)
  }
  
  if (n+1 < length(list_outer$V1)+1){
    system(paste("/store/whzhang/tools/bwa-0.7.10/bwa index",list_outer$V1[n+1]), wait = F)
  }
  
  if (n+2 < length(list_outer$V1)+1){
    system(paste("/store/whzhang/tools/bwa-0.7.10/bwa index",list_outer$V1[n+2]), wait = F)
  }
  
  if (n+3 < length(list_outer$V1)+1){
    system(paste("/store/whzhang/tools/bwa-0.7.10/bwa index",list_outer$V1[n+3]), wait = F)
  }
  
  if (n+4 < length(list_outer$V1)+1){
    system(paste("/store/whzhang/tools/bwa-0.7.10/bwa index",list_outer$V1[n+4]), wait = T)
  }
}


print("---------------------------------------------------------")
print("              LocalHERA Part 4 Complete!                 ")
print("Please check ./03-Pacbio-SelfAlignment/*fasta all indexed")
print("---------------------------------------------------------")