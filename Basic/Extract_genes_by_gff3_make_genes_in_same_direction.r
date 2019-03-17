#===================================================================
# Extract genes by gff3 and fasta file
# Let the negative strand gene reverse complement to have a same 
# direction to positive strand gene
# Author Xiong Dongyan
# Edit time
#===================================================================

library(Biostrings)
setwd('C:/Users/admin/DeskTop/ASFv_MLST/U184662')
myfasta<-readDNAStringSet("U18466.2.fasta")
mygff3<-read.table("u18466genes.gff3",sep = '\t')
myget_seq<-DNAStringSet()
for (i in 1:nrow(mygff3)) {
  left_loc<-mygff3[i,4]
  right_loc<-mygff3[i,5]
  if(mygff3[i,7]=="+"){seq<-toString(myfasta[[1]][left_loc:right_loc])}
  else{seq<-toString(reverseComplement(myfasta[[1]][left_loc:right_loc]))}
  names(seq)<-paste(names(myfasta[1]),"_",i,sep = "")
  myget_seq<-c(myget_seq,DNAStringSet(seq))
}
out<-tempfile()
writeXStringSet(myget_seq,out)
