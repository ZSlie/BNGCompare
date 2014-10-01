#!/bin/bash

# qrsh -P KSU-GEN-BIOINFO -l avx=true -pe single 16
DIR="Fly_project/"
FASTA="fasta_basename"
FASTA2="fasta_basename"

#Align scripts
/homes/bioinfo/bioinfo_software/bionano/tools/RefAligner -i ${DIR}${FASTA2}.fasta_QI.cmap -ref ${DIR}${FASTA}.fasta_QI.cmap -o ${DIR}${FASTA}_to_${FASTA2} -res 2.9 -FP 0.8 -FN 0.08 -sf 0.20 -sd 0.10 -extend 1 -outlier 1e-4 -endoutlier 1e-2 -deltaX 12 -deltaY 12 -xmapchim 14 -mres 1.2 -insertThreads 4 -nosplit 2 -f -T 1e-8 -maxthreads 16

#Get most metrics
/homes/sliefert/BNGCompare/BNGCompare.pl -f ${DIR}${FASTA}.fasta -r ${DIR}${FASTA}.fasta_QI.cmap -q ${DIR}${FASTA2}.fasta_QI.cmap -x ${DIR}${FASTA}_to_${FASTA2}.xmap

#Get N50 of last fasta
/homes/sliefert/BNGCompare/N50.pl ${DIR}${FASTA2}.fasta ${DIR}${FASTA}_BNGCompare.csv


#Flip xmap
perl /homes/bioinfo/bioinfo_software/bionano/Irys-scaffolding/KSU_bioinfo_lab/stitch/flip_xmap.pl ${DIR}${FASTA}_to_${FASTA2}.xmap ${DIR}${FASTA2}_to_${FASTA}

perl /homes/bioinfo/bioinfo_software/bionano/BNGCompare/xmap_stats.pl -x ${DIR}${FASTA2}_to_${FASTA}.flip -o ${DIR}${FASTA}_BNGCompare.csv

#Print New Lines for segmentation
echo "\n\n\n" >>  ${DIR}${FASTA}_BNGCompare.csv


