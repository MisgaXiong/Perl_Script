#==========================================================
#
#	Author: Xiong Dongyan	Usage: see prepare_dl_phage.pl
#
#==========================================================

grep \phage_ phage_gnm1.txt > phage_gnm2.txt
awk '{print($1)}' phage_gnm2.txt > phage_gnm3.txt
perl ~/env_perl/perlscript/prepare_dl_phage.pl phage_gnm3.txt > phage_gnm4.txt
for i in `cat phage_gnm4.txt`; do wget ${i}assembly_summary.txt; sh ~/env_perl/usebash/download_refgenome.sh; rm assembly_summary*; done
