#!/bin/bash

for outdir in $(find ../data/scitran -type d -name for-mimosa); do
for image in UNI.nii.gz INV1.nii.gz INV2.nii.gz T1map.nii.gz; do
    subj_num=$(echo $outdir | grep -Eo [0-9]{3})
    ss=$(find ../data/from_kelly/${subj_num} -name "*.nii.gz")
    to_process=$(find $outdir -name *${image})
    qsub -b y -cwd -o ~/sge/${image}.log -e ~/sge/${image}.log -l h_vmem=16G \
    datalad run -m "run preprocessing" \
    SINGULARITYENV_LABEL=$(basename ${image} .nii.gz) SINGULARITYENV_WS_TYPE=$([ $image = UNI.nii.gz ] && echo "T1" || echo "T2") singularity run --cleanenv -B $ss:/mask.nii.gz:ro -B $to_process:/in.nii.gz:ro -B ~/repos/agespan7t/code:/code -B $outdir:/out /cbica/home/robertft/simg/neuror_4.0.sif Rscript /code/preprocess.R

done
done


