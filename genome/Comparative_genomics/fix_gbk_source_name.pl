#!/usr/bin/perl

=head1 Name

	fix_gbk_source_name.pl 

=head1 Description


	Use in change gbk file's source name when analyz the Comparative genomics file created by prokka.



=head2 Usage


	perl fix_gbk_source_name.pl gbkfile

=head2 Author


	Xiong Dongyan

=head3 Edit time

	2019-02-21 19:36

=cut

@ARGV;
my $input_id = $ARGV[0];
my $input_file = $ARGV[0];
$input_id =~ s/\./\:/g;
my @in_id = split/:/,$input_id;
my $id = @in_id[0];
open(file, "<", $input_file);
my @output;
my $j = 0;
while (<file>) {
	if(m/Genus species/){$_ =~ s/Genus species/$id/}
	else{$_ = $_};
	@output[$j] = $_;
	$j = $j + 1;
}
print @output;
