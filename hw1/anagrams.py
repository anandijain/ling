# Anand Jain
# todo: min word len
import pandas as pd

""" 
notes:

pandas used for outside of assignment work to find most common anagrams

"""

def sort(s: str) -> str:
    # returns alphabetized string
    return ''.join(sorted(s))


def parse(s: str) -> str:
    # removes `\n` and uppercases
    return s.strip().lower()

"""
anagrams(l:list): creates a dictionary with alphabetized words as keys, 
    the value is a 2-tuple:
        [0] is all occurences of anagrams in sorted order
        [1] is the count 

"""
def anagrams(l: list) -> dict:
    d = {}
    for elt in l:
        alphabetized = sort(elt)
        try:
            if alphabetized not in d[alphabetized][0]:
                d[alphabetized][0].append(elt)
                d[alphabetized][1] += 1
        except KeyError:
            d[alphabetized] = [[elt], 1]
    return d


"""
quick fxn to get the anagrams of a word, given the anagram dictionary
and a word to lookup

assuming word is parsed (lowercase and no `\n`)
"""
def get(d: dict, s: str):
    alphabetized = sort(s)
    return d.get(alphabetized)


"""
io function to read in words file

"""
def get_words() -> list:
    f = open("english-words-235k.txt", "r")
    lines = f.readlines()
    return sorted(set(map(parse, lines)))


def main_test(test_str: str):
    lines = get_words()
    anagrams_dict = anagrams(lines)
    print(get(anagrams_dict, test_str))


def make_df():
    d = anagrams(get_words())
    df = pd.DataFrame.from_dict(d, orient='index', columns=['anagrams', 'count'])
    return df

if __name__ == "__main__":
    main_test('agnor')
