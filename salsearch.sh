#!/bin/bash

#Aaron Martin


#The purpose of this script is to provide user with search functionality for server access logs.

#This function was meant to prompt the user as to the search criteria surrounding packets


packetcheck(){
    while true; do
        echo -e "\n"
        read -p "Enter a value for packets: " userpacket
        echo "Enter search criteria for value $userpacket"
        echo "1) greater than"
        echo "2) less than"
        echo "3) equal to"
        echo "4) not equal to"
        echo "5) return to main menu"

        read -p "Please select an option from the menu [1, 2, 3, 4 or 5 if you wish to return]: " menu3pick
        case $menu3pick in 
            1) return_pc="-gt";break;;
            2) return_pc="-lt";break;;
            3) return_pc="-eq";break;;
            4) return_pc="!(-eq)";break;;
            5) return;;
            *) echo -e "Invalid selection, please try again.";;
        esac
    done
}

#This function prompts the user to enter the name of the single log file they wish to search
singlefile(){
    #declare array
    declare -a arr1

    while true; do
        #list files to the user
        ls *.csv
        #prompt user for file name
        read -p "Please enter the name of one of the files you wish to search: " userpick
        filenames=$(ls *.csv)
        #echo $filenames

        #store filename strings into an array
        arr1=($filenames)
        #echo ${arr1[@]}

        #Check if user entry is valid and is equal to a file name.
        for i in "${arr1[@]}"; do
            #echo "userpick: $userpick"
            #echo "arr1: $i"
            if [[ "$userpick" == "$i" ]]; then
                return 
            else
                continue
            fi
        done
        echo -e "Invalid input please try again.\n"
    done
}

#This function provides the user with a menu listing the search options of what columns they want to display.
columnlist(){
    while true; do
        echo -e "\n"
        echo "Enter the name of the access log you wish to query: " 
        echo "1) PROTOCOL"
        echo "2) SRC IP"
        echo "3) SRC PORT"
        echo "4) DEST IP"
        echo "5) DEST PORT"
        echo "6) PACKETS"
        echo "7) BYTES"
        echo "8) return to main menu"

        read -p "Please select an option from the menu [1, 2, 3, 4, 5, 6, 7 or 8 if you wish to return]: " menu3pick
        #Case statement will return the column name and corresponding column value in the data.
        case $menu3pick in 
            1) return_string="PROTOCOL";return_value=3;break;;
            2) return_string="SRC IP";return_value=4;break;;
            3) return_string="SRC PORT";return_value=5;break;;
            4) return_string="DEST IP";return_value=6;break;;
            5) return_string="DEST PORT";return_value=7;break;;
            6) return_string="PACKETS";return_value=8;break;;
            7) return_string="BYTES";return_value=9;break;;
            8) return;;
            *) echo -e "Invalid selection, please try again.";;
        esac
    done

    

}

#This function will allow the user to search for 1 field in the log file.
1field(){
    while true; do
        echo -e "\n"
        echo "1) Search all access logs"
        echo "2) Search 1 access log"
        echo "3) return to main menu"

        read -p "Please select an option from the menu [1, 2 or 3]: " menu2pick

        #If user has selected to search all logs in directory
        if [[ $menu2pick == "1" ]]; then
            
            columnlist
            field1s=$(echo $return_string)
            field1v=$return_value
            
            
            
            #Have not completed the packets and bytes extra functionality.
            #echo "You have selected fields: $field1s, $field2s, $field3s "
            #if [[ $field1s == "PACKETS" || $fields2s == "PACKETS" || $fields3s == "PACKETS" ]]; then
            #    packetcheck
            #if [[ $field1s == "BYTES" || $fields2s == "BYTES" || $fields3s == "BYTES" ]]; then
            #    bytecheck
            #else
            #fi


            echo "You have selected fields: $field1s "
            read -p "Please enter the path you wish you send the results to: " userpath

            #echo $field1v

            #Will go through every file and append awk results to 1 text file.
            for file in $(ls); do
                awk -v temp1=$field1v 'BEGIN {FS=","; print "'"$field1s"'       CLASS" }
                    $13 ~ /suspicious/  {
                            printf " %-13s %-s \n", $temp1, $13
                        }' $file >> "$userpath/logresults.txt"
            done

            echo "1"

        #If user only wants to search a single log file.
        elif [[ $menu2pick == "2" ]]; then
            
            singlefile

            columnlist
            field1s=$(echo $return_string)
            field1v=$return_value
           
            

            echo "You have selected fields: $field1s "
            #echo $field1v
            read -p "Please enter the path you wish you send the results to: " userpath
            
            #Awk function is used to search and output suspicious lines with the user selected field.
            awk -v temp1=$field1v 'BEGIN {FS=","; print "'"$field1s"'       CLASS" }
                $13 ~ /suspicious/  {
                        printf " %-13s %-s \n", $temp1, $13
                    }' $file > "$userpath/logresults.txt"
          
            echo "2"
        elif [[ $menu2pick == "3" ]]; then
            return
        else
            echo -e "Invalid selection, please try again.\n"
        fi

        return

    done
}


