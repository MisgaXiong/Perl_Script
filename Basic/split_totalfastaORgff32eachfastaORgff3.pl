#!/usr/bin/perl

=head1 Name

	split_totalfastaORgff32eachfastaORgff3.pl

=head1 DESCRIPTION

	If you use batch entrez to download the total fasta or gff3 file and you want each sequence into each file, you can use this script


=head1 Author

	Xiong Dongyan

=head2 Usage

	perl split_totalfastaORgff32eachfastaORgff3.plyour_total_gff3_file
	perl split_totalfastaORgff32eachfastaORgff3.plyour_total_fasta_file
	


=head3 Edit time
	Created in 2019-03-16 18:00

=cut

my $input_file = $ARGV[0];
if ($input_file =~ m/gff3/) {
	open(file, "<", $input_file);
	my @total_file;
	my $j = 0;
	$each_file;
	while (<file>) {
		if(/\A\s*\Z/){
			@total_file[$j] = $each_file;
			$j += 1;
			undef $each_file;
		}
		else{$each_file = $each_file.$_};
	};
	for (my $i=0; $i<@total_file; $i +=1,){
		my @out_put = @total_file[$i];
		my @pro = @total_file[$i];
		my @first_line = split/ +/,@pro[0];
		my $seq_id = @first_line[1];
		open(OUT, ">$seq_id.gff3");
		print OUT "@out_put";
		close OUT;
	};
}
else{
	open(file, "<", $input_file);
	my @total_file;
	my $j = 0;
	$each_file;
	while (<file>) {
		if(/\A\s*\Z/){
			@total_file[$j] = $each_file;
			$j += 1;
			undef $each_file;
		}
		else{$each_file = $each_file.$_};
	};
	for (my $i=0; $i<@total_file; $i +=1,){
		my @out_put = @total_file[$i];
		my @pro = @total_file[$i];
		my @first_line = split/ +/,@pro[0];
		my $seq_id = @first_line[0];
		$seq_id =~ s/\>//g;
		open(OUT, ">$seq_id.fasta");
		print OUT "@out_put";
		close OUT;
	};
};
