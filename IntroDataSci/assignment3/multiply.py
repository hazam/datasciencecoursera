import MapReduce
import sys

mr = MapReduce.MapReduce()

# =============================
# Do not modify above this line

def mapper(record):
    # key: document identifier
    # value: document contents
    matr = record[0] #"a" or "b"
    if matr == "a":
        for i in range(5):
            mr.emit_intermediate((record[1], i), record)
    elif matr == "b":
        for i in range(5):
            mr.emit_intermediate((i, record[2]), record)

def getIJ(alist, matr, i , j):
    for v in alist:
        if v[0] == matr and v[1] == i and v[2] == j:
            return v[3]
    return 0    

def reducer(key, list_of_values):
    # key: word
    # value: list of occurrence counts
    total = 0
    for i in range(5):
        total = total + getIJ(list_of_values, "a", key[0], i) * getIJ(list_of_values, "b", i, key[1])
    res = [];
    res.extend(key)
    res.append(total)   
    mr.emit(tuple(res))


# Do not modify below this line
# =============================
if __name__ == '__main__':
  inputdata = open(sys.argv[1])
  mr.execute(inputdata, mapper, reducer)