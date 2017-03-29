#!/bin/bash
tar xpvf input.tar
source /etc/profile.d/modules.sh 
module load gcc41/R-3.0.1
mkdir Rpackages
R CMD BATCH --vanilla --quiet runRScriptOptimizationAlgorithm.R outputR.Rout


