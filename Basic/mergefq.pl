#!/usr/bin/perl -w

=head1 Description

	Merge FASTQ files
	
	Note: All FQ files should be named as abc_R1.fastq.gz which abc could classify each samples
	
	It's better to use the clean data output by trimmomatic from the upstream shell script Dongyan Xiong written
	
=head1 Usage

	perl mergefq.pl
	
=head1 Auther

	Dongyan Xiong
	
=head1 Edit Time
	
	2020.04.20 18:50 0.0.1
	
=cut

use warnings;

use strict;

my @fq_files = glob("*f*q*");

my @ID;

foreach(@fq_files){

	my @line = split/_/,$_;

	push @ID, $line[0];

};

my %count;

my @uniq_ID = grep { ++$count{ $_ } < 2; } @ID;

my (@R1_fq, @R2_fq);

foreach(@uniq_ID){

	for my $i (0..$#fq_files){
	
		my @line = split/_/,$fq_files[$i];

		if($_ eq $line[0] and $fq_files[$i] =~ m/R1\.fastq\.gz/){
		
			push @R1_fq, $fq_files[$i];
		
		}
		elsif($_ eq $line[0] and $fq_files[$i] =~ m/R2\.fastq\.gz/){
		
			push @R2_fq, $fq_files[$i];
		
		}
		else{
		
			next;
		
		}
	
	}

}

my @commands;

push @commands, "#!/usr/bin/bash"."\n";

push @commands, "zcat ".join(" ", @R1_fq)." | gzip - > Cross_R1.fastq.gz"."\n";

push @commands, "zcat ".join(" ", @R2_fq)." | gzip - > Cross_R2.fastq.gz"."\n";

open(OUT, ">", "runMergeFq.sh");

print OUT @commands;
