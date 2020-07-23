#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("--------------------------------------------")
print("          Running LocalHERA Part 5          ")
print("--------------------------------------------")

#Align the corrected pacbios and non-scaffolded contigs to scaffolded contigs
list_outer <- read.table("list_outer_pacbio.txt", header = F)
list_outer$V1 <- as.character(list_outer$V1)

#Align the corrected pacbios and non-scaffolded contigs to each other for finding overlaps
i.v <- c()
j.v <- c()
for (i in seq(length(list_outer$V1))){
  part.i <- list_outer$V1[i]
  j <- i
  for (j in seq(j,length(list_outer$V1))){
    part.j <- list_outer$V1[j]
    #print(c(i,j))
    i.v <- c(i.v, i)
    j.v <- c(j.v, j)
  }
}

print("Align the corrected pacbios and non-scaffolded contigs to each other for finding overlaps")
print("This step will consume a lot of time")
for (n in seq(1,length(i.v), by = 5)){
  if (n < length(i.v)+1){
    print(paste("Jobs:",as.character(n),"/",as.character(length(i.v))))
    part.i.n <- list_outer$V1[i.v[n]]
    part.j.n <- list_outer$V1[j.v[n]]
    if (part.i.n == part.j.n){
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -e -t 12",part.i.n, part.j.n, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n]),"-",as.character(j.v[n]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n]),"-",as.character(j.v[n]),".bwalog")),wait = F)
    }else{
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -t 12",part.i.n, part.j.n, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n]),"-",as.character(j.v[n]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n]),"-",as.character(j.v[n]),".bwalog")),wait = F)
    }
  }
  
  if (n+1 < length(i.v)+1){
    print(paste("Jobs:",as.character(n+1),"/",as.character(length(i.v))))
    part.i.n1 <- list_outer$V1[i.v[n+1]]
    part.j.n1 <- list_outer$V1[j.v[n+1]]
    if (part.i.n1 == part.j.n1){
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -e -t 12",part.i.n1, part.j.n1, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+1]),"-",as.character(j.v[n+1]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+1]),"-",as.character(j.v[n+1]),".bwalog")),wait = F)
    }else{
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -t 12",part.i.n1, part.j.n1, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+1]),"-",as.character(j.v[n+1]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+1]),"-",as.character(j.v[n+1]),".bwalog")),wait = F)
    }
  }
  
  if (n+2 < length(i.v)+1){
    print(paste("Jobs:",as.character(n+2),"/",as.character(length(i.v))))
    part.i.n2 <- list_outer$V1[i.v[n+2]]
    part.j.n2 <- list_outer$V1[j.v[n+2]]
    if (part.i.n2 == part.j.n2){
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -e -t 12",part.i.n2, part.j.n2, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+2]),"-",as.character(j.v[n+2]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+2]),"-",as.character(j.v[n+2]),".bwalog")),wait = F)
    }else{
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -t 12",part.i.n2, part.j.n2, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+2]),"-",as.character(j.v[n+2]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+2]),"-",as.character(j.v[n+2]),".bwalog")),wait = F)
    }
  }
  
  if (n+3 < length(i.v)+1){
    print(paste("Jobs:",as.character(n+3),"/",as.character(length(i.v))))
    part.i.n3 <- list_outer$V1[i.v[n+3]]
    part.j.n3 <- list_outer$V1[j.v[n+3]]
    if (part.i.n3 == part.j.n3){
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -e -t 12",part.i.n3, part.j.n3, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+3]),"-",as.character(j.v[n+3]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+3]),"-",as.character(j.v[n+3]),".bwalog")),wait = F)
    }else{
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -t 12",part.i.n3, part.j.n3, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+3]),"-",as.character(j.v[n+3]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+3]),"-",as.character(j.v[n+3]),".bwalog")),wait = F)
    }
  }
  
  if (n+4 < length(i.v)+1){
    print(paste("Jobs:",as.character(n+4),"/",as.character(length(i.v))))
    part.i.n4 <- list_outer$V1[i.v[n+4]]
    part.j.n4 <- list_outer$V1[j.v[n+4]]
    if (part.i.n4 == part.j.n4){
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -e -t 10",part.i.n4, part.j.n4, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+4]),"-",as.character(j.v[n+4]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+4]),"-",as.character(j.v[n+4]),".bwalog")),wait = T)
    }else{
      system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -t 10",part.i.n4, part.j.n4, paste0("> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+4]),"-",as.character(j.v[n+4]),".sam"),paste0("2> ./03-Pacbio-SelfAlignment/Part_SelfAlignment_",as.character(i.v[n+4]),"-",as.character(j.v[n+4]),".bwalog")),wait = T)
    }
  }
}

print("---------------------------------------------------------")
print("              LocalHERA Part 5 Complete!                 ")
print("                    Please check !                       ")
print("---------------------------------------------------------")

