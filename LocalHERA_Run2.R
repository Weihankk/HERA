#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("--------------------------------------------")
print("          Running LocalHERA Part 2          ")
print("--------------------------------------------")


#Align the corrected pacbios and non-scaffolded contigs to scaffolded contigs
list_Split <- read.table("list_Split.txt", header = F)
list_Split$V1 <- as.character(list_Split$V1)

print("Align the corrected pacbios and non-scaffolded contigs to scaffolded contigs")
job.list <- list_Split$V1[args[2]:args[3]]
for (i in seq(job.list)){
  print(i)
  i.n <- job.list[i]
  i.n.count <- gsub(pattern = "Query_Merged.part-",replacement = "", x = basename(i.n))
  i.n.count <- as.character(as.integer(gsub(pattern = ".fasta", replacement = "", x = i.n.count)))
  system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -t 10", Bionano_Scaffolded_Contig, i.n, paste0("> ./02-Pacbio-Alignment/Part_Alignment_",i.n.count,".sam")), wait = F)
}
