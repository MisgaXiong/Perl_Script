#!/usr/bin/perl

=head1 Name

	split_chromosome2eachfa.pl

=head1 Description

	When use bacth entrez or some other way to download fasta sequences into one file, it can use to split each chromosomes into each file
	PS: one specie has n chromosomes, you donwload x whole genome fasta, that means you may want x fasta files to contain each n chromosomes.
	Note: before you use line 41 need change, it this script, $j = $j + 2 that means this example has 2 chromosomes, if have x chromosomes, $j = $j + n

=head2 Usage

	perl split_chromosome2eachfa.pl total.fasta

=head2 Author

	Xiong Dongyan

=head3 Edit time

	2019-02-28 16:31

=cut

use Bio::SeqIO;
my $input_file = $ARGV[0];
my $Muti_seq = Bio::SeqIO->new(
	-file => $input_file,
	-format => 'fasta',
);
my @total_fa;
my $i = 0;
while (my $seq = $Muti_seq->next_seq()){
	my $seq_id = $seq -> id;
	my $seq_seq = $seq -> seq;
	@total_fa[$i] = ">".$seq_id."\n".$seq_seq."\n";
	$i += 1;
};
for (my $j=0; $j<@total_fa; $j=$j+2){
	my @out_seq = (@total_fa[$j], @total_fa[$j+1]);
	open(OUT, ">$j.fasta");
	print OUT "@out_seq";
	close OUT;
};
