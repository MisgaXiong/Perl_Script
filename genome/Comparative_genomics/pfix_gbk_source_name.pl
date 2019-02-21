#!/usr/bin/perl

=head1 Name

	pfix_gbk_source_name.pl 

=head1 Description


	Use before use fix_gbk_source_name.pl to prepear some useful file.



=head2 Usage


	perl pfix_gbk_source_name.pl gbkfile

=head2 Author


	Xiong Dongyan

=head3 Edit time

	2019-02-21 20:18

=cut

@ARGV;
my $input_id = $ARGV[0];
$input_id =~ s/\./\:/g;
my @in_id = split/:/,$input_id;
my $id = @in_id[0];
print "$id\n";
