#!/usr/bin/perl

=head1 Name

	MLST_link_sortfa.pl

=head1 Description

	This perl script is the third step after MLST_sort_each.pl


=head2 Usage

	perl MLST_link_sortfa.pl sort.fasta > linked.fasta

=head2 Author

	Xiong Dongyan

=head3 Edit time

	2019-02-28 16:31

=cut

use Bio::SeqIO;
my $input_sort_fa = $ARGV[0];
my $sort_fa_seq = Bio::SeqIO->new(
	-file => $input_sort_fa,
	-format => 'fasta',
);
my $link_seq;
while (my $seq = $sort_fa_seq->next_seq()) {
	my $id = $seq -> id;
	my @get_id = split/_/,$id;
	$seq_name = @get_id[0]."_".@get_id[1]."_".@get_id[2];
	my $seq_seq = $seq -> seq;
	$link_seq = $link_seq.$seq_seq;
};
my @total_seq = ">".$seq_name."\n".$link_seq."\n";
print @total_seq;
