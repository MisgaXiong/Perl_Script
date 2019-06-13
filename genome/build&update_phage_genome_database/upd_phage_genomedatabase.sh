#==========================================================
#
#	Author: Xiong Dongyan	Usage: see prepare_dl_phage.pl
#
#==========================================================

awk '{print($1)}' phage1.txt > phage2.txt
perl ~/env_perl/perlscript/prepare_dl_phage.pl phage2.txt > phage3.txt
for i in `cat phage3.txt`;
do 
wget ${i}assembly_summary.txt; 
if grep \phage assembly_summary.txt; 
then sh ~/env_perl/usebash/download_refgenome.sh; 
else rm assembly_summary*; 
fi
done
