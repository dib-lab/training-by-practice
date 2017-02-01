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
awk 'BEGIN { OFS = "\t" } { $13 = $3 - $2 } 1' hg19.coding_subset.bed > hg19.coding_subset.length.bed

## Task6: starting with the original input file, we need to edit column 1 to remove the "chr" prefix in the chromosome name. For example, we will change chr17 to 17. Save the new file under the name "hg19.coding_subset.ensFormat.bed"

#This appears to only delete the chr from column 1
sed 's/chr//1' hg19.coding_subset.bed > hg19.coding_subset.ensFormat.bed

#OR since "chr" is at the beginning of every line, this also appears to work
sed 's/^chr//' hg19.coding_subset.bed > hg19.coding_subset.ensFormat.bed

## Task7: We need to collect transcripts that are labeled as "EnsCodingFull" in column 4. Save the new file under the name "hg19.coding_subset.EnsCodingFull.bed"
awk '/EnsCodingFull/' hg19.coding_subset.bed > hg19.coding_subset.EnsCodingFull.bed

#Or if we want to specifically look for this label in column 4, this seems to work:
awk '$4 ~ /EnsCodingFull/' hg19.coding_subset.bed > hg19.coding_subset.EnsCodingFull.bed


## Task8: compare the 2 files: hg19.coding_subset.bed and hg19.coding_subset.EnsCodingFull.bed to see which lines have removed.
grep -F -x -v -f hg19.coding_subset.EnsCodingFull.bed hg19.coding_subset.bed > hg19.coding_subset.diff.bed
#to get file from all other lines not in EnsCodingFull file
#can use wc -l to determine number of lines not in EnsCodingFull file

## Task9: Cut the last 2 lines from the file "hg19.coding_subset.bed". Save in "hg19.coding_subset.truncated.bed"
head -n -2 hg19.coding_subset.bed > hg19.coding_subset.truncated.bed

## Task10: Count how many transcripts have 5 exons
awk '$10==5' hg19.coding_subset.sorted.bed | wc -l

## Task11: check how many lines do you have in all the bed files in your folder
wc -l *

## Task12: find isoforms of that have the same start co-ordinates in hg19.coding_subset.bed
sort -k1,1 -k2,2n hg19.coding_subset.bed > hg19.coding_subset.sort1_2.bed
sort -k1,1 -k2,2n hg19.coding_subset.bed | awk 'BEGIN {OFS = "\t"} {print $1, $2}' | uniq -d > hg19.coding_subset.uniq1_2.bed
grep -f hg19.coding_subset.uniq1_2.bed hg19.coding_subset.sort1_2.bed > hg19.coding_subset.isoforms.bed

## Task13: make a for loop to go through all bed files in the folder. For each bed file, count the no of transcripts on the negative strand. Save file names and corresponding counts in a single output file. Name the output file trans_negative.count

#save following in trans_negative.count.sh file
for bedfile in *.bed
do
	echo -n "$bedfile : "; awk '$6 ~ /-/ {n++} END {print n}' $bedfile
done > trans_negative.count

#in terminal
./trans_negative.count.sh > trans_negative.count

## Task14: starting with the original input file, make a new column that has the length of coding sequence of each transcript. For example, a transcript that has 3 exons and their lengthes are 100,150,and 200, its length will be 100+150+200=450 bp. Save the new file under the name "hg19.coding_subset.coding_length.bed". Notice the difference from task no 5
awk '{print $11}' hg19.coding_subset.bed | awk -F"," '{for(i=1; i<=NF; i++) x+=$i; print x}' > length.bed 

#if you like the new column at the very end:
paste hg19.coding_subset.bed length.bed > hg19.coding_subset.coding_length.bed

#I like the new column right after the 11th column so the total length of coding sequence comes right after exon sizes
cut -f1-11 hg19.coding_subset.bed > columns1_11.bed
cut -f12 hg19.coding_subset.bed > column12.bed

paste columns1_11.bed length.bed column12.bed > hg19.coding_subset.coding_length.bed

