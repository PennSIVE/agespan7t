#!/bin/bash

cd $(dirname "$0")
for mask in $(find ../data -name "*mks.nii.gz"); do
SINGULARITYENV_MASK=$mask SINGULARITYENV_OUT=$(dirname $mask)/$(basename $mask .nii.gz)-bin.nii.gz singularity run --pwd $PWD --cleanenv /cbica/home/robertft/simg/neuror_4.0.sif Rscript binarize.R
done


