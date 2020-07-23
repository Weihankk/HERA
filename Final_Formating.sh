#!/bin/bash
# $1 Bionano_NonScaffolded_Contig
# $2 genome_name
cat SuperContig.fasta ../$1 |awk 'BEGIN{count=1;}{if($0~/^>/){print ">SuperContig"count"END";count++;}else{print $0;}}' >../$2-Final_Genome_HERA.fasta
