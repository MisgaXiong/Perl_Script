#!/usr/bin/perl
=head1 Name

	trans_gtforgff2bed.pl

=head1 Description


	Use in trans gtf or gff file into bed format



=head2 Usage


	perl yourgtforgfffile > bedfile

=head2 Author


	Xiong Dongyan

=head3 Edit time

	2019-04-21 22:00

=cut

use strict;
use warnings;
my $input_file = $ARGV[0];
open(my $file, "<", $input_file);
my @gene_infor;
while(<$file>){
	my @gene_line_infor = split/\t/,$_;
	my @gene_name;
	my $name_gene;
	my $use_gene2bed;
	if($gene_line_infor[0] =~ m/#/){next;}
	else{
		if($gene_line_infor[2] eq "gene"){
		my @split_description = split/;/,$gene_line_infor[-1];
		if($split_description[0] =~ m/ID=/){
			@gene_name = split/=/,$split_description[0];
			$name_gene = $gene_name[1];
		}
		elsif($split_description[0] =~ m/gene_id/){
			@gene_name = split/ /,$split_description[0];
			$name_gene = $gene_name[1];
			$name_gene =~ s/\"//g;
		}
		$gene_line_infor[-1] = $name_gene;
		$use_gene2bed = $gene_line_infor[0]."\t".$gene_line_infor[3]."\t".$gene_line_infor[4]."\t".$gene_line_infor[-1]."\t".$gene_line_infor[6]."\n";
		push @gene_infor, $use_gene2bed;
	}
	else{next;};
	}
}
print @gene_infor;
