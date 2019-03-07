# refgenome/ Folder containing the genomes from which schema will be created. Alternatively a file containing the path to the list of reference genomes. 
# ./genomes.fa/ Folder containing the query genomes means the genomes you interested in.
# https://github.com/theInnuendoProject/chewBBACA

chewBBACA.py CreateSchema -i ./refgenome/ -o Step1_refgenes --cpu 12
cd Step1_refgenes && rm Bsuis* #leave only one reference genome
cd short && rm Bsuis*
cd ../
cd ../
chewBBACA.py AlleleCall -i ./genomes.fa/ -g Step1_refgenes/ -o Step2_allelecall_use_wgMLST --cpu 12
chewBBACA.py TestGenomeQuality -i Step2_allelecall_use_wgMLST/results_20190303T161746/results_alleles.tsv -n 12 -t 200 -s 5 -o Step3_Evaluate_wgMLST_call_quality
chewBBACA.py ExtractCgMLST -i Step2_allelecall_use_wgMLST/results_2019030T161756/results_alleles.tsv -o Step4_cgMLST_use_alleletsv
chewBBACA.py SchemaEvaluator -i Step1_refgenes/ -ta 11 -l rms/ratemyschema.html --cpu 12 --title "my title"
