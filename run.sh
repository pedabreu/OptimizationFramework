#!/bin/bash
tar cpvf input.tar  ./lib/* ./*.sh ./*.R ./*.jdl ./RSourcePackages 
for i in $(seq 1 $1)
do
  glite-wms-job-submit -a runJob$2.jdl
done
