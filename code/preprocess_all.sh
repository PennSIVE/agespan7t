#!/bin/bash

for outdir in $(find ../data/scitran -type d -name for-mimosa); do
for image in UNI.nii.gz INV1.nii.gz INV2.nii.gz T1map.nii.gz; do
    subj_num=$(echo $outdir | grep -Eo [0-9]{3})
    ss=$(find ../data/from_kelly/${subj_num} -name "*.nii.gz")
    to_process=$(find $outdir -name *${image})
    qsub -b y -cwd -o ~/sge/\$JOB_ID -e ~/sge/\$JOB_ID -l h_vmem=16G \
    ./preprocess.sh $image $ss $to_process $outdir 

done
done


