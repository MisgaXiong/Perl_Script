#!/usr/bin/perl

use POSIX;


=head1 Name


	Describe_BAMflag.pl

	
=head1 Description


	Describe the reads alignment information

	
=head2 Usage


	samtools view BAM/SAM | head -n x > BAM/SAM_info.txt
	perl Describe_BAMflag.pl BAM/SAM_info.txt

	
=head2 Author


	Dongyan Xiong

	
=head3 Edit time


	2019-07-20 19:51

	
=cut



sub Ten2Two {

	my $mun = $_[0];
	
	
	my @two;
	
	while($mun > 0){
		
		my $t = $mun % 2;
		
		push @two, $t;
		
		$mun = floor($mun/2);
		
		if($mun == 1) {
		
			push @two, 1;
			
			last;
		
		}
		else{
			
			next;
			
		}
	};
	
	my $ten2two = reverse(@two);
	
	return $ten2two;
}


my $input_bamrecord = $ARGV[0];

open(file, "<", $input_bamrecord);

my %FLAG_describe = (
						1 => "Pair End" ,
						
						10 => "Normal Alignment",
						
						100 => "Not Alignment",
						
						1000 => "PE Another not Alignment",
						
						10000 => "Reversecomplementary Alignment",
						
						100000 => "PE Another Reversecomplementary Alignment",
						
						1000000 => "PE Read1",
						
						10000000 => "PE Read2",
						
						100000000 => "Secondaty Alignment",
						
						1000000000 => "Below the Threshold Value",
						
						10000000000 => "PCR Repeat",
						
						100000000000 => "Supplementary alignment",
						
);

my @arr = keys %FLAG_describe;

my @arr_sort = sort { $a <=> $b } @arr;

my @Record_FLAG_info;

while(<file>){

	my @record_line = split/\t/,$_;
	
	my $record_num = $record_line[1];
	
	if($record_num == 0){
		
		push @Record_FLAG_info, "Single End"."\n";
		
	}
	else{
	
		my $FLAG_two = Ten2Two($record_num);
	
		$FLAG_two = reverse($FLAG_two);
	
		@FLAG_num_reverse = split//,$FLAG_two;
	
		my $descibe;
	
		undef $descibe;
	
		for($i=0; $i<scalar(@FLAG_num_reverse); $i+=1,){
	
			if($FLAG_num_reverse[$i] == 1){
		
				$descibe = $descibe.$FLAG_describe{$arr_sort[$i]}."\t";
		
			}else{
		
				next;
		
			}
	
		}
	
		push @Record_FLAG_info, $descibe."\n";
	
	
	}
	
}

print @Record_FLAG_info;
