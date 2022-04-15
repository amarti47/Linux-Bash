#!/bin/bash

# Aaron Martin


#The purpose of this script is to prompt the user to enter values 20 OR 40. 
#Invalid input message will be given if neither 20 OR 40 was entered by the user.

#While loop is used to continue to prompt user until the correct input has been made
while true; do
    #Prompt user for user input
    read -p "Please enter values 20 or 40: " userinput

    #If the user input is 20 or 40, exit the loop
    #If the user input is not 20 or 40, alert user of invalid input, continue loop
    if [[ $userinput = 20 ]] || [[ $userinput = 40 ]]; then
        echo "Valid input was made"
        break
    else   
        echo "Invalid input was made, please enter 20 or 40."
    fi
done

exit 0
