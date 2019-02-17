#!/usr/bin/perl

#===============================================================
#Use: Count the GC content of each fasta sequence
#Author: Xiong Dongyan
#===============================================================
use strict;
use Bio::SeqIO;
my $input_mutiseq_file = << "EOS";
Usage:
  each_seq_GCcount.pl <fasta file>
EOS
my $Muti_seq_file = shift or die $input_mutiseq_file;
my $Muti_seq = Bio::SeqIO->new(
	-file => $Muti_seq_file,
	-format => 'fasta',
);
my @GC_count;
my $j = 1;
while (my $seq = $Muti_seq->next_seq()) {
	my $id = $seq -> id;
	my $seq_seq = $seq -> seq;
	my $seq_length = length$seq_seq;
	my @split_seq = split//,$seq_seq;
	my $GC_count;
	for (my $i=0; $i<@split_seq; $i= $i+1,){
		if(@split_seq[$i] eq "G"){$GC_count = $GC_count + 1}
		elsif(@split_seq[$i] eq "C"){$GC_count = $GC_count + 1}
		else{$GC_count = $GC_count}
	};
	$GC_count = $GC_count/$seq_length;
	@GC_count[$j] = $id . "\t" . "GC count= " . $GC_count . "\n";
	$j = $j + 1;
};
print @GC_count;
