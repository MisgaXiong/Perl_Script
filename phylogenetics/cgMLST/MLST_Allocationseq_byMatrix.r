#=================================================================================
#	Read the cgMLST.tsv (contain each seq Allelic type)
#	Read the aligned-each core gene fasta file
#	Inorder to allocate each seq to each sample
#	Author:	Xiong Dongyan
#	Eidt time:	2019-2-25 13:47
#==================================================================================

setwd('C:/Users/admin/DeskTop/R-MLST')
MLST_matrix<-read.table("cgMLST.tsv",header = T,sep = "\t")
MLST_matrix<-as.matrix(MLST_matrix)
rownames(MLST_matrix)<-MLST_matrix[,1]
MLST_matrix<-MLST_matrix[,2:ncol(MLST_matrix)]
dimnames<-list(rownames(MLST_matrix),colnames(MLST_matrix))
MLST_matrix<-matrix(as.numeric(as.matrix(MLST_matrix)),nrow = nrow(MLST_matrix),dimnames = dimnames(MLST_matrix))
library(stringr)
dir1<-dir('C:/Users/admin/DeskTop/R-MLST/using_genes')
setwd('C:/Users/admin/DeskTop/R-MLST/using_genes')
PT3fastaname<-rownames(MLST_matrix)
library(Biostrings)
fa_total<-DNAStringSet()
for (j in 1:ncol(MLST_matrix)){
  fa_col<-DNAStringSet()
  num<-gsub(pattern="[A-Za-z]+",replacement = "",dir1[j])
  num<-gsub(pattern="2308-",replacement = "",num)
  num<-gsub(pattern="\\.",replacement = "",num)
  Standerdfasta<-readDNAStringSet(dir1[j])
  Matrix_taxno<-MLST_matrix[,j]
  for (i in 1:nrow(MLST_matrix)) {
    faname<-names(Matrix_taxno[i])
    faseqid<-as.numeric(Matrix_taxno[i])
    faseq<-DNAStringSet(toString(Standerdfasta[[faseqid]]))
    names(faseq)<-paste(faname,num,sep = "_")
    fa_col<-c(fa_col,DNAStringSet(faseq))
  }
  fa_total<-c(fa_total,fa_col)
}
out<-tempfile()
writeXStringSet(fa_total,out)
