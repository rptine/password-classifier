#! /bin/bash

# Declaration of the variable, STATUS.  0 indicates strong, and if the password
# fails any of our strength tests, we update it to 1.  We will check this
# variable's value just before outputting.
STATUS="0"

# Declare an array for holding the sub-strings
declare -a arr=()

# Function will take in a substring of the password as input
function searchForSubWord() {
    LINE=1
    while read -r CURR_LINE
    do
        # Check if the line equals the substring of the password
        # If so, update our STATUS identifier to 1
        if [ "$CURR_LINE" == "$1" ]
        then
            STATUS="1"  
            break   
        fi
        LINE=$((LINE+1))
    done < "./words.txt"
}

# Function in a string and returns all contigous substrings
# that have at least 4 characters.  All substrings are added to
# the array, arr.
function generateSubs() {
    INPUT=$1
    SIZE="${#INPUT}"

    LENGTH=$((SIZE-1))
    # Initialize counter variables at 0
    counter_A=0
    # Initialize the size of the substrings at 3
    CURR_SIZE=4
    placement=$((CURR_SIZE+counter_A+1))
   
    while [ $counter_A -lt $LENGTH ]
    do
        while [ $placement -lt $SIZE ]
        do
            charsLeft="$(($LENGTH-$counter_A))" 
            if [ $charsLeft -gt 2 ]
            then 
                NEWSUB=${PASSWORD:$counter_A:$CURR_SIZE}
                arr+=( $NEWSUB )
            fi
            # Increment the current size
            CURR_SIZE=$((CURR_SIZE+1))
            # Update placement
            placement=$((CURR_SIZE+counter_A-1))
        done
        # Reset the current size back to 3
        CURR_SIZE=4
        # Increment counter_A
        counter_A=$((counter_A+1))     
         # Reset the placement
        placement=$((CURR_SIZE+counter_A-1))  
    done
}

# Collect the USER INPUT.  Either take the input they entered or start
# to read if they do not provide an immediate input.
if [ $# -eq 0 ]
  then
    read PASSWORD
 else
    PASSWORD=$1
fi

# Generate the substrings of the string, which will build up array, arr
generateSubs $PASSWORD
# Check all of the substrings in the array, arr, for a match in our wordlist
for i in ${arr[@]}; do searchForSubWord $i; done

# Call python script entropy.py to calculate the password's entropy
python entropy.py $PASSWORD

# If password's entropy was ruled to be too low by the python script,
# it will exit with code 1 (and exit with code 0 if entropy is large enough)
# If the entropy is too low, update the variable STATUS to 1. 
exitStatus=$? 
if [ $exitStatus -eq 1 ]
then
    STATUS="1"     
fi


# Finally, check the STATUS and echo out
if [ $STATUS -eq 0 ]
  then
    echo "strong"
 else
    echo "weak"
fi