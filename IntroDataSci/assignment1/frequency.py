# -*- coding: utf8 -*-

import sys
reload(sys)

import json
import re
import unicodedata as ud

latin_letters={}
def is_latin(uchr):
    try:
        return latin_letters[uchr]
    except KeyError:
        return latin_letters.setdefault(uchr, 'LATIN' in ud.name(uchr))

def only_roman_chars(unistr):
    return all(is_latin(uchr)
               for uchr in unistr
               if uchr.isalpha())

words = dict()

def ispunctuation(ch):
    return ch in ' .;:!?"&+-\'()[]{}~`=-_'

def remove_links(text):
    regex = "(http|https)://[\w\-]+(\.[\w\-]+)+\S*"
    return re.sub(regex,"",text)

def filter_text(tweet_text):
    return remove_links(tweet_text)

def process_tweets(tweet_file):
    for line in tweet_file.readlines():
        line = unicode(line.decode('ascii','ignore'))
        tweet_json = json.loads(line)
        if "text" in tweet_json:
            tweet_text = unicode( filter_text( tweet_json["text"]).encode('ascii','ignore'))
            tweet_words = tweet_text.split(' ')
            for word in tweet_words:
                word = word.strip()
                word = re.sub('\n',"",word)
                if len(word) > 0:
                    words[word] = words.get(word,0) + 1

def dump_result():
    occurences = 0.0
    for v in words.keys():
        occurences += words[v]
    for v in words.keys():
        print v+" "+str(words[v]/occurences)

def main():
    tweet_file = open(sys.argv[1])
    process_tweets(tweet_file)
    dump_result()
    
if __name__ == '__main__':
    main()