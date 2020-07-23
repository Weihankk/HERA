#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("---------------------------------------------")
print("          Running LocalHERA Part 12          ")
print("---------------------------------------------")

#aligning the path-contigs to scaffold
print("aligning the path-contigs to scaffold")
ss <- dir(pattern = "^Super.*pbs")

#### 4 ####
for (n in seq(1,length(ss),by = 5)){
  if (n < length(ss)+1){
    i <- ss[n]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("/store/whzhang/anaconda2/envs/falcon/bin/DBsplit", "-x1000 -s50", paste0(Gap_Info,".dam")),wait = F) 
    setwd("../")
  }
  if (n+1 < length(ss)+1){
    i <- ss[n+1]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("/store/whzhang/anaconda2/envs/falcon/bin/DBsplit", "-x1000 -s50", paste0(Gap_Info,".dam")),wait = F) 
    setwd("../")
  }
  if (n+2 < length(ss)+1){
    i <- ss[n+2]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("/store/whzhang/anaconda2/envs/falcon/bin/DBsplit", "-x1000 -s50", paste0(Gap_Info,".dam")),wait = F) 
    setwd("../")
  }
  if (n+3 < length(ss)+1){
    i <- ss[n+3]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("/store/whzhang/anaconda2/envs/falcon/bin/DBsplit", "-x1000 -s50", paste0(Gap_Info,".dam")),wait = F) 
    setwd("../")
  }
  if (n+4 < length(ss)+1){
    i <- ss[n+4]
    Gap_Info <- gsub(pattern = ".pbs", replacement = "", x = i)
    print(Gap_Info)
    setwd(Gap_Info)
    system(paste("/store/whzhang/anaconda2/envs/falcon/bin/DBsplit", "-x1000 -s50", paste0(Gap_Info,".dam")),wait = T) 
    setwd("../")
  }
}

print("----------------------------------------------------------")
print("              LocalHERA Part 12 Complete!                 ")
print("                    Please check !                        ")
print("----------------------------------------------------------")