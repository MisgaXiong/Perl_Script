#!/usr/bin/perl

=head1 Name

	prepare_dl_phage.pl - Paste Phage_name with ftp address

=head1 DESCRIPTION

	This perl script must use with other two shell script: upd_phage_genomedatabase.sh and download_refgenome.sh.
	If you want to build a total phage genome database or update your phage genome database, you can use these three script.


=head1 Author

	Xiong Dongyan

=head2 Usage


	1.Use your Google browser to search ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/viral/
	2.Ctrl + A to copy all the webpage content and paste it into a txt-file named as phage_gnm1.txt-file
	3.Upload phage_gnm1.txt onto server zhangxx@159.226.126.86
	4.Input sh ~/env_perl/usebash/upd_phage_genomedatabase.sh (This script can call the other two scripts)


=head3 Edit time
	Created in 2019-02-19 13:28

=cut




my $input = shift or die;
open (file, "<", $input);
my $j = 0;
my @download;
while (<file>){
	chomp($_);
	my $i = "ftp://ftp.ncbi.nlm.nih.gov/genomes/refseq/viral/$_";
	@download[$j] = $i."\n";
	$j = $j + 1;
};
print @download;
