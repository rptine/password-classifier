# Password Classifier

The program asks the user for the name of a .txt file to be encrypted/decrypted (and for the public and private keys if the user has selected to decrypt), and uses the RSA algorithm and optimal asymmetric encryption padding to encrypt/decrypt the message.

## Installing

Pull the directory as is.  The bash script which the program is launched from (classify.sh), a script for calculating password entropy (entropy.py), and a word list that the program searches (words.txt) should all be present.

## Use
To find the classification of a password,p, call the bash script classify.sh from the command line using the call "./classify p"

## Implementation 
The classification process begins by computing all of the contiguous substrings of 4 characters or more that can be created from the password the user entered. This operation is done by the script classify.sh. As the substrings are computed, they are added to the array, arr, which exists inside classify.sh. After the script fully populates the array with all of these possible substrings, it searches for each of these substrings in a word list containing the 1,500 of the common phrases found in passwords. 


## Built With

* [random](The Python Standard Library: Lib/random.py) - Library used in RSA implementation
* [math](The Python Standard Library) - Dependency Management
* [Crypto](https://github.com/dlitz/pycrypto) - Used hash functions from this library to implement padding.



## License

This project is licensed under the MIT License. The rest are copyright/licensed by their respective authors.

## Acknowledgments

* Rajesh Pavuluru, Indiana State University: http://cs.indstate.edu/~rpavuluru/Abstract.pdf.  Implemented the Rabin Miller Primality test by reading this paper.  The primality test is used when generating large primes in the RSA algorithm.

