#!/bin/bash

# Aaron Martin


#The purpose of this script is to allow for the user to search a txt file using a search term/pattern.
#The matching searches will then be returned to the user, along with the corresponding line number and a total count.
#The user is able to perform a search for a whole word match or any match in a line.
#This searchlog script uses grep to perform searches.
#If a different file needs to be searched, code containing "access_log.txt" will need to be swapped out for the new file name.

#Prompt and receive search pattern from user
read -p "Please enter pattern to be searched for: " pattern

#Function to allow user to enter a new search pattern
newsearch(){
    read -p "Please enter new pattern to be searched for: " pattern
}

#Function performs a whole word match using the pattern the user entered.
wholeword() {
    echo "You have selected a whole word match"

    #Retrieves a count of matching lines from the search pattern
    grepcheck="$(grep -iwnc $pattern access_log.txt)"

    #Checks if matches were found
    if [[ $grepcheck -gt 0 ]]; then
        #Prompts user to invert the match or not
        read -p "Would you like to invert the match? (y/n): " invinput
	    if [[ $invinput == "y" ]]; then
            #Retrieves new count for matches
            grepcheck="$(grep -iwnvc $pattern access_log.txt)"
            echo "$grepcheck matches found"
            #Outputs matching lines to terminal and to a new file for further use
            grep -iwnv $pattern access_log.txt
		    grep -iwnv $pattern < access_log.txt > newtxt.txt
	    elif [[ $invinput == "n" ]]; then
            #Retrieves new count for matches
            grepcheck="$(grep -iwnc $pattern access_log.txt)"
            echo "$grepcheck matches found."
            #Outputs matching lines to terminal and to a new file for further use
            grep -iwn $pattern access_log.txt
            grep -iwn $pattern < access_log.txt > newtxt.txt
        else
            echo "Invalid input."
        fi
    else
        echo "No matches found."
    fi
}

#Function performs search for any match on the line
anymatch(){
    echo "You have selected any match on the line"

    #Retrieves a count of matching lines from the search pattern
    grepcount="$(grep -nic $pattern access_log.txt)"

    #Checks if matches were found
    if [[ $grepcount -gt 0 ]]; then
        #Prompts user to invert the match or not
        read -p "Would you like to invert the match? (y/n): " invinput2
	    if [[ $invinput2 == "y" ]]; then
            #Retrieves new count for matches
            grepcount="$(grep -nicv $pattern access_log.txt)"
            echo "$grepcount matches found"
            #Outputs matching lines to terminal and to a new file for further use
            grep -ivn $pattern access_log.txt
	        grep -ivn $pattern < access_log.txt > newtxt.txt
 	    elif [[ $invinput2 == "n" ]]; then
            #Retrieves new count for matches
            grepcount="$(grep -nic $pattern access_log.txt)"
            echo "$grepcount matches found"
            #Outputs matching lines to terminal and to a new file for further use
            grep -ni $pattern access_log.txt
            grep -ni $pattern < access_log.txt > newtxt.txt
        else
            echo "Invalid input"
        fi
    else
        echo "No matches found."
    fi
}


#Uses a while loop to provide a menu for the user, allowing the user to perform multiple searches for
# a whole word match, any match on the line or do a completely new search pattern or quit the
#program. This loop control structure also accounts for invalid input.
while true; do
    echo "1) whole word match"
    echo "2) any match on the line"
    echo "3) new search"
    echo "4) quit"

    #Prompt the user to select an option from the menu
	read -p "Please select an option from the menu [1, 2, 3 or 4]: " menupick
    case $menupick in 
        1) wholeword;;
        2) anymatch;;
        3) newsearch;;
        4) exit 1;;
        *) echo "Invalid selection, please try again.";;
    esac    
done

exit 0
