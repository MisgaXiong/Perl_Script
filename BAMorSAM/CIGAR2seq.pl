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
	2019-07-22 19:32	1.1 Enhance model accuracy
	
=cut


sub CIRAG_count {

	my $CIGAR_num = $_[0];
	
	my @dig = split/\D/,$CIGAR_num;
	
	my @let = split/\d+/,$CIGAR_num;
	
	my @len_subread;
	
	my $start_len = @dig[0];
	
	for(my $i=0; $i<scalar(@dig); $i+=1,){
	
		if($i == 0){
			
			my $st = 0;
			
			push @len_subread, $st;
		
		}
		else{
			
			if($let[$i+1] eq "D" or $let[$i+1] eq "H"){
			
				$start_len = $start_len;
				
				push @len_subread, $start_len;
			
			}
			else{
				
				push @len_subread, $start_len;
				
				$start_len += $dig[$i];
			
			}
		
		}
	
	}
	
	return @len_subread;

}

open(file, "<", $ARGV[0]);

my @seq_CIGAR_dev;

while(<file>){
	
	my @BAM_line = split/\t/,$_;
	
	my ($read_id, $CIGAR_num, $BAM_seq) = ($BAM_line[0], $BAM_line[5], $BAM_line[9]);
	
	my @dig = split/\D/,$CIGAR_num;
	
	my @let = split/\d+/,$CIGAR_num;
	
	push @seq_CIGAR_dev, $read_id."\t";
	
	my @sub_read_start = CIRAG_count($CIGAR_num);
	
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
				
				$seq = substr($BAM_seq, $sub_read_start[$i], $dig[$i]);
				
				$seq = $let[$i+1]." ".$seq."\t";
			
				push @seq_CIGAR_dev, $seq;
			
			}
		
		}
	
	}
	
	push @seq_CIGAR_dev, "\n";
	
}

print @seq_CIGAR_dev;
