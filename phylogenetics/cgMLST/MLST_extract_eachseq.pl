#!/usr/bin/perl
use Bio::SeqIO;

=head1 Name

	MLST_extract_eachseq.pl

=head1 Description

	After cgMLST analyzed a matrix record each sample genes consistency information and cg_allele genes will get. 
	The first thing is to assign the sequence to each sample, this step can use the R script created by Xiong Dongyan.
	Second, each genes belong to each sample need to be exctract into each file, this can use this perl script.



=head2 Usage

	perl MLST_extract_eachseq.pl Routput_total_fasta_file sample_name > sample_name.fasta

=head2 Author

	Xiong Dongyan

=head3 Edit time

	2019-02-26 22:48

=cut


my $total_seq = $ARGV[0];
my $exctract_id = $ARGV[1];
my $fasta_total_seq = Bio::SeqIO->new(
	-file => $total_seq,
	-format => 'fasta',
);
my %Each_seq;
while (my $seq = $fasta_total_seq->next_seq()) {
	my $id = $seq -> id;
	$id = ">".$id;
	my $seq_seq = $seq -> seq;
	if($id =~ m/$exctract_id/){$Each_seq{$id} = "\n".$seq_seq."\n"}
	else{%Each_seq = %Each_seq};
};
print %Each_seq;
