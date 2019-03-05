#!/usr/bin/perl

=head1 Name

	MLST_sort_eachfa.pl

=head1 Description

	This perl script is the second step after MLST_extract_eachseq.pl



=head2 Usage

	perl MLST_sort_eachfa.pl unsort.fasta > sorted.fasta

=head2 Author

	Xiong Dongyan

=head3 Edit time

	2019-02-28 15:54

=cut



use Bio::SeqIO;
my $input_each_fasta = $ARGV[0];
my $each_fa_seq = Bio::SeqIO->new(
	-file => $input_each_fasta,
	-format => 'fasta',
);
my @seq_id;
my $each_name;
my $i = 0;
while (my $seq = $each_fa_seq->next_seq()) {
	my $id = $seq -> id;
	my @new_id = split/_/,$id;
	my $get_id_num = @new_id[3];
	@seq_id[$i] = $get_id_num."\n";
	$i += 1;
	$each_name = @new_id[0]."_".@new_id[1]."_".@new_id[2]
};
my @seq_id_sort = sort { $a <=> $b } @seq_id;
my @sort_each_fa;
my $j = 0;
while ($j<@seq_id_sort) {
	my $sort_seq = $each_name."_".@seq_id_sort[$j];
	chomp $sort_seq;
	my $each_fa_seq = Bio::SeqIO->new(
	-file => $input_each_fasta,
	-format => 'fasta',);
	while (my $seq = $each_fa_seq->next_seq()) {
	my $id = $seq -> id;
	my $id2 = ">".$id;
	my $seq_seq = $seq -> seq;
	if($sort_seq."_" eq $id){@sort_each_fa[$j] = $id2."\n".$seq_seq."\n"};
	};
	$j += 1;
};
print @sort_each_fa;
