#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("---------------------------------------------")
print("          Running LocalHERA Part 18          ")
print("---------------------------------------------")

#filling the gaps with the path-contigs and the final sequence of Supercontig is SuperContig.fasta
print("filling the gaps with the path-contigs and the final sequence of Supercontig is SuperContig.fasta")
system(paste(Use_Working_Script("22-Filling-Gap"), "Scaffold2Ctg_Gap.txt Prosudo_ScaffoldNonEnzyme2Contig.fasta PathContig_Rename.fasta SuperContig.fasta"))

#formating the final genome
#warnings: In general, users need to filter the used small contigs in "Small_Contig.fasta" rather than simply merge files. Users can map the small contigs to SuperContigs by the tools of bwa and filter the small contigs by coverage
print("formating the final genome")
system(paste(Use_Working_Script("Final_Formating.sh"), Bionano_NonScaffolded_Contig, genome_name))


print("----------------------------------------------------------")
print("              LocalHERA Part 18 Complete!                 ")
print("                    Please check !                        ")
print("----------------------------------------------------------")