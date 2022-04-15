#!/bin/bash

# Aaron Martin
# 1052 6100

#The purpose of this script is to count all the empty child directories, non-empty child directories,
#empty txt files, non-empty txt files in a given directory path at command line. The count of each variable is
#outputted to the user.

#store command line path argument into variable
dirname=$1

#Testing purposes.
#dirlength=$(ls $dirname | wc -l)
#echo "There are $dirlength folders in $1"

#Initialise variables to 0.
#These variables will hold the count of each scenario.
emptydir=0
nonemptydir=0
emptytxt=0
nonemptytxt=0

#Loops through each file in the given directory.
for fdir in "$dirname"/*; do
    #Checks if the file has a .txt extension, is the a file a plaintext file?
    if [[ $fdir == *.txt ]]; then
        #Check if the file size is greater than 0.
        #If file is not empty, increment nonemptytxt.
        #If file is empty, increment emptytxt.
        if [ -s $fdir ]; then
            ((nonemptytxt+=1))
        else
            ((emptytxt+=1))
        fi
    else
        #Counts folders within the current file.
        flength=$(ls $fdir | wc -l)

        #Testing purposes.
        #echo "$fdir folder"
        #echo "$flength files"

        #Checks if the file is empty.
        #Increments emptydir if child directory is empty.
        #Increments nonemptydir if child directory is not empty.
        if (($flength == 0)); then
            ((emptydir+=1))
        else
            ((nonemptydir+=1))
        fi
    fi
done

#Output results to the user.
echo "The $dirname directory contains: "
echo "$nonemptytxt text files that contain data"
echo "$emptytxt text files that are empty"
echo "$nonemptydir non-empty directories"
echo "$emptydir empty directories"



exit 0
