#!/bin/bash
tar cpvf allForGRID.tar lib/Experiment.R lib/Optimization/* run* lib/MySQLInterface/*
scp allForGRID.tar pabreu@ui01.ncg.ingrid.pt:
