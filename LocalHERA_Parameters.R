########### The parameters which users can reset ##########

#set work directory
setwd("/store/whzhang/HERA_TEST")

#the genome name(less 5 words)
genome_name="DJ"

#the whole genome assembled sequences with absolute path
genome_seq="/store/whzhang/LocalHERA/Test_Genome.fasta"

#the corrected pacbio file with absolute path
Corrected_Pacbio="/store/whzhang/LocalHERA/Test_CorrectedPacbio.fasta"

#the enzyme used to form the bionano map(if no bionano maps, neglect this parameter)
Enzyme="GCTCTTC"

#the software with absolute path
Working_Script="/store/whzhang/LocalHERA"

#the queue used to bsub jobs
queue="low"

#DAZZ_DB with absolute path
DAZZ_DB="/store/whzhang/tools/DAZZ_DB/"

#DALIGNER with absolute path
DALIGNER="/store/whzhang/tools/DALIGNER/"

#the positions apart from start or end
InterIncluded_Side="25000"

#internal pacbios and contigs
InterIncluded_Identity="99"
InterIncluded_Coverage="99"

#the pacbios selected for starting and ending
MinIdentity="98"
MinCoverage="99"
MinLength="5000"

#the conditions used to filter the overlap used to construct the graph
MinIdentity_Overlap="97"
MinOverlap_Overlap="1000"
MaxOverhang_Overlap="100"
MinExtend_Overlap="1000"

#the min num path for contig pairs
MinPathNum="3"

#the conditons used to merge the supercontigs and non-scaffolded contigs
MinIdentity_Merge="98"
MinOverlap_Merge="10000"
MaxOverhang_Merge="200"

#the scaffold formed by bionano maps
Bionano_Scaffolded_Contig="Large_Contig.fasta"
#the non-scaffold contigs
Bionano_NonScaffolded_Contig="Small_Contig.fasta"
########### end of resetting parameters ##########