#If user wants to search for 2 fields in the log file.
2field(){
    while true; do
        echo -e "\n"
        echo "1) Search all access logs"
        echo "2) Search 1 access log"
        echo "3) return to main menu"

        read -p "Please select an option from the menu [1, 2 or 3]: " menu2pick
        
        #If user wants to search all acces logs in directory
        if [[ $menu2pick == "1" ]]; then
            
            columnlist
            field1s=$(echo $return_string)
            field1v=$return_value
            columnlist
            field2s=$(echo $return_string)
            field2v=$return_value
            
            
            #Have not completed the packets and bytes extra functionality.
            #echo "You have selected fields: $field1s, $field2s, $field3s "
            #if [[ $field1s == "PACKETS" || $fields2s == "PACKETS" || $fields3s == "PACKETS" ]]; then
            #    packetcheck
            #if [[ $field1s == "BYTES" || $fields2s == "BYTES" || $fields3s == "BYTES" ]]; then
            #    bytecheck
            #else
            #fi

            echo "You have selected fields: $field1s, $field2s "
            read -p "Please enter the path you wish you send the results to: " userpath

            #echo $field1v, $field2v

            #Go through each file in the directory and append awk results to text file.
            for file in $(ls); do
                awk -v temp1=$field1v -v temp2=$field2v 'BEGIN {FS=","; print "'"$field1s"'       '"$field2s"'       CLASS" }
                    $13 ~ /suspicious/  {
                            printf " %-13s %-13s %-s \n", $temp1, $temp2, $13
                        }' $file >> "$userpath/logresults.txt"
            done

            echo "1"

        #If user wants to only select one file to search
        elif [[ $menu2pick == "2" ]]; then
            
            singlefile

            columnlist
            field1s=$(echo $return_string)
            field1v=$return_value
            columnlist
            field2s=$(echo $return_string)
            field2v=$return_value
            

            echo "You have selected fields: $field1s, $field2s "
            #echo $field1v, $field2v
            read -p "Please enter the path you wish you send the results to: " userpath
            
            #Awk function will collect all suspicious lines and stated user input and output results to text file.
            awk -v temp1=$field1v -v temp2=$field2v  'BEGIN {FS=","; print "'"$field1s"'       '"$field2s"'       CLASS" }
                $13 ~ /suspicious/  {
                        printf " %-13s %-13s %-s \n", $temp1, $temp2, $13
                    }' $userpick > "$userpath/logresults.txt"
          
            echo "2"
        elif [[ $menu2pick == "3" ]]; then
            return
        else
            echo -e "Invalid selection, please try again.\n"
        fi

        return

    done
}

#If user wants to selected 3 fields to search in log file.
3field(){
    while true; do
        echo -e "\n"
        echo "1) Search all access logs"
        echo "2) Search 1 access log"
        echo "3) return to main menu"

        read -p "Please select an option from the menu [1, 2 or 3]: " menu2pick

        #If user wants to search all files in directory
        if [[ $menu2pick == "1" ]]; then
            #do something
            columnlist
            field1s=$(echo $return_string)
            field1v=$return_value
            columnlist
            field2s=$(echo $return_string)
            field2v=$return_value
            columnlist
            field3s=$(echo $return_string)
            field3v=$return_value
            
            #Have not completed the packets and bytes extra functionality.
            #echo "You have selected fields: $field1s, $field2s, $field3s "
            #if [[ $field1s == "PACKETS" || $fields2s == "PACKETS" || $fields3s == "PACKETS" ]]; then
            #    packetcheck
            #if [[ $field1s == "BYTES" || $fields2s == "BYTES" || $fields3s == "BYTES" ]]; then
            #    bytecheck
            #else
            #fi

            read -p "Please enter the path you wish you send the results to: " userpath

            #echo $field1v, $field2v, $field3v

            #Loop through each log file in directory and output awk results to txt file.
            for file in $(ls); do
                awk -v temp1=$field1v -v temp2=$field2v -v temp3=$field3v 'BEGIN {FS=","; print "'"$field1s"'       '"$field2s"'       '"$field3s"'       CLASS" }
                    $13 ~ /suspicious/  {
                            printf " %-13s %-13s %-13s %-s \n", $temp1, $temp2, $temp3, $13
                        }' $file >> "$userpath/logresults.txt"
            done

            echo "1"

        #If user wants to search just a single log file
        elif [[ $menu2pick == "2" ]]; then
            #do something
            singlefile

            columnlist
            field1s=$(echo $return_string)
            field1v=$return_value
            columnlist
            field2s=$(echo $return_string)
            field2v=$return_value
            columnlist
            field3s=$(echo $return_string)
            field3v=$return_value

            echo "You have selected fields: $field1s, $field2s, $field3s "
            #echo $field1v, $field2v, $field3v
            read -p "Please enter the path you wish you send the results to: " userpath
            
            #Awk function will secure the suspicious lines along with the user selected columns and output results to txt file.
            awk -v temp1=$field1v -v temp2=$field2v -v temp3=$field3v 'BEGIN {FS=","; print "'"$field1s"'       '"$field2s"'       '"$field3s"'       CLASS" }
                $13 ~ /suspicious/  {
                        printf " %-13s %-13s %-13s %-s \n", $temp1, $temp2, $temp3, $13
                    }' $userpick > "$userpath/logresults.txt"
          
            echo "2"
        elif [[ $menu2pick == "3" ]]; then
            return
        else
            echo -e "Invalid selection, please try again.\n"
        fi

        return

    done
}


#Main menu displayed to the user.
while true; do
    echo -e "\n"
    echo "1) Search 1 field"
    echo "2) Search 2 fields"
    echo "3) Search 3 fields"
    echo "4) quit"

    #Prompt the user to select an option from the menu
	read -p "Please select an option from the menu [1, 2, 3 or 4]: " menupick
    case $menupick in 
        1) 1field;;
        2) 2field;;
        3) 3field;;
        4) exit 1;;
        *) echo -e "Invalid selection, please try again.\n";;
    esac    
done

exit 0
