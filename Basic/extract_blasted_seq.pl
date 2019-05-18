#!/usr/bin/perl
use Bio::SeqIO;
my $input_fasta = $ARGV[0];
my $input_align_info = $ARGV[1];
my $align_from_seq = Bio::SeqIO->new(
	-file => $input_fasta,
	-format => 'fasta',
);
my @blasted_seq;
while (my $seq = $align_from_seq->next_seq()) {
	my $id = $seq -> id;
	my $seq_seq = $seq -> seq;
	open (file, "<", $input_align_info);
	while (<file>) {
		my @each_blast_info = split/\t/,$_;
		my $sub_id = @each_blast_info[1];
		if($id eq $sub_id){$star = @each_blast_info[8];
						   $end = @each_blast_info[9];
						   if($star < $end){
											$length = $end - $star + 1;
											$use_seq = substr($seq_seq, $star - 1, $length);
											push(@blasted_seq, ">".$id."\n".$use_seq."\n")}
							else{
								 $length = $star - $end + 1;
								 $use_seq = substr($seq_seq, $end - 1, $length);
								 push(@blasted_seq, ">".$id."\n".$use_seq."\n")};
							}
	    else{next;};
	};
};
print @blasted_seq;
