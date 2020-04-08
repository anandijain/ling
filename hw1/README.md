# hw1 comp ling: anagrams.py

## rules
*  All anagrams (=list of words) should be alphabetized.
*  Give all sets of anagrams whose length is 8 or greater, sorted by size, ordered by increasing size.
*  At the beginning of each section of a given size, print “Anagrams of size [whatever]”.
*  Within anagrams of the same size, sort by length, longest last. At the beginning of each section of a given size, print “Anagrams of length [whatever]”.
*  Among those of the same size and length, alphabetize by first word.
*  Print a table whose columns are size, whose rows are length, and whose entries are the number of anagrams.

## Points
*  2 Clear README file
*  2 Alphabetizing each word
*  2 Adding each word to dict with alphabetized word as key
*  2 Sorting output as requested
*  2 Create appropriate output report

## methods:
*  sort(s:str): returns alphabetized string
*  parse(s:str): takes in a string and removes `\n`, converts to lowercase,
*  anagrams(l:list): creates a dictionary with alphabetized words as keys, and all occurences of anagrams in sorted order as the value
*  get(d:dict, s:str): given the anagrams_dict from anagrams() and a lookup str: returns the anagrams of that word
*  make_df(): creates a dataframe, indexed by alphabetized word, with two columns, anagrams, which is the list of sorted anagrams, and count, the number of anagrams.  
