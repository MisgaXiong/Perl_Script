#!/usr/bin/perl

=head1 Name


	rm_blast_byinput.pl Extract best blast result by input.


=head1 Description





	perl rm_blast_byinput.pl length identity Subid

	length is the shortest length you want the query seq alignment
	identity is the min rate you want the query seq alignment
	Subid is the subseq name you want control, if you don't need it, you don't need input





=head2 Author


	Xiong Dongyan


=head3 Edit time

	2019-02-19 23:46


=cut




@ARVG;
my $input_blast = $ARGV[0];
($input_len, $input_ide, $input_sunject)  = ($ARGV[1], $ARGV[2], $ARGV[3]);
open(file, "<", $input_blast);
my @blast_res;
my $i = 0;
while (<file>) {
	my @lit_blast_res = split/\t/,$_;
	if(@lit_blast_res[2] >= $input_ide and @lit_blast_res[3] >= $input_len){@blast_res[$i] = $_}
	else{@blast_res = @blast_res};
	$i = $i + 1;
};
if(length($input_sunject) < 1){@blast_res = @blast_res}
else{
	for (my $j=0; $j<@blast_res; $j++,){
			my @lit2_blast_res = split/\t/,@blast_res[$j];
			$_ = @lit2_blast_res[1];
			if(m/$input_sunject/){@blast_res[$j] = @blast_res[$j]}
			else{@blast_res[$j] = ""}
	}
};
print @blast_res;
