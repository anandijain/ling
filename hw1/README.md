# hw1 comp ling

# anagrams.py

## methods:
* sort(s:str): returns alphabetized string
* parse(s:str): takes in a string and removes `\n`, converts to lowercase,
* anagrams(l:list): creates a dictionary with alphabetized words as keys, and all occurences of anagrams in sorted order as the value
* get(d:dict, s:str): given the anagrams_dict from anagrams() and a lookup str: returns the anagrams of that word
* make_df(): creates a dataframe, indexed by alphabetized word, with two columns, anagrams, which is the list of sorted anagrams, and count, the number of anagrams.  
