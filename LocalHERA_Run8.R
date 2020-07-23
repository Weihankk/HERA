#!/usr/bin/Rscript
args <- commandArgs(T)
source(args[1])
# Some functions easy to use #
Use_Working_Script <- function(x){
  use.script <- paste0(Working_Script,"/",x)
  return(use.script)
}

print("--------------------------------------------")
print("          Running LocalHERA Part 8          ")
print("--------------------------------------------")


setwd("./04-Graphing/")
print("Merge all filtered alignment into an single file")
system(paste("cat PacbioAlignmentFiltered_* > PacbioAlignmentFiltered.txt"))
setwd("../")

#Find the proper overlap for constructing the graph
print("Find the proper overlap for constructing the graph")
system(paste(Use_Working_Script("12-PacbioAlignmentLinker"), "./04-Graphing/PacbioAlignmentFiltered.txt", MaxOverhang_Overlap, MinExtend_Overlap, "> ./04-Graphing/PacbioAlignmentLinked.txt"))

#Constrct graph by the alignment of pacbios, and the nodes are pacbios and the edges are overlaps.
#Then Finding Contigs Pathway with the Correct Orientatios
print("Constrct graph by the alignment of pacbios, and the nodes are pacbios and the edges are overlaps.")
print("Then Finding Contigs Pathway with the Correct Orientatios")
setwd("./04-Graphing/")

system(paste(Use_Working_Script("Selected_Best_Pairs"), "PacbioAlignmentLinked.txt PacbioAlignmentLinked_BestMatch.txt"))
system(paste(Use_Working_Script("13-Graph_By_Finding_Best_MaxExtending_Random_Path"), "PacbioAlignmentLinked_BestMatch.txt >check"))

l#Output the uniq path
print("Output the uniq path")
system("cat ctg_clusters.txt |sort |uniq > ../05-PathContig/ctg_clusters_uniq.txt")
system("cat cluster_ori.txt |sort |uniq > ../05-PathContig/cluster_ori_uniq.txt")

setwd("../")
setwd("./05-PathContig/")

#Make the corrected pacbios and non-scaffolded contigs into a line
print("Make the corrected pacbios and non-scaffolded contigs into a line")
system(paste(Use_Working_Script("14-make_ctg_line"), "cluster_ori_uniq.txt cluster_ori_same_chain.txt"))
system(paste(Use_Working_Script("18-compute_fasta_file_len"), "../Query_Merged.fasta Query_Len.txt"))

#Change the path into the same chain of bionano scaffolds
print("Change the path into the same chain of bionano scaffolds")
system(paste(Use_Working_Script("15-make_junction_by_pos"), "../04-Graphing/ctg_pairs.txt Query_Len.txt cluster_ori_same_chain.txt cluster_ori_same_chain_pos.txt"))

#Extract the aligned information of pacbios for final pathcontigs
print("Extract the aligned information of pacbios for final pathcontigs")
system(paste(Use_Working_Script("16-extract_ctg_infor_for_seq"), "cluster_ori_same_chain_pos.txt cluster_ori_same_chain_pos_for_seq.txt"))

system("echo '>NA' >NA.fasta")
system("echo 'ATCG' >>NA.fasta")

#Output the final contigs of path used to fill the gap of bionano
print("Output the final contigs of path used to fill the gap of bionano")
system(paste(Use_Working_Script("17-extract_seq_by_pos"), "cluster_ori_same_chain_pos_for_seq.txt ../Query_Merged.fasta NA.fasta PathContig.fasta"))

#Compute the length of pathcontigs
print("Compute the length of pathcontigs")
system(paste(Use_Working_Script("18-compute_fasta_file_len"), "PathContig.fasta ../06-Daligner/PathContig_Len.txt"))
setwd("../")

#make the working dirs
print("make the working dirs : 10-Contig_Pairs")
system("mkdir 10-Contig_Pairs")
setwd("./10-Contig_Pairs/")
system(Use_Working_Script("Check"))
system("touch overlap.txt")


#formating the contig pairs based on the paths
print("formating the contig pairs based on the paths")
system(paste(Use_Working_Script("03-Formate_Contig_Pairs_By_Paths"), "overlap.txt ../05-PathContig/ctg_clusters_uniq.txt Contig_Pairs.txt"))
system(paste0("cat Contig_Pairs.txt |awk '{if(($5+$6/3+$7/6)>='",MinPathNum,"'){$8=$5+$6/3+$7/6;print $0;}}' >Contig_Pairs_Filtered.txt"))

#selecting the final contig pairs with clustering based on scores
print("selecting the final contig pairs with clustering based on scores")
system(paste(Use_Working_Script("05-Merge_With_HighestScore_To_Sequence_By_Path"), "Contig_Pairs_Filtered.txt ../Large_Contig.fasta SuperContig.fasta >Selected_Pairs.txt"))

setwd("../06-Daligner/")

#extract the paths which connects the final selected contigs
print("extract the paths which connects the final selected contigs")
system(paste(Use_Working_Script("19-Path2Scaffold_NoBioNano"), "../10-Contig_Pairs/Selected_Pairs.txt ../05-PathContig/ctg_clusters_uniq.txt PathContig_Len.txt Path_Scaffold.txt"))

#rename the path contigs
print("rename the path contigs")
system(paste(Use_Working_Script("20-PathContig-Rename_NoBioNano"), "Path_Scaffold.txt ../05-PathContig/PathContig.fasta PathContig_Rename.fasta >log"))
system(paste(Use_Working_Script("Rename1"), "../10-Contig_Pairs/SuperContig.fasta  SuperContig_Rename.fasta >Rename_Pairs.txt"))
system(paste(Use_Working_Script("Rename2"), "Rename_Pairs.txt PathContig_Rename.fasta PathContig_Rename2.fasta"))
system("mv -f PathContig_Rename2.fasta PathContig_Rename.fasta")

#formating the connected scaffold
print("formating the connected scaffold")
system(paste(Use_Working_Script("01-Gap_Count"), "SuperContig_Rename.fasta", Enzyme, "Gap.txt"))
system(paste(Use_Working_Script("01-Finding_Contigs_Gap"), "Gap.txt Scaffold2Ctg_Gap.txt"))
system(paste(Use_Working_Script("02-Split_Scaffold_To_Contigs"), "SuperContig_Rename.fasta Prosudo_ScaffoldNonEnzyme2Contig.fasta", Enzyme))

print("---------------------------------------------------------")
print("              LocalHERA Part 8 Complete!                 ")
print("                    Please check !                       ")
print("---------------------------------------------------------")