#!/usr/bin/python
import sys
import math

userInput = sys.argv[1]
specialChars = [' ', '!', '"', '#', '$', '%', '&', '(', ')', '*', '+', ',', '-', '.', '/', ':', ';', '<', '=', '>', '?', '@', '[', ']', '^', '_', '{', '|', '}','~', '`']
nums = ['0','1','2','3','4','6','7','8','9']
lowerChars = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
upperChars = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

# Returns true if 'special' is preseent in specialChars
def isSpecial(special):
    present = False
    for i in specialChars:
        if (special == i):
            present = True 
    return present

# Returns true if 'num' is preseent in nums
def isNum(num):
    present = False
    for i in nums:
        if (num == i):
            present = True 
    return present

# Returns true if 'lower' is preseent in lowerChars
def isLower(lower):
    present = False
    for i in lowerChars:
        if (lower == i):
            present = True 
    return present

# Returns true if 'upper' is preseent in upperChars
def isUpper(upper):
    present = False
    for i in upperChars:
        if (upper == i):
            present = True 
    return present
    
# Calculates the entropy of the password
def entropy(password):
    specialPresent = 0
    numPresent = 0
    lowerPresent = 0
    upperPresent = 0
    L = len(password)
    # Initialize R at 0
    R = 0
    for i in (password):
        if(isSpecial(i)):
            specialPresent = 31
        elif(isNum(i)):
            numPresent = 10
        elif(isLower(i)):
            lowerPresent = 26
        elif(isUpper(i)):
            upperPresent = 26
    R = specialPresent + numPresent + lowerPresent + upperPresent
    payload = R**L
    entropy = math.log(payload, 2)
    return int(entropy)


if __name__ == "__main__":
    e = entropy(userInput)
    # If the password's entropy is less than 60, we rule that it must be weak
    if(e< 60):
        sys.exit(1)
       
    # If the password's entropy is greater than 60, we rule that it still
    # has the potential to be strong
    else:
       sys.exit(0)
        