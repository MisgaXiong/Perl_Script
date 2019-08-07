#!/usr/bin/perl -w

=head1 Name

	Sub_readsFastq.pl
	
=head1 Description

	Extract sub reads from PE fastq file. 
	Not: PE fastq file need raw or clean (trimomatic) fastq file by trim. (only contain paire reads)
	
=head2 Usage

	perl Sub_readsFastq.pl total_fastq_lins percent_sub R1.fastq R2.fastq
	
=head2 Author

	Dongyan Xiong
	
=head3 Edit time

	2019-08-07 16:22	1.0	
	
=cut

sub max{

	my @arr = @_;
	
	my $max_num = $arr[0];
	
	for(my $i=0; $i<scalar(@arr); $i+=1,){
	
		if($max_num <= $arr[$i]){
		
			$max_num = $arr[$i];
		
		}
		else{
		
			next;
		
		}
	
	}

	return $max_num;

}

my $fastq_line = $ARGV[0];

my $per = $ARGV[1];

my $rand_num = int($fastq_line/4*$per);

my %rand_hash; 

my @rand_hash;

while(@rand_hash < $rand_num){

	my $num = int(rand($fastq_line/4));
	
	$num = 4*$num-3;
	
	push @rand_hash, $num."\n" if (!exists $rand_hash{$num});
	
	$rand_hash{$num} = 1;

}

my @rand_hash_sort = sort { $a <=> $b } @rand_hash;

if($rand_hash_sort[0]<0){

	shift @rand_hash_sort;

};

my $mx = max(@rand_hash_sort);

my @out_fq1;

open(FASTQ1, "<", $ARGV[2]);

my $i = 1;

my $k = 0;

while(my $id = <FASTQ1>){
	
	my $res;
	
	if($i."\n" eq $rand_hash_sort[$k]){
	
		$k += 1;
		
		$res = "TRUE";
	
	}
	else{
	
		$res = "FALSE";
	
	}
	
	if($res eq "TRUE"){
		
		push @out_fq1, $id;
		
		my $sequence = <FASTQ1>;
		
		push @out_fq1, $sequence;
		
		my $comment = <FASTQ1>;
		
		push @out_fq1, $comment;
		
		my $quality = <FASTQ1>;
		
		push @out_fq1, $quality;
		
		$i+=4;
	
	}
	elsif($i > $mx){
	
		last;
	
	}
	else{
	
		$i+=1;
	
	}
	

}

open(FASTQ2, "<", $ARGV[3]);

$i = 1;

$k = 0;

my @out_fq2;

while(my $id = <FASTQ2>){
	
	my $res;
	
	if($i."\n" eq $rand_hash_sort[$k]){
	
		$k += 1;
		
		$res = "TRUE";
	
	}
	else{
	
		$res = "FALSE";
	
	}
	
	if($res eq "TRUE"){
		
		push @out_fq2, $id;
		
		my $sequence = <FASTQ2>;
		
		push @out_fq2, $sequence;
		
		my $comment = <FASTQ2>;
		
		push @out_fq2, $comment;
		
		my $quality = <FASTQ2>;
		
		push @out_fq2, $quality;
		
		$i+=4;
	
	}
	elsif($i > $mx){
	
		last;
	
	}
	else{
	
		$i+=1;
	
	}
	

}

open(OUT1, ">>", "sub-R1.fastq");

print OUT1 @out_fq1;

open(OUT2, ">>", "sub-R2.fastq");

print OUT2 @out_fq2;
