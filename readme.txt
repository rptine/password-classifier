The scripts do not need to be configured or installed.
One should simply run:
./classify.sh password

The script classify.sh performs the initial operations of the classification process - computing all contiguous substrings of the password, followed by searching for them in the word list, words.txt, which is a file included in the zip.

There are no calls to setup.sh.

classify.sh calls the python script entropy.py which is a file also included in the zip.  entropy.py exits with a status code of 1 to indicate insufficient password entropy, and exits with a code of 0 to indicate sufficient password entropy.
