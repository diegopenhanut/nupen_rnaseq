#!/usr/bin/env bash

# Download expression data

wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA.datafreeze.20120227.xlsx 
wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA.datafreeze.20120227.txt
wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA_annotated_freeze_list.txt
wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA.exp.547.med.txt
wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA.exp.466.med.txt
wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA.exp.348.med.txt
wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA.547.PAM50.SigClust.Subtypes.txt
wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA.Gene_Expression.Level_3.tar
wget -P ../dados --timestamping http://tcga-data.nci.nih.gov/docs/publications/brca_2012/BRCA.Gene_Expression.Level_3.tar.md5
