#!/usr/bin/perl

=head1 Name

	split_totalgbk2eachgbk.pl

=head1 DESCRIPTION

	before use this script, the total gbk file must use sed command to delete http://


=head1 Author

	Xiong Dongyan

=head2 Usage

	sed -i 's/http\:\/\///g' your_total_gbk_file
	perl split_totalgbk2eachgbk.pl your_total_gbk_file
	


=head3 Edit time
	Created in 2019-03-08 22:57

=cut

my $input_file = $ARGV[0];
open(file, "<", $input_file);
my @total_file;
my $j = 0;
$each_file;
while (<file>) {
	if(/\/\//){
		@total_file[$j] = $each_file;
		$j += 1;
		undef $each_file;
	}
	elsif(m/[A-Za-z0-9"]/){$each_file = $each_file.$_}
	else{$each_file = $each_file};
};
for (my $i=0; $i<@total_file; $i +=1,){
	my @add_file = @total_file[$i];
	push @add_file, "//\n";
	my @out_put = @add_file;
	my @pro = @total_file[$i];
	my @first_line = split/ +/,@pro[0];
	my $seq_id = @first_line[1];
	open(OUT, ">$seq_id.gb");
	print OUT "@out_put";
	close OUT;
};
