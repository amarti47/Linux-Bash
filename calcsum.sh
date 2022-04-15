#!/bin/bash

# Aaron Martin
# 1052 6100

#The purpose of this script is to sum 3 numbers together entered at commandline.
#The sum cannot be greater than 30 as a requirement of this task.

#Adds the 3 integers entered at commandline together.
sum=$(($1+$2+$3))

#If the sum of the integers is greater than 30, print exceeding message
#If the sum is less than or equal to 30, print the sum.
if [[ $sum -gt 30 ]] ; then
    echo "Sum exceeds maximum allowable."
else
    echo "The sum of $1 and $2 and $3 is $sum."
fi

exit 0




