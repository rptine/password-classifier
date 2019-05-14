# Password Classifier

The program asks the user for the name of a .txt file to be encrypted/decrypted (and for the public and private keys if the user has selected to decrypt), and uses the RSA algorithm and optimal asymmetric encryption padding to encrypt/decrypt the message.

## Installing

Pull the directory as is.  The bash script which the program is launched from (classify.sh), a script for calculating password entropy (entropy.py), and a word list that the program searches (words.txt) should all be present.

## How to Use
To find the classification of a password,*sample-password*, call the bash script classify.sh from the command line using the call ```./classify.sh *sample-password*```

## Examples
```./classify.sh password```                    ```weak``` <br/>
```./classify.sh P3GtsHHbu54fq5rrmz```         ```strong```



## Implementation and Data Pipeline
### Test 1 and classify.sh
The script classify.sh begins by computing all of the contiguous substrings of 4 characters or more that can be created from the password the user entered. This operation is done by the script classify.sh. As the substrings are computed, they are added to the array, arr, which exists inside classify.sh. After the script fully populates the array with all of these possible substrings, it searches for each of these substrings in a word list containing the 1,500 of the common phrases found in passwords. The word list was obtained from:
https://github.com/danielmiessler/SecLists/blob/master/Passwords/Common-Credentials/
10k-most-common.txt.  This search is considered Test 2.

The entered password was broken into substrings before searching the wordlist to detect cases where common phrases were surrounded by randomness (for instance *2passwordQ* is considered to be a weak password because of the substring ‘password’ embedded inside).
### Test 2 and entropy.py
After the search, classifier.sh calls the python script entropy.py. This program uses the formula found at:
https://www.pleacher.com/mp/mlessons/algebra/entropy.html
to determine the password’s entropy. The entropy equation is:
* ```Entropy = log2(RL)```
where ```R``` is the size of the pool of characters (i.e. if the password only contains lower-case letters
and digits, then ```R = 26 + 10 = 36```) and ```L``` is the number of characters in the password.
```R``` to the ```L```th power is thus the total number of possible passwords, so passwords that are longer and pull from a larger character pool will have greater entropies. Passwords that are quite short, or that are on the shorter side and only use one or two pools of characters (i.e. only lower case letters and numbers), will have low entropies. Entropy is a measure of predictability; thus, passwords with high entropies are likely to be more randomized. After analysis and reading, I determined that 60 bits of entropy was a reasonable cut-off between weak and strong passwords.
If the password entropy is less than 60, then entropy.py exits with a value of 1, and otherwise exits with a value of 0. This benchmark check on the entropy is Test 2.

## Final Evaluation and classify.sh
The script classify.sh reads the exit value of the python script entropy.py and thus knows the result of Test 2.  If both Test 1 and Test 2 pass, the script echoes ```Strong``` and if either test fails, the script echoes ```Weak```.

## Reasoning
The program performs two tests:
* searching a word list the password’s substrings
* determing if the password's entropy is below or above 60
Both tests are performed because is possible for a password to contain a high entropy but also contain a phrase that is highly connected to the user and can be guessed. For example, the password: Michael2644@ has a relatively high entropy (greater than 60) because it contains capital and lower case letters, as well as numbers and special characters. However, it contains the phrase “Michael” which increases the chances the password will be guessed and decreases its strength. I thus search for common phrases found in passwords in addition to calculating entropy.



## Built With
* [math] (The Python Standard Library) - Dependency Management


## License

This project is licensed under the MIT License. The rest are copyright/licensed by their respective authors.

## Acknowledgments

* Rajesh Pavuluru, Indiana State University: http://cs.indstate.edu/~rpavuluru/Abstract.pdf.  Implemented the Rabin Miller Primality test by reading this paper.  The primality test is used when generating large primes in the RSA algorithm.

