## obtain the BED file of human coding genes (to read more about BED format: https://genome.ucsc.edu/FAQ/FAQformat#format1)
# 1) download the file from Ulitsky lab website (http://www.weizmann.ac.il/Biological_Regulation/IgorUlitsky/pipeline-lncrna-annotation-rna-seq-data-plar)
wget ftp://ftp-igor.weizmann.ac.il/pub/CLAP/data/hg19.coding.bed.gz
# 2) uncompress the gz file
gunzip hg19.coding.bed.gz 
# 3) creat a smaller BED file for chromosomes 17,18,and 19
grep "^chr1[7-9]" hg19.coding.bed > hg19.coding_subset.bed
# 4) delete the big BED file
rm hg19.coding.bed


## Task1: Print few lines of the file hg19.coding.bed to the screen to check the format of the file
head -n 3 hg19.coding_subset.bed

## Task2: sort the bed file by exon no in ascending order. Name the new file "hg19.coding_subset.sorted.bed" 
sort -n -k 10,10 hg19.coding_subset.bed > hg19.coding_subset.sorted.bed

## Task3: extract transcripts with 3 exons from the sorted file from task2. Name the new file "hg19.coding_subset.3exon.sorted.bed" 
awk '$10==3' hg19.coding_subset.sorted.bed > hg19.coding_subset.3exon.sorted.bed

## Task4: extract transcripts with 3 exons and chr17 from the sorted file from task2. Name the new file "hg19.coding_subset.3exon.chr17.sorted.bed" 
awk '/chr17/' hg19.coding_subset.sorted.bed | awk '$10==3' > hg19.coding_subset.3exon.chr17.sorted.bed

## Task5: starting with the original input file, make a new column that has the length of transcript in the genome. For examle if it starts at 1 and ends at 500 then its length would be 499. Save the new file under the name "hg19.coding_subset.length.bed"
awk '{ $13 = $3 - $2 } 1' hg19.coding_subset.bed > hg19.coding_subset.length.bed

