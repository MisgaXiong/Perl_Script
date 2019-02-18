#!/usr/bin/perl
use strict;
=head1 NAME

    upd_ncbiblastdb.pl - Updata local blast database.

=head2 Usage
	Usage: perl upd_ncbiblastdb.pl databaseyouwantupdate.txt
	Advice to use vi to creat databaseyouwantupdate.txt
=head1 DESCRIPTION
All the database can be update are as follows:
    16SMicrobial
	cdd_delta
	env_nr
	env_nt
	est
	est_human
	est_mouse
	est_others
	gss
	gss_annot
	htgs
	human_genomic
	landmark
	nr
	nt
	other_genomic
	pataa
	patnt
	pdbaa
	pdbnt
	ref_prok_rep_genomes
	ref_viroids_rep_genomes
	ref_viruses_rep_genomes
	refseq_genomic
	refseq_protein
	refseq_rna
	refseqgene
	sts
	swissprot
	taxdb
	tsa_nr
	tsa_nt
	vector

=head1 AUTHOT

    Xiong Dongyan

=head1 VERSION

    0.0.1   2019-02-18

=cut

my $update_db_name = shift or die;
open file, "<", $update_db_name;
while (<file>) {
	chomp($_);
	system("cd ~/software/ncbi-blast-2.7.1+/database/");
	system("perl ~/software/ncbi-blast-2.7.1+/bin/update_blastdb.pl --decompress $_");
};
print "Success!";
