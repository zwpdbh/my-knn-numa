#!/bin/bash

main=$1

echo
echo "-------------------SIFT:"
echo
echo Linear:
$main linear 5 8 16 0.7 0.3 ../features/_DSC0%s.jpg ../features/gps-sift-median.csv
echo
echo KDtree:
$main kdtree 8 8 16 0.7 0.3 ../features/_DSC0%s.jpg ../features/gps-sift-median.csv
echo
echo Kmeans:
$main kmeans 5 8 16 0.7 0.3 ../features/_DSC0%s.jpg ../features/gps-sift-median.csv
echo
echo RBC:
$main rbc 9 8 16 0.7 0.3 ../features/_DSC0%s.jpg ../features/gps-sift-median.csv

echo
echo "-------------------Random:"
echoing
echo Linear:
$main linear 5 16 32 0 0 ../features/_DSC0%s.jpg ../features/gps-random-median.csv
echo
echo KDtree:
$main kdtree 35 16 32 0 0 ../features/_DSC0%s.jpg ../features/gps-random-median.csv
echo
echo Kmeans:
$main kmeans 35 16 32 0 0 ../features/_DSC0%s.jpg ../features/gps-random-median.csv
echo
echo RBC:
$main rbc 30 16 32 0 0 ../features/_DSC0%s.jpg ../features/gps-random-median.csv

echo
echo "-------------------Madelon:"
echo
echo Linear:
$main linear 2 8 16 0 1 ../features/%s ../features/madelon.csv
echo
echo KDtree:
$main kdtree 8 8 16 0 1 ../features/%s ../features/madelon.csv
echo
echo Kmeans:
$main kmeans 16 8 16 0 1 ../features/%s ../features/madelon.csv
echo
echo RBC:
$main rbc 10 8 16 0 1 ../features/%s ../features/madelon.csv

echo
echo "-------------------HAR:"
echo
echo Linear:
$main linear 3 8 16 0.3 0.7 ../features/%s ../features/X.csv
echo
echo KDtree:
$main kdtree 17 8 16 0.3 0.7 ../features/%s ../features/X.csv
echo
echo Kmeans:
$main kmeans 3 8 16 0.3 0.7 ../features/%s ../features/X.csv
echo
echo RBC:
$main rbc 7 8 16 0.3 0.7 ../features/%s ../features/X.csv


echo
echo "-------------------Digit:"
echo
echo Linear:
$main linear 3 4 16 1 0 ../features/%s ../features/optdigits.csv
echo
echo KDtree:
$main kdtree 2 4 16 1 0 ../features/%s ../features/optdigits.csv
echo
echo Kmeans:
$main kmeans 1 4 16 1 0 ../features/%s ../features/optdigits.csv
echo
echo RBC:
$main rbc 4 4 16 1 0 ../features/%s ../features/optdigits.csv

