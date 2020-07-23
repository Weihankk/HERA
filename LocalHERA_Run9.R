#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("--------------------------------------------")
print("          Running LocalHERA Part 9          ")
print("--------------------------------------------")

#aligning the path-contigs to scaffold
print("aligning the path-contigs to scaffold")
system(paste("perl", Use_Working_Script("21-Daligner_New.pl"), "Scaffold2Ctg_Gap.txt Prosudo_ScaffoldNonEnzyme2Contig.fasta PathContig_Rename.fasta", queue, "qsub", Working_Script, genome_name, DAZZ_DB, DALIGNER))
ss <- dir(pattern = "^Super.*pbs")

#### 1 ####
for (n in seq(1,length(ss),by = 5)){
  if (n < length(ss)+1){
    i <- ss[n]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("perl", Use_Working_Script("lines_to_split.pl"), paste0(Gap_Info,".fasta"), paste0(Gap_Info,"-formated.fasta")),wait = F)
    setwd("../")
  }
  if (n+1 < length(ss)+1){
    i <- ss[n+1]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("perl", Use_Working_Script("lines_to_split.pl"), paste0(Gap_Info,".fasta"), paste0(Gap_Info,"-formated.fasta")),wait = F)
    setwd("../")
  }
  if (n+2 < length(ss)+1){
    i <- ss[n+2]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("perl", Use_Working_Script("lines_to_split.pl"), paste0(Gap_Info,".fasta"), paste0(Gap_Info,"-formated.fasta")),wait = F)
    setwd("../")
  }
  if (n+3 < length(ss)+1){
    i <- ss[n+3]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("perl", Use_Working_Script("lines_to_split.pl"), paste0(Gap_Info,".fasta"), paste0(Gap_Info,"-formated.fasta")),wait = F)
    setwd("../")
  }
  if (n+4 < length(ss)+1){
    i <- ss[n+4]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("perl", Use_Working_Script("lines_to_split.pl"), paste0(Gap_Info,".fasta"), paste0(Gap_Info,"-formated.fasta")),wait = T)
    setwd("../")
  }
}

print("---------------------------------------------------------")
print("              LocalHERA Part 9 Complete!                 ")
print("                    Please check !                       ")
print("---------------------------------------------------------")