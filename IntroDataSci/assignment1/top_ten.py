# -*- coding: utf8 -*-

import sys
import operator
reload(sys)

import json
import re

words = dict()

def remove_links(text):
    regex = "(http|https)://[\w\-]+(\.[\w\-]+)+\S*"
    return re.sub(regex,"",text)

def filter_text(tweet_text):
    #tweet_text = remove_links(tweet_text)
    return tweet_text       

def process_tweets(tweet_file):
    for line in tweet_file.readlines():
        line = unicode(line.decode('ascii','ignore'))
        tweet_json = json.loads(line)
        if "entities" in tweet_json:
            if "hashtags" in tweet_json["entities"]:
                tags = tweet_json["entities"]["hashtags"]
                for tag in tags:
                    tag_text = tag["text"]
                    words[tag_text] = words.get(tag_text,0) + 1
                    
def dump_result():
    sorted_x = sorted(words.iteritems(), key=operator.itemgetter(1), reverse=True)
    for i in range(10):        
        print sorted_x[i][0]+" "+str(int(sorted_x[i][1]))
    

def main():
    tweet_file = open(sys.argv[1])
    process_tweets(tweet_file)
    dump_result()
    
if __name__ == '__main__':
    main()