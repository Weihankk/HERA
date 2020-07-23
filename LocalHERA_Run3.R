#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("--------------------------------------------")
print("          Running LocalHERA Part 3          ")
print("--------------------------------------------")

#Align the corrected pacbios and non-scaffolded contigs to scaffolded contigs
list_Split <- read.table("list_Split.txt", header = F)
list_Split$V1 <- as.character(list_Split$V1)
# Skip BWA in Part 2
print("Running sam2blasr")
for (i in list_Split$V1){
  i.count <- gsub(pattern = "Query_Merged.part-",replacement = "", x = basename(i))
  i.count <- as.character(as.integer(gsub(pattern = ".fasta", replacement = "", x = i.count)))
  #system(paste("/store/whzhang/tools/bwa-0.7.10/bwa mem -a -t 10", Bionano_Scaffolded_Contig, i, paste0("> ./02-Pacbio-Alignment/Part_Alignment_",i.count,".sam")))
  system(paste("perl",Use_Working_Script("sam2blasr.pl"),paste0("./02-Pacbio-Alignment/Part_Alignment_",i.count,".sam"),paste0("./02-Pacbio-Alignment/Part_Alignment_",i.count,".txt")))
  #system(paste("rm -f",paste0("./02-Pacbio-Alignment/Part_Alignment_",i.count,".sam")))
}

#Merge all alignment into an single file
print("Merge all alignment into an single file")
system("cat ./02-Pacbio-Alignment/Part_Alignment_*.txt > ./02-Pacbio-Alignment/Total_Alignment.txt")

#Remove the pacbios and non-scaffolded contigs aligned to the internal scaffolded contigs
print("Remove the pacbios and non-scaffolded contigs aligned to the internal scaffolded contigs")
system(paste(Use_Working_Script("05-Filtered_InterIncluded_Pacbio"),"./02-Pacbio-Alignment/Total_Alignment.txt ./02-Pacbio-Alignment/InterIncluded_Pacbio.txt", InterIncluded_Identity, InterIncluded_Coverage, InterIncluded_Side))

#Record the pacbio alignment of contig's head and end
print("Record the pacbio alignment of contig's head and end")
system(paste(Use_Working_Script("06-Extract_Contig_Head_Tail_Pacbio_Alignment"), "-Align=./02-Pacbio-Alignment/Total_Alignment.txt", paste0("-MinIden=",MinIdentity), paste0("-MinCov=",MinCoverage), paste0("-HTLen=",InterIncluded_Side), paste0("-MinLen=",MinLength)))

#Change the aligned positions into positive chain
print("Change the aligned positions into positive chain")
system(paste(Use_Working_Script("10-Switch_Locus_To_Positive"),"Contig_Head_Tail_Pacbio.txt ./04-Graphing/Contig_Head_Tail_Pacbio_Pos.txt"))

#Extract the sequence of corrected pacbio and non-scaffoled contigs which are nonaligned or aligned to the start or end of the contigs
print("Extract the sequence of corrected pacbio and non-scaffoled contigs which are nonaligned or aligned to the start or end of the contigs")
system(paste(Use_Working_Script("07-extract_fasta_seq_by_name"),"./02-Pacbio-Alignment/InterIncluded_Pacbio.txt ./Query_Merged.fasta ./02-Pacbio-Alignment/Both_Side_Pacbio.fasta"))


print("--------------------------------------------")
print("         LocalHERA Part 3 Complete!         ")
print("--------------------------------------------")