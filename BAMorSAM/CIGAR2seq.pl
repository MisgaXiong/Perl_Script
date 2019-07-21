#!/usr/bin/perl

=head1 Name


	CIGAR2seq.pl
	
=head1 Description

	Use CIGAR to split reads
	
=head2 Usage

	samtools view BAM/SAM | head -n x > BAM/SAM_info.txt
	perl CIGAR2seq.pl > seqwithCIGAR.txt
	
=head2 Author

	Dongyan Xiong
	
=head3 Edit time

	2019-07-21 22:23	1.0	
	
=cut



open(file, "<", $ARGV[0]);

my @seq_CIGAR_dev;

while(<file>){
	
	my @BAM_line = split/\t/,$_;
	
	my ($read_id, $CIGAR_num, $BAM_seq) = ($BAM_line[0], $BAM_line[5], $BAM_line[9]);
	
	my @dig = split/\D/,$CIGAR_num;
	
	my @let = split/\d+/,$CIGAR_num;
	
	push @seq_CIGAR_dev, $read_id."\t";
	
	for(my $i=0; $i<scalar(@dig); $i+=1){
		
		my $seq;
		
		if($i == 0){
			
			if($let[$i+1] eq "D"){
			
				$seq = "-" x $dig[$i];
				
				$seq = $let[$i+1]." ".$seq."\t";
				
				push @seq_CIGAR_dev, $seq;
			
			}
			else{
			
			$seq = substr($BAM_seq, 0, $dig[$i]);
			
			$seq = $let[$i+1]." ".$seq."\t";
			
			push @seq_CIGAR_dev, $seq;
			
			}
		
		}
		else{
		
			if($let[$i+1] eq "D"){
			
				$seq = "-" x $dig[$i];
				
				$seq = $let[$i+1]." ".$seq."\t";
				
				push @seq_CIGAR_dev, $seq;
			
				}
			else{
			
				if($let[$i] eq "D"){
				
					$seq = substr($BAM_seq, $dig[$i-2], $dig[$i]);
				
				}
				elsif($let[$i] eq "I"){
				
					$pos = $dig[$i-2]+$dig[$i-1];
				
					$seq = substr($BAM_seq, $pos, $dig[$i]);
				}
				else{
				
					$seq = substr($BAM_seq, $dig[$i-1], $dig[$i]);
				
				}
				
				$seq = $let[$i+1]." ".$seq."\t";
			
				push @seq_CIGAR_dev, $seq;
			
			}
		
		}
	
	}
	
	push @seq_CIGAR_dev, "\n";
	
}

print @seq_CIGAR_dev;
