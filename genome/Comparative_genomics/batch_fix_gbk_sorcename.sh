#!/usr/bin/perl

#======================================================================================================
#Advice: After use prkka to creat the gbk file if you wang to do Comparative genomics analysis, it's 
#batter to fix the seq name in gbk file, this shell script can batch fix_gbk_source_name.pl and
#fix_gbk_source_name.pl to fix the seq name in gbk file.
#Before you use it it's batter to make a new dir and copy all the gbk file into that dir, then use this
#script.
#======================================================================================================


#======================================================================================================
#
#	Author :								Xiong Dongyan
#	Edit time:							2019-02-21 20:40
#======================================================================================================

for i in `ls *txt.fasta.gbk`; do perl ~/env_perl/perlscript/pfix_gbk_source_name.pl ${i} >> id.txt; done
for i in `cat id.txt`; do perl ~/env_perl/perlscript/fix_gbk_source_name.pl ${i}.txt.fasta.gbk > ${i}.gbk; done
rm id.txt
rm *txt.fasta*
