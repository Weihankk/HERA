#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("--------------------------------------------")
print("          Running LocalHERA Part 1          ")
print("--------------------------------------------")
#Make the working dirs
system("mkdir 01-Pacbio_And_NonScaffold")
setwd("./01-Pacbio_And_NonScaffold")
system(Use_Working_Script("Check"))
setwd("../")

system("mkdir 02-Pacbio-Alignment")
setwd("./02-Pacbio-Alignment")
system(Use_Working_Script("Check"))
setwd("../")

system("mkdir 03-Pacbio-SelfAlignment")
setwd("./03-Pacbio-SelfAlignment")
system(Use_Working_Script("Check"))
setwd("../")

system("mkdir 04-Graphing")
setwd("./04-Graphing")
system(Use_Working_Script("Check"))
setwd("../")

system("mkdir 05-PathContig")
setwd("./05-PathContig")
system(Use_Working_Script("Check"))
setwd("../")

system("mkdir 06-Daligner")
setwd("./06-Daligner")
system(Use_Working_Script("Check"))
setwd("../")

system("mkdir 07-FilledGap")
setwd("./07-FilledGap")
system(Use_Working_Script("Check"))
setwd("../")

system("mkdir 08-PathContig_Consensus")
setwd("./08-PathContig_Consensus")
system(Use_Working_Script("Check"))
setwd("../")

system("mkdir 09-ReAssembly")
system(Use_Working_Script("Check"))

#convert the fasta to lines
print("convert the fasta to lines")
system(paste(Use_Working_Script("readstoline"), genome_seq, paste0(genome_name,"-Genome.fasta"),"C"))

#split the sequences into two files with large contigs and small contigs
print("split the sequences into two files with large contigs and small contigs")
system(paste(Use_Working_Script("01-Filter_Raw_Contig_By_Length"), paste0(genome_name,"-Genome.fasta"), "Large_Contig.fasta", "Small_Contig.fasta", "50000", "15000"))

#covert the fasta formate to lines
print("covert the fasta formate to lines")
system(paste(Use_Working_Script("readstoline"), Corrected_Pacbio, paste0(genome_name,"-CorrectedPacbio.fasta"), "P"))

Corrected_Pacbio <- paste0(genome_name, "-CorrectedPacbio.fasta")

#Merge the non-scaffolded contig with corrected pacbio and they are all used to construct overlaping graph
print("Merge the non-scaffolded contig with corrected pacbio and they are all used to construct overlaping graph")
system(paste("cat", Bionano_NonScaffolded_Contig, Corrected_Pacbio ,"> Query_Merged.fasta"))

#Change the dir of working
setwd("./01-Pacbio_And_NonScaffold/")

#Split the corrected pacbios and non-scaffolded contigs into parts
print("Split the corrected pacbios and non-scaffolded contigs into parts")
system(paste(Use_Working_Script("03-fasta-splitter"),"--n-parts 100 ../Query_Merged.fasta"))

#Make the list of split sequence
setwd("../")
system("ls ./01-Pacbio_And_NonScaffold/*.fasta >list_Split.txt")

#Make the index of Contig
print("Make the index of Contig")
system(paste("/store/whzhang/tools/bwa-0.7.10/bwa index",Bionano_Scaffolded_Contig))

print("--------------------------------------------")
print("         LocalHERA Part 1 Complete!         ")
print("--------------------------------------------")
