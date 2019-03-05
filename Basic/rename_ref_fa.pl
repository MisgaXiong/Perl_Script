#!/usr/bin/perl

=head1 Name

	rename_ref_fa.pl

=head1 Description

	After use script download all the reference genome, all the ref-genome file are named like this GCF_xxxxx.fna
	In order to rename it, you can use this script. But remember to check if the >xxxx name are match this perl script's parameter
	Note: It just adviced using rename the virus or bacteria which has less three chromosomes.

=head2 Usage

	perl MLST_extract_eachseq.pl xxx_genome.fna | xargs mv xxx_genome.fna

=head2 Author

	Xiong Dongyan

=head3 Edit time

	2019-03-03 13:24

=cut


use Bio::SeqIO;
my $input_ref_genome = $ARGV[0];
my $get_id_info = Bio::SeqIO->new(
	-file => $input_ref_genome,
	-format => 'fasta',
);
my $ref_name;
open(file, "<", $input_ref_genome);
while (<file>) {
	if(m/\>/){$id = $_}
	my @split_id = split/ /,$id;
	my $id_num = @split_id[0];
	$id_num =~ s/\_//g;
	$id_num =~ s/\>//g;
	$ref_name = "Ref_".$id_num."_"."B".".".@split_id[2].".fa";
}
print $ref_name;
