#!/bin/bash
source /etc/profile.d/modules.sh 
module load gcc41/R-3.0.1
tar xpvf input.tar
mkdir Rpackages
R CMD BATCH --vanilla --quiet runRScriptFeatures.R outputR.Rout


