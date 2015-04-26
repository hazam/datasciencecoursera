import sys
import json
import math
import operator

def distance(origin, destination):
    lat1, lon1 = origin
    lat2, lon2 = destination
    radius = 6371  # km

    dlat = math.radians(lat2 - lat1)
    dlon = math.radians(lon2 - lon1)
    a = math.sin(dlat / 2) * math.sin(dlat / 2) + math.cos(math.radians(lat1)) \
        * math.cos(math.radians(lat2)) * math.sin(dlon / 2) * math.sin(dlon / 2)
    c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a))
    d = radius * c

    return d

states = {
'AK': (61.3850, -152.2683),
'AL': (32.7990, -86.8073),
'AR': (34.9513, -92.3809),
'AS': (14.2417, -170.7197),
'AZ': (33.7712, -111.3877),
'CA': (36.1700, -119.7462),
'CO': (39.0646, -105.3272),
'CT': (41.5834, -72.7622),
'DC': (38.8964, -77.0262),
'DE': (39.3498, -75.5148),
'FL': (27.8333, -81.7170),
'GA': (32.9866, -83.6487),
'HI': (21.1098, -157.5311),
'IA': (42.0046, -93.2140),
'ID': (44.2394, -114.5103),
'IL': (40.3363, -89.0022),
'IN': (39.8647, -86.2604),
'KS': (38.5111, -96.8005),
'KY': (37.6690, -84.6514),
'LA': (31.1801, -91.8749),
'MA': (42.2373, -71.5314),
'MD': (39.0724, -76.7902),
'ME': (44.6074, -69.3977),
'MI': (43.3504, -84.5603),
'MN': (45.7326, -93.9196),
'MO': (38.4623, -92.3020),
'MP': (14.8058, 145.5505),
'MS': (32.7673, -89.6812),
'MT': (46.9048, -110.3261),
'NC': (35.6411, -79.8431),
'ND': (47.5362, -99.7930),
'NE': (41.1289, -98.2883),
'NH': (43.4108, -71.5653),
'NJ': (40.3140, -74.5089),
'NM': (34.8375, -106.2371),
'NV': (38.4199, -117.1219),
'NY': (42.1497, -74.9384),
'OH': (40.3736, -82.7755),
'OK': (35.5376, -96.9247),
'OR': (44.5672, -122.1269),
'PA': (40.5773, -77.2640),
'PR': (18.2766, -66.3350),
'RI': (41.6772, -71.5101),
'SC': (33.8191, -80.9066),
'SD': (44.2853, -99.4632),
'TN': (35.7449, -86.7489),
'TX': (31.1060, -97.6475),
'UT': (40.1135, -111.8535),
'VA': (37.7680, -78.2057),
'VI': (18.0001, -64.8199),
'VT': (44.0407, -72.7093),
'WA': (47.3917, -121.5708),
'WI': (44.2563, -89.6385),
'WV': (38.4680, -80.9696),
'WY': (42.7475, -107.2085)
}

words = dict()
statesHappy = dict()

def load_sentiment(sent_file):
    for line in sent_file.readlines():
        word, sentiment = line.split('\t', 1)
        # needed to decode as utf-8 since strange character in FINN
        words[word.decode("utf-8")] = float(sentiment)
        
def find_nearest_state(coords):
    min_state = [None, -1.0]    
    for state in states.keys():
        state_d = distance(coords, states[state])
        if (state_d < min_state[1] or min_state[1] < 0):
            min_state[0] = state
            min_state[1] = state_d
    return min_state

def process_tweets(tweet_file):
    for line in tweet_file.readlines():
        tweet_json = json.loads(line)
        coords = tweet_json.get("coordinates", None)
        if coords != None:            
            if "text" in tweet_json:
                #compute setiment
                tweet_sentiment = 0.0
                tweet_text = tweet_json["text"].lower()
                for word in words.keys():
                    if tweet_text.find(word) != -1:
                        tweet_sentiment += words[word]
                #print str(tweet_sentiment)
                tu = find_nearest_state(coords.get('coordinates'))
                statesHappy[tu[0]] = statesHappy.get(tu[0], 0) + tu[1]


def dump_result():
    sorted_x = sorted(statesHappy.iteritems(), key=operator.itemgetter(1), reverse=True)
    print sorted_x[0][0]

def main():
    sent_file = open(sys.argv[1])
    tweet_file = open(sys.argv[2])
    load_sentiment(sent_file)
    process_tweets(tweet_file)
    dump_result()

if __name__ == '__main__':
    main()
