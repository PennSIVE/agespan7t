#!/bin/bash

datalad run -m "run preprocessing" \
    SINGULARITYENV_LABEL=$(basename $1 .nii.gz) SINGULARITYENV_WS_TYPE=$([ $1 = UNI.nii.gz ] && echo "T1" || echo "T2") singularity run --cleanenv -B $2:/mask.nii.gz:ro -B $3:/in.nii.gz:ro -B ~/repos/agespan7t/code:/code -B $4:/out /cbica/home/robertft/simg/neuror_4.0.sif Rscript /code/preprocess.R


